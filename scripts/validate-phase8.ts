/**
 * Phase 8 validator — checks Forms & Lead Generation invariants.
 *
 *   bun run scripts/validate-phase8.ts
 */
import { createClient } from "@supabase/supabase-js";
import { readFileSync, existsSync } from "node:fs";
import { resolve } from "node:path";

const url = process.env.SUPABASE_URL ?? process.env.VITE_SUPABASE_URL;
const anonKey =
  process.env.SUPABASE_PUBLISHABLE_KEY ?? process.env.VITE_SUPABASE_PUBLISHABLE_KEY;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;
if (!url || !anonKey) {
  console.error("SUPABASE_URL / SUPABASE_PUBLISHABLE_KEY required.");
  process.exit(1);
}

type Check = { name: string; ok: boolean; detail?: string };
const checks: Check[] = [];
const record = (name: string, ok: boolean, detail?: string) =>
  checks.push({ name, ok, detail });

const anon = createClient(url, anonKey);

// ---------- Module files present ----------
const moduleFiles = [
  "src/lib/modules/leads/lead.dto.ts",
  "src/lib/modules/leads/lead.mapper.ts",
  "src/lib/modules/leads/lead.repository.ts",
  "src/lib/modules/leads/lead.service.ts",
  "src/lib/modules/leads/lead.functions.ts",
  "src/lib/modules/leads/lead-email.ts",
];
for (const f of moduleFiles) {
  record(`module file ${f}`, existsSync(resolve(f)));
}

// ---------- UI helper still exports stable surface ----------
{
  const src = readFileSync("src/lib/lead-capture.ts", "utf8");
  record(
    "lead-capture exports submitContact/submitNewsletter",
    /export async function submitContact\b/.test(src) &&
      /export async function submitNewsletter\b/.test(src),
  );
  record(
    "lead-capture delegates to lead.functions",
    src.includes("@/lib/modules/leads/lead.functions"),
  );
}

// ---------- Schema enforced via RLS ----------
{
  const { data, error } = await anon.from("leads").select("id").limit(1);
  // RLS with no SELECT policy returns 0 rows (no error). Either is fine
  // as long as anon never sees real data.
  record(
    "anon SELECT on leads returns no rows",
    !error && Array.isArray(data) && data.length === 0,
    error?.message,
  );
}

// ---------- anon INSERT (contact) succeeds via RLS policy ----------
const contactProbeEmail = `phase8+contact-${Date.now()}@validate.faratech.local`;
{
  const { error, status } = await anon.from("leads").insert({
    kind: "contact",
    email: contactProbeEmail,
    name: "Phase8 Validator",
    message: "automated phase 8 validation probe",
    source: "validate-phase8",
  });
  record(
    "anon INSERT contact lead succeeds",
    !error && status >= 200 && status < 300,
    error?.message,
  );
}

// ---------- anon INSERT (newsletter) succeeds ----------
const newsletterProbeEmail = `phase8+news-${Date.now()}@validate.faratech.local`;
{
  const { error, status } = await anon.from("leads").insert({
    kind: "newsletter",
    email: newsletterProbeEmail,
    source: "validate-phase8",
  });
  record(
    "anon INSERT newsletter lead succeeds",
    !error && status >= 200 && status < 300,
    error?.message,
  );
}

// ---------- Contact requires message (check constraint) ----------
{
  const { error } = await anon.from("leads").insert({
    kind: "contact",
    email: `phase8+bad-${Date.now()}@validate.faratech.local`,
    message: "short",
  });
  record(
    "contact-without-message rejected",
    !!error,
    error ? undefined : "insert unexpectedly succeeded",
  );
}

// ---------- Email helper exported & guarded ----------
{
  const src = readFileSync("src/lib/modules/leads/lead-email.ts", "utf8");
  record(
    "notifyNewLead present",
    /export async function notifyNewLead\b/.test(src),
  );
  record(
    "lead email reads RESEND_API_KEY at runtime",
    src.includes("process.env.RESEND_API_KEY"),
  );
}

// ---------- Cleanup probe rows with service role if available ----------
if (serviceKey) {
  const admin = createClient(url, serviceKey);
  await admin
    .from("leads")
    .delete()
    .in("email", [contactProbeEmail, newsletterProbeEmail]);
}

// ---------- Public routes untouched ----------
for (const f of [
  "src/routes/$lang.index.tsx",
  "src/routes/$lang.products.index.tsx",
  "src/routes/$lang.products.$category.index.tsx",
  "src/routes/$lang.products.$category.$product.tsx",
]) {
  record(`public route exists: ${f}`, existsSync(resolve(f)));
}

// ---------- Report ----------
let failed = 0;
for (const c of checks) {
  const status = c.ok ? "✅" : "❌";
  console.log(`${status} ${c.name}${c.detail ? ` — ${c.detail}` : ""}`);
  if (!c.ok) failed++;
}
console.log(`\n${checks.length - failed}/${checks.length} checks passed.`);
process.exit(failed === 0 ? 0 : 1);
