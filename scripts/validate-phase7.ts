/**
 * Phase 7 validator — checks media integration invariants.
 *
 *   bun run scripts/validate-phase7.ts
 */
import { createClient } from "@supabase/supabase-js";
import {
  MEDIA_BUCKET,
  MEDIA_PROXY_PREFIX,
  resolveMediaUrl,
  isResolvedMediaUrl,
} from "../src/lib/media-url";
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
type Check = { name: string; ok: boolean; detail?: string };
const checks: Check[] = [];
const record = (name: string, ok: boolean, detail?: string) =>
  checks.push({ name, ok, detail });

// ---------- Bucket exists ----------
{
  const { data, error } = await supabase.storage.getBucket(MEDIA_BUCKET);
  record(
    `Storage bucket '${MEDIA_BUCKET}' exists`,
    !error && !!data,
    error?.message,
  );
  if (data) {
    record(
      `Bucket '${MEDIA_BUCKET}' is private (served via proxy)`,
      data.public === false,
      `public=${data.public}`,
    );
  }
}

// ---------- URL resolver ----------
{
  record(
    "resolveMediaUrl: passes absolute URL through",
    resolveMediaUrl("https://cdn.example/x.jpg") === "https://cdn.example/x.jpg",
  );
  record(
    "resolveMediaUrl: passes site-rooted path through",
    resolveMediaUrl("/wheelchair-hero.png") === "/wheelchair-hero.png",
  );
  record(
    "resolveMediaUrl: maps bucket key to proxy route",
    resolveMediaUrl("gx-pro/cover.jpg") === `${MEDIA_PROXY_PREFIX}/gx-pro/cover.jpg`,
  );
  record(
    "resolveMediaUrl: empty input returns empty",
    resolveMediaUrl(null) === "" && resolveMediaUrl(undefined) === "" && resolveMediaUrl("") === "",
  );
  record("isResolvedMediaUrl: detects https", isResolvedMediaUrl("https://x"));
  record("isResolvedMediaUrl: detects rooted path", isResolvedMediaUrl("/a.png"));
  record("isResolvedMediaUrl: rejects bare key", !isResolvedMediaUrl("a.png"));
}

// ---------- Mapper resolution ----------
{
  const { data, error } = await supabase
    .from("products")
    .select(`
      *,
      product_images(*),
      product_videos(*),
      product_documents(*),
      specification_groups(*, specification_items(*)),
      certifications(*),
      faq_items(*),
      product_seo(*)
    `)
    .eq("status", "PUBLISHED");

  if (error) {
    record("Products fetch for mapper check", false, error.message);
  } else {
    const rows = (data ?? []) as Record<string, unknown>[];
    let badImage = 0;
    let badVideo = 0;
    let badDoc = 0;
    for (const row of rows) {
      const d = mapProductDetail(row);
      for (const i of d.images) if (i.src && !isResolvedMediaUrl(i.src)) badImage++;
      for (const v of d.videos) {
        if (v.src && !isResolvedMediaUrl(v.src)) badVideo++;
        if (v.poster && !isResolvedMediaUrl(v.poster)) badVideo++;
      }
      for (const doc of d.documents) if (doc.src && !isResolvedMediaUrl(doc.src)) badDoc++;
    }
    record(`All image src values resolved (${rows.length} products)`, badImage === 0, `${badImage} unresolved`);
    record(`All video src/poster values resolved`, badVideo === 0, `${badVideo} unresolved`);
    record(`All document src values resolved`, badDoc === 0, `${badDoc} unresolved`);
  }
}

// ---------- Proxy route file present ----------
{
  const path = new URL("../src/routes/api.public.media.$.ts", import.meta.url);
  let exists = true;
  try {
    await Bun.file(path).text();
  } catch {
    exists = false;
  }
  record("Public media proxy route exists", exists, path.pathname);
}

// ---------- Report ----------
let failed = 0;
for (const c of checks) {
  const tag = c.ok ? "PASS" : "FAIL";
  if (!c.ok) failed++;
  console.log(`[${tag}] ${c.name}${c.detail ? ` — ${c.detail}` : ""}`);
}
console.log(`\n${checks.length - failed}/${checks.length} checks passed.`);
process.exit(failed === 0 ? 0 : 1);
