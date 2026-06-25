/**
 * Phase 5 validator.
 *
 * Verifies that the Supabase database matches the static master files that
 * were used to seed it:
 *   - record counts (products, categories, specs, certifications, FAQs)
 *   - slug integrity (every MASTER_PRODUCTS slug exists in `public.products`
 *     and every MASTER_CATEGORY_COPY slug exists in `public.category_copy`)
 *   - company_profile has exactly one row
 *
 * Run with:
 *   bun run scripts/validate-phase5.ts
 *
 * Requires SUPABASE_URL + SUPABASE_PUBLISHABLE_KEY in the environment.
 */
import { createClient } from "@supabase/supabase-js";
import { MASTER_PRODUCTS } from "../src/lib/data/products-master";
import { MASTER_CATEGORY_COPY } from "../src/lib/data/category-copy";

const url = process.env.SUPABASE_URL;
const key = process.env.SUPABASE_PUBLISHABLE_KEY;
if (!url || !key) {
  console.error("Missing SUPABASE_URL / SUPABASE_PUBLISHABLE_KEY");
  process.exit(2);
}

const sb = createClient(url, key);

const fail: string[] = [];
const ok = (msg: string) => console.log(`  ✓ ${msg}`);
const bad = (msg: string) => {
  fail.push(msg);
  console.log(`  ✗ ${msg}`);
};

async function count(table: string, filter?: (q: any) => any) {
  let q = sb.from(table).select("*", { count: "exact", head: true });
  if (filter) q = filter(q);
  const { count: c, error } = await q;
  if (error) throw new Error(`${table}: ${error.message}`);
  return c ?? 0;
}

(async () => {
  console.log("Phase 5 — data import validation\n");

  const expectedProducts = MASTER_PRODUCTS.length;
  const expectedCopies = MASTER_CATEGORY_COPY.length;

  const products = await count("products");
  const published = await count("products", (q) => q.eq("status", "PUBLISHED"));
  const copies = await count("category_copy");
  const company = await count("company_profile");
  const specGroups = await count("specification_groups");
  const specItems = await count("specification_items");
  const certs = await count("certifications");
  const faqs = await count("faq_items");

  products === expectedProducts
    ? ok(`products: ${products} (expected ${expectedProducts})`)
    : bad(`products: ${products} (expected ${expectedProducts})`);
  published === expectedProducts
    ? ok(`products PUBLISHED: ${published}`)
    : bad(`products PUBLISHED: ${published} (expected ${expectedProducts})`);
  copies === expectedCopies
    ? ok(`category_copy: ${copies} (expected ${expectedCopies})`)
    : bad(`category_copy: ${copies} (expected ${expectedCopies})`);
  company === 1
    ? ok("company_profile: 1 row")
    : bad(`company_profile: ${company} (expected 1)`);
  specGroups > 0 ? ok(`specification_groups: ${specGroups}`) : bad("specification_groups empty");
  specItems > 0 ? ok(`specification_items: ${specItems}`) : bad("specification_items empty");
  certs > 0 ? ok(`certifications: ${certs}`) : bad("certifications empty");
  faqs > 0 ? ok(`faq_items: ${faqs}`) : bad("faq_items empty");

  // Slug integrity
  const { data: dbProductSlugs, error: e1 } = await sb
    .from("products")
    .select("slug");
  if (e1) throw e1;
  const dbSlugSet = new Set((dbProductSlugs ?? []).map((r) => r.slug));
  const missingProducts = MASTER_PRODUCTS.map((m) => m.slug).filter(
    (s) => !dbSlugSet.has(s),
  );
  missingProducts.length === 0
    ? ok("every MASTER_PRODUCTS slug exists in DB")
    : bad(`missing product slugs: ${missingProducts.join(", ")}`);

  const { data: dbCopySlugs, error: e2 } = await sb
    .from("category_copy")
    .select("slug");
  if (e2) throw e2;
  const dbCopySet = new Set((dbCopySlugs ?? []).map((r) => r.slug));
  const missingCopies = MASTER_CATEGORY_COPY.map((c) => c.key).filter(
    (s) => !dbCopySet.has(s),
  );
  missingCopies.length === 0
    ? ok("every MASTER_CATEGORY_COPY slug exists in DB")
    : bad(`missing category_copy slugs: ${missingCopies.join(", ")}`);

  console.log();
  if (fail.length > 0) {
    console.error(`FAILED with ${fail.length} issue(s).`);
    process.exit(1);
  }
  console.log("All Phase 5 invariants hold ✓");
})().catch((e) => {
  console.error(e);
  process.exit(1);
});
