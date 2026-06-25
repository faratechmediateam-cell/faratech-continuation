## Current completed phase

Phase 4 — Data Wiring (per `docs/# 007_AI_HANDOFF.md` and `# 008_SESSION_SUMMARY.md`).
Routes, services, repositories and adapters are in place; product/category/company pages already read through server functions, but the DB tables are still empty and `src/lib/products.ts` overlays editorial data from the static masters at runtime.

## Next phase

Phase 5 — Data Import. Objectives from the handoff:
- Import products
- Import company profile
- Import category content
- Validate imported records
- Remove remaining runtime dependency on static data

Out of scope (future phases): SEO foundation rewiring (Phase 6), media/images storage (Phase 7), forms (Phase 8).

## Architectural decisions (reusing what exists)

- Stay on Repository → Service → Server-Function → Loader.
- Seed via a Supabase SQL migration (the project already ships SQL migrations under `supabase/migrations/`).
- Add the only missing table — `category_copy` — for category editorial copy that the schema doesn't yet model. Categories themselves remain an enum.
- Extend, not rewrite, `CategoryRepository`, `CategoryService`, `CategoryDto`, `category.mapper.ts` to surface the new editorial fields.
- Keep `seo.ts`'s use of `COMPANY_PROFILE` for now — JSON-LD rewiring is explicitly Phase 6. Phase 5 removes runtime dependency for product/category/company *page rendering*, which is what the handoff scopes.

## Files to add

1. `supabase/migrations/<ts>_phase5_category_copy_table.sql`
   - `CREATE TABLE public.category_copy` keyed by `product_category_key` enum: `title`, `short_description`, `full_description`, `usage`, `target_audience` (all `jsonb` localized). GRANTs + RLS public-read.
2. `supabase/migrations/<ts>_phase5_seed_data.sql`
   - Idempotent `INSERT ... ON CONFLICT DO UPDATE` for: `company_profile` (single row from `COMPANY_PROFILE`), `category_copy` (5 rows from `MASTER_CATEGORY_COPY`), `products` + `specification_groups` + `specification_items` + `certifications` + `faq_items` derived from `MASTER_PRODUCTS`. Status = `'PUBLISHED'` for `published`, otherwise `'DRAFT'`. Logs a row into `migration_log`.
   - No images yet (Phase 7 owns media).
3. `scripts/generate-phase5-seed.ts`
   - Node script that reads `src/lib/data/*.ts` and emits the seed SQL above. Keeps the migration regeneratable and traceable to the canonical Persian sources.

## Files to modify

4. `src/lib/modules/categories/category.dto.ts` — add optional `copy: { title; shortDescription; fullDescription; usage; targetAudience }` (all `LocalizedText | null`).
5. `src/lib/modules/categories/category.repository.ts` — add `findAllCopy()` reading `category_copy` via `getServerSupabase()`.
6. `src/lib/modules/categories/category.mapper.ts` — add `mapCategoryCopy(row)` and let `mapCategory` accept the editorial copy.
7. `src/lib/modules/categories/category.service.ts` — combine counts + copy.
8. `src/lib/modules/categories/category.functions.ts` — already-present `listCategories` keeps the same signature; only DTO grows (additive).
9. `src/lib/products-db-adapter.ts` — read category copy from the DTO instead of importing `MASTER_CATEGORY_COPY`. Drop the static import.
10. `src/lib/products.ts` — remove the runtime `applyMasterOverlay()` call and the `MASTER_PRODUCTS` / `MASTER_CATEGORY_COPY` imports. Keep the in-memory `CATEGORIES` skeleton (used by nav/footer/admin form selects) — admin pages are out of Phase-5 scope.
11. `src/lib/data/README.md` (new short note) — mark the three static files as archived editorial sources retained only for re-seeding; runtime no longer reads them.

## Validation

12. `src/lib/modules/shared/import-validation.ts` + `src/routes/api/public/validate-import.ts` — a small server route that returns counts per table and flags missing/duplicate slugs, runnable post-migration to satisfy the "Validate imported records" objective.

## Why these changes are required

- The DB tables exist (Phase 3) and the read path is wired (Phase 4) but nothing has been inserted — the public site currently renders only because the legacy `products.ts` overlay still runs in-process. Phase 5's whole point is to flip that.
- A `category_copy` table is the smallest addition needed so the long Persian editorial copy stops living only in `category-copy.ts`.
- Extending the existing Category layer (rather than adding a new module) preserves the Repository / Service / DTO / Mapper architecture mandated by the handoff.
- Removing the `applyMasterOverlay()` call removes the last runtime read of the static masters for the product/category render path.

## Out of scope (intentionally deferred)

- Rewiring `src/lib/seo.ts` and `src/lib/data/company.ts` for JSON-LD → Phase 6.
- Product images / storage upload → Phase 7.
- Admin write-paths and forms → later phases.
- Any refactor of `src/lib/products.ts`'s `CATEGORIES` skeleton beyond removing the overlay call.
