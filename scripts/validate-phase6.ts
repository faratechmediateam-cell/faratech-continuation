/**
 * Phase 6 validator — checks SEO metadata + JSON-LD outputs against the
 * authoritative database. Run with:
 *
 *   bun run scripts/validate-phase6.ts
 *
 * The script must finish with `OK` and a zero exit code.
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
const key = process.env.SUPABASE_SERVICE_ROLE_KEY ?? process.env.SUPABASE_PUBLISHABLE_KEY ?? process.env.VITE_SUPABASE_PUBLISHABLE_KEY;
if (!url || !key) {
  console.error("SUPABASE_URL / KEY env vars are required");
  process.exit(1);
}

const supabase = createClient(url, key);

type Check = { name: string; ok: boolean; detail?: string };
const checks: Check[] = [];
const record = (name: string, ok: boolean, detail?: string) =>
  checks.push({ name, ok, detail });

function isValidJsonLd(raw: string, expectedType: string): boolean {
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
    record("Organization JSON-LD: valid @type", isValidJsonLd(ld, "Organization"));
    const parsed = JSON.parse(ld);
    record(
      "Organization JSON-LD: has contactPoint when phones exist",
      profile.contact.phones.length === 0 || Array.isArray(parsed.contactPoint),
    );
    record(
      "Organization JSON-LD: no fabricated values when profile is null",
      JSON.parse(organizationJsonLd(null)).contactPoint === undefined,
    );
  }
}

// ---------- Products + FAQ ----------
{
  const { data: products, error } = await supabase
    .from("products")
    .select("*")
    .eq("status", "PUBLISHED");
  if (error || !products?.length) {
    record("Products: at least one PUBLISHED row", false, error?.message);
  } else {
    let productOk = 0;
    let faqOk = 0;
    let faqSkipped = 0;
    for (const row of products) {
      const id = row.id as string;
      const [imgs, vids, docs, groups, items, certs, faqs, seo, related] = await Promise.all([
        supabase.from("product_images").select("*").eq("product_id", id),
        supabase.from("product_videos").select("*").eq("product_id", id),
        supabase.from("product_documents").select("*").eq("product_id", id),
        supabase.from("specification_groups").select("*").eq("product_id", id),
        supabase.from("specification_items").select("*"),
        supabase.from("certifications").select("*").eq("product_id", id),
        supabase.from("faq_items").select("*").eq("product_id", id),
        supabase.from("product_seo").select("*").eq("product_id", id).maybeSingle(),
        supabase.from("related_products").select("*").eq("product_id", id),
      ]);
      const detail = mapProductDetail({
        product: row as Record<string, unknown>,
        images: (imgs.data ?? []) as Record<string, unknown>[],
        videos: (vids.data ?? []) as Record<string, unknown>[],
        documents: (docs.data ?? []) as Record<string, unknown>[],
        specificationGroups: (groups.data ?? []) as Record<string, unknown>[],
        specificationItems: (items.data ?? []) as Record<string, unknown>[],
        certifications: (certs.data ?? []) as Record<string, unknown>[],
        faqItems: (faqs.data ?? []) as Record<string, unknown>[],
        seo: (seo.data ?? null) as Record<string, unknown> | null,
        relatedSlugs: ((related.data ?? []) as { related_slug: string }[]).map((r) => r.related_slug),
      });
      const productLd = productJsonLd(detail, { lang: "fa", categoryLabel: detail.categoryKey });
      if (isValidJsonLd(productLd, "Product")) productOk++;

      const faqLd = faqJsonLd(detail.faqItems, "fa");
      if (detail.faqItems.length === 0) {
        if (faqLd === null) faqSkipped++;
      } else if (faqLd && isValidJsonLd(faqLd, "FAQPage")) {
        faqOk++;
      }
    }
    record("Product JSON-LD: valid for every PUBLISHED product", productOk === products.length, `${productOk}/${products.length}`);
    const withFaq = products.filter((_, i) => i < products.length).length; // placeholder
    record(
      "FAQ JSON-LD: emitted only when FAQs exist",
      faqOk + faqSkipped === products.length,
      `valid=${faqOk}, correctly_skipped=${faqSkipped}, total=${withFaq}`,
    );
  }
}

// ---------- Locale meta / canonical ----------
{
  const meta = buildLocaleMeta("fa", (l) => `/${l}/products`);
  const canonical = meta.links.find((l) => l.rel === "canonical");
  record("Canonical link present for product index", !!canonical && canonical.href.includes("/fa/products"));
  const xDefault = meta.links.find((l) => "hrefLang" in l && l.hrefLang === "x-default");
  record("hreflang x-default points to fa", !!xDefault && (xDefault as { href: string }).href.includes("/fa/"));
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
