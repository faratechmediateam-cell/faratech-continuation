# 006_PRODUCT_CMS.md — Product CMS Foundation

**Phase:** 1C — Product CMS Foundation
**Last Updated:** 2026-06-25
**Status:** Architecture + mock admin UI. No backend. No persistence. No auth.

---

## 1. Goals & non-goals

Phase 1C lands the CMS-shaped seam between the product schema (`005`) and
a future NestJS / Prisma backend. It introduces:

- a `ProductRepository` interface,
- one in-memory implementation (`InMemoryProductRepository`),
- a dependency-free validation layer mirroring `005_PRODUCT_MODEL.md`,
- a mock admin UI mounted at `/admin/products`,
- a placeholder admin navigation foundation.

Phase 1C does **NOT** introduce: backend code, Prisma, PostgreSQL, Redis,
S3, authentication, role management, dashboard analytics, an article CMS,
search, or media uploads. Public routes, public components, the design
system, SEO helpers, and the `Product` schema are unchanged.

---

## 2. Architecture

```text
┌─────────────────────────────┐         ┌─────────────────────────────┐
│ Public site (unchanged)     │         │ Mock admin (/admin/*)       │
│  $lang.products.* routes    │         │  ProductForm + table UI     │
│  reads CATEGORIES directly  │         │  reads productRepository    │
└─────────────┬───────────────┘         └──────────────┬──────────────┘
              │ static                                  │ async
              ▼                                         ▼
     src/lib/products.ts                  src/lib/products/index.ts
      (Product type,                       productRepository
       CATEGORIES seed)                    (singleton)
              │                                         │
              └──────────────► seeds ◄──────────────────┘
                                  │
                                  ▼
                     InMemoryProductRepository
                     (Phase 1C — module-level Map)

        ┌─────────────────────────────────────────────┐
        │  Phase 2A swap (no UI change)               │
        │  productRepository = HttpProductRepository  │
        │  → /api/* server fns → NestJS → Prisma → PG │
        └─────────────────────────────────────────────┘
```

Key principle: every read/write path that the admin uses goes through
`ProductRepository`. When the backend lands, only `src/lib/products/index.ts`
changes — admin UI and validation are untouched.

The public site intentionally still reads the static catalog. The repository
is a *write-side* abstraction in 1C. A read-side swap is part of Phase 2A.

---

## 3. Repository contract

```ts
interface ProductRepository {
  list(query?: ProductListQuery): Promise<ProductListResult>;
  getBySlug(category: ProductCategoryKey, slug: string): Promise<Product | null>;
  getById(cmsId: string): Promise<Product | null>;
  create(input: CreateProductInput): Promise<Product>;
  update(cmsId: string, input: UpdateProductInput): Promise<Product>;
  archive(cmsId: string): Promise<Product>;
  publish(cmsId: string): Promise<Product>;
  unpublish(cmsId: string): Promise<Product>;
}
```

DTOs:

| Type | Purpose |
|---|---|
| `ProductListQuery` | `{ category?, status?, search?, limit?, offset? }` |
| `ProductListResult` | `{ items, total, limit, offset }`; items carry the resolved `category`. |
| `CreateProductInput` | `{ category, product }` — `cmsId`/timestamps are server-assigned. |
| `UpdateProductInput` | `{ category?, product: Partial<Product> }` — partial patch semantics. |
| `ValidationResult` | `{ ok: true } \| { ok: false; issues: ValidationIssue[] }` |

All methods are async. All inputs are JSON-serializable so the same shape
works over HTTP / RPC / server functions.

---

## 4. Validation layer

`validateProduct(p)` composes seven sub-validators, each callable
individually:

| Validator | Enforces |
|---|---|
| `validateIdentity` | `slug` required + kebab-case, `name` required, ISO timestamps |
| `validateDescription` | `description.en` ≤ 4000 chars, `shortDescription.en` ≤ 280 chars |
| `validateSpecifications` | Group/item key uniqueness, required labels/values |
| `validateDocuments` | `kind` enum, `src` required, non-negative `sizeBytes` |
| `validateSEO` | Title ≤ 70, description ≤ 160, canonical is absolute URL |
| `validateFAQ` | English question + answer required |
| `validateRelated` | Required fields, no duplicates, no self-reference |

Issues are typed `{ path: string[]; code: string; message: string }` so a
future Prisma layer can surface them to the same form UI without
translation.

---

## 5. Admin workflows

### Lifecycle

```text
   (new)
     │
     ▼
 ┌────────┐  publish   ┌──────────┐
 │ DRAFT  │ ─────────► │PUBLISHED │
 │        │ ◄───────── │          │
 └────┬───┘ unpublish  └────┬─────┘
      │                     │
      └──── archive ────────┤
                            ▼
                       ┌──────────┐
                       │ ARCHIVED │ (kept for SEO/history)
                       └──────────┘
```

### Create

```text
 /admin/products → "New product"
   → /admin/products/new
   → ProductForm (Identity + Status=draft)
   → validateProduct → productRepository.create
   → redirect /admin/products/:cmsId
```

### Edit

```text
 /admin/products/:id
   → ProductForm (Identity / Copy / Specs / Media / Docs / FAQ / Related / SEO)
   → validateProduct → productRepository.update
   → toast + redirect /admin/products
```

### Preview

```text
 /admin/products/:id/preview
   → read-only mirror of the public conditional-rendering contract
   → sections render only when source data exists (no placeholders).
```

---

## 6. Migration path to NestJS

A `ProductsService` in NestJS implements `ProductRepository` verbatim:

```ts
@Injectable()
export class ProductsService implements ProductRepository {
  constructor(private prisma: PrismaService) {}
  list(q) { /* prisma.product.findMany */ }
  getById(id) { /* prisma.product.findUnique */ }
  create(input) { /* prisma.product.create */ }
  update(id, input) { /* prisma.product.update */ }
  archive(id) { return this.setStatus(id, 'ARCHIVED'); }
  publish(id) { return this.setStatus(id, 'PUBLISHED'); }
  unpublish(id) { return this.setStatus(id, 'DRAFT'); }
}
```

The frontend swap is local:

```ts
// src/lib/products/index.ts (Phase 2A)
export const productRepository: ProductRepository =
  new HttpProductRepository(); // calls TanStack server fns → NestJS
```

No admin UI changes, no validation changes, no DTO changes.

---

## 7. Migration path to Prisma

The DTOs map 1:1 to the Prisma schema sketched in `005_PRODUCT_MODEL.md §6`:

| DTO field | Prisma column / relation |
|---|---|
| `cmsId` | `Product.id @id @default(cuid())` |
| `slug` | `Product.slug @unique` |
| `code` | `Product.code @unique` |
| `name` | `Product.name` |
| `category` | `Product.categoryKey` (FK → `Category.key`) |
| `series` / `description` / `shortDescription` / `features` / `seo` | `Json` columns |
| `status` | `Product.status` (`ProductStatus` enum) |
| `createdAt` / `updatedAt` | `@default(now())` / `@updatedAt` |
| `media.images[]` | `ProductImage[]` |
| `media.videos[]` | `ProductVideo[]` |
| `documents[]` | `ProductDocument[]` |
| `specifications[]` | `SpecificationGroup` → `SpecificationItem` |
| `certifications[]` | `Certification[]` |
| `faq[]` | `FAQItem[]` |
| `related[]` | `RelatedProduct[]` (`fromId`, `toId`) |

`ProductListQuery` maps to a Prisma `where` + `take`/`skip` + `orderBy`
clause. Pagination already returns `{ items, total, limit, offset }` so the
admin list UI is forward-compatible.

---

## 8. Future media integration (out of scope for 1C)

- `ProductImage.src` and `ProductDocument.src` accept either a public path
  or a CMS / S3 key. A future `resolveMediaUrl(src)` helper will sign S3
  keys at read time; admin and public UI continue to pass the value
  through unchanged.
- Upload flow (Phase 2B+): admin posts a `multipart/form-data` request to
  a TanStack server route → NestJS issues a presigned S3 PUT → frontend
  uploads → NestJS persists the resulting key as `src`.
- CDN: production media served via CloudFront (or equivalent) with
  immutable cache headers and `updatedAt`-based cache busting.
- Documents (PDFs) follow the same path with `kind`-based foldering.

No file inputs, no upload endpoints, no signed URLs ship in 1C.

---

## 9. Constraints honored

- No backend code, no Prisma, no PostgreSQL, no Redis, no S3.
- No authentication, no roles, no dashboard analytics.
- No article CMS, no media uploads, no search engine.
- No real or placeholder product images, PDFs, or fake content.
- Public routes unchanged. Visual design unchanged. SEO architecture
  unchanged. Product schema unchanged.
- Slug-based routing preserved. `code` is never a route identifier.

---

## 10. Recommended next phase

**Phase 2A — Backend skeleton.** NestJS module + Prisma schema implementing
`ProductRepository`; TanStack server-function adapter on the frontend that
replaces `InMemoryProductRepository` with zero UI changes. Auth, role gating,
and the admin route guard land in Phase 2B alongside the first protected
write endpoints.
