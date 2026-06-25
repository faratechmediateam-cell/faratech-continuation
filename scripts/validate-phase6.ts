/**
 * Phase 6 validator — checks SEO metadata + JSON-LD outputs against the
 * authoritative database.
 *
 *   bun run scripts/validate-phase6.ts
 */

import { createClient } from "@supabase/supabase-js";
import {
  buildLocaleMeta,
  faqJsonLd,
  organizationJsonLd,
  productJsonLd,
} from "../src/lib/seo";
import { mapCompanyProfile } from "../src/lib/modules/company/company.mapper";
import { mapProductDetail } from "../src/lib/modules/products/product.mapper";

const url = process.env.SUPABASE_URL ?? process.env.VITE_SUPABASE_URL;
const key =
  process.env.SUPABASE_SERVICE_ROLE_KEY ??
  process.env.SUPABASE_PUBLISHABLE_KEY ??
  process.env.VITE_SUPABASE_PUBLISHABLE_KEY;
if (!url || !key) {
  console.error("SUPABASE_URL / SUPABASE_(SERVICE_ROLE|PUBLISHABLE)_KEY required.");
  process.exit(1);
}

const supabase = createClient(url, key);

const DETAIL_SELECT = `
  *,
  product_images(*),
  product_videos(*),
  product_documents(*),
  specification_groups(*, specification_items(*)),
  certifications(*),
  faq_items(*),
  product_seo(*)
`;

type Check = { name: string; ok: boolean; detail?: string };
const checks: Check[] = [];
const record = (name: string, ok: boolean, detail?: string) =>
  checks.push({ name, ok, detail });

function validJsonLd(raw: string | null, expectedType: string): boolean {
  if (!raw) return false;
  try {
    const parsed = JSON.parse(raw) as Record<string, unknown>;
    return (
      parsed["@context"] === "https://schema.org" &&
      parsed["@type"] === expectedType
    );
  } catch {
    return false;
  }
}

// ---------- Organization ----------
{
  const { data, error } = await supabase
    .from("company_profile")
    .select("*")
    .eq("id", "default")
    .maybeSingle();
  if (error || !data) {
    record("Organization: company_profile row exists", false, error?.message);
  } else {
    const profile = mapCompanyProfile(data as Record<string, unknown>);
    const ld = organizationJsonLd(profile);
    record("Organization JSON-LD: valid @type", validJsonLd(ld, "Organization"));
    const parsed = JSON.parse(ld);
    record(
      "Organization JSON-LD: contactPoint present when phones exist",
      profile.contact.phones.length === 0 || Array.isArray(parsed.contactPoint),
    );
    record(
      "Organization JSON-LD: no fabricated data on null profile",
      JSON.parse(organizationJsonLd(null)).contactPoint === undefined,
    );
  }
}

// ---------- Products + FAQ ----------
{
  const { data: products, error } = await supabase
    .from("products")
    .select(DETAIL_SELECT)
    .eq("status", "PUBLISHED");
  if (error || !products?.length) {
    record("Products: PUBLISHED rows present", false, error?.message);
  } else {
    let productOk = 0;
    let faqOk = 0;
    let faqSkipped = 0;
    let withFaq = 0;
    for (const row of products as Record<string, unknown>[]) {
      const detail = mapProductDetail(row);
      const productLd = productJsonLd(detail, {
        lang: "fa",
        categoryLabel: detail.categoryKey,
      });
      if (validJsonLd(productLd, "Product")) productOk++;

      const faqLd = faqJsonLd(detail.faqItems, "fa");
      if (detail.faqItems.length === 0) {
        if (faqLd === null) faqSkipped++;
      } else {
        withFaq++;
        if (validJsonLd(faqLd, "FAQPage")) faqOk++;
      }
    }
    record(
      "Product JSON-LD: valid for every PUBLISHED product",
      productOk === products.length,
      `${productOk}/${products.length}`,
    );
    record(
      "FAQ JSON-LD: emitted iff FAQs exist",
      faqOk === withFaq && faqSkipped + withFaq === products.length,
      `withFaq=${withFaq} valid=${faqOk} skipped=${faqSkipped} total=${products.length}`,
    );
  }
}

// ---------- Locale meta / canonical / hreflang ----------
{
  const meta = buildLocaleMeta("fa", (l) => `/${l}/products`);
  const canonical = meta.links.find((l) => l.rel === "canonical");
  record(
    "Canonical link present for product index",
    !!canonical && canonical.href.includes("/fa/products"),
  );
  const xDefault = meta.links.find(
    (l) => "hrefLang" in l && (l as { hrefLang?: string }).hrefLang === "x-default",
  );
  record(
    "hreflang x-default points to fa",
    !!xDefault && (xDefault as { href: string }).href.includes("/fa/"),
  );
  const langs = meta.links
    .filter((l) => "hrefLang" in l)
    .map((l) => (l as { hrefLang: string }).hrefLang);
  record(
    "hreflang alternates cover en/fa/ar + x-default",
    ["en", "fa", "ar", "x-default"].every((c) => langs.includes(c)),
  );
}

// ---------- Public routes reachable (sanity) ----------
{
  const slugCheck = await supabase
    .from("products")
    .select("slug,category_key,status")
    .eq("status", "PUBLISHED");
  record(
    "All PUBLISHED products have slug + category_key (route generation safe)",
    !slugCheck.error &&
      !!slugCheck.data &&
      slugCheck.data.every((p) => !!p.slug && !!p.category_key),
  );
}

// ---------- Report ----------
let failed = 0;
for (const c of checks) {
  const tag = c.ok ? "PASS" : "FAIL";
  console.log(`[${tag}] ${c.name}${c.detail ? ` — ${c.detail}` : ""}`);
  if (!c.ok) failed++;
}
if (failed > 0) {
  console.error(`\n${failed} check(s) failed.`);
  process.exit(1);
}
console.log("\nOK");
