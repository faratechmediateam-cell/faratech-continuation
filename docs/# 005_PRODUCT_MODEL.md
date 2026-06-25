# 005_PRODUCT_MODEL.md — Product Data Contract

**Phase:** 1A — Product Model Foundation
**Last Updated:** 2026-06-23
**Status:** Schema only. No content. No backend. No CMS.

---

## 1. Purpose

Define a production-ready, forward-compatible TypeScript contract for the
`Product` entity that:

- preserves 100% backward compatibility with the 38 existing static records,
- supports every section the product detail page must eventually render
  (description, specifications, media, documents, certifications, FAQ,
  related products, SEO),
- maps cleanly to a future Prisma / PostgreSQL schema,
- references media as **strings only** (URL or CMS / S3 key) — no bundled
  assets, no fake content,
- is enforced by the frontend's "render only when populated" rule so the live
  site never shows placeholder, demo, or "coming soon" content.

The canonical type lives in [`src/lib/products.ts`](../src/lib/products.ts).

---

## 2. Schema

```ts
type LocalizedText = { en: string; fa?: string; ar?: string };

type ProductImage = {
  src: string;              // URL or future CMS / S3 key
  alt?: LocalizedText;
  width?: number;
  height?: number;
  isPrimary?: boolean;
};

type ProductVideo = {
  src: string;
  poster?: string;
  title?: LocalizedText;
  provider?: "youtube" | "vimeo" | "self-hosted";
  durationSeconds?: number;
};

type ProductDocumentKind =
  | "brochure" | "manual" | "datasheet"
  | "certificate" | "warranty" | "other";

type ProductDocument = {
  kind: ProductDocumentKind;
  src: string;
  title?: LocalizedText;
  language?: "en" | "fa" | "ar";
  sizeBytes?: number;
};

type SpecificationItem = {
  key: string;
  label: LocalizedText;
  value: LocalizedText;
  unit?: string;
};

type SpecificationGroup = {
  key: string;                // e.g. "dimensions", "electrical", "frame"
  label: LocalizedText;
  items: SpecificationItem[];
};

type Certification = { name: string; issuer?: string; reference?: string };

type FAQItem = { question: LocalizedText; answer: LocalizedText };

type RelatedProductRef = {
  category: ProductCategoryKey;
  slug: string;
};

type ProductSEO = {
  title?: LocalizedText;
  description?: LocalizedText;
  keywords?: string[];
  canonical?: string;
  ogImage?: string;
};

type ProductStatus = "draft" | "published" | "archived";

type Product = {
  // Identity & routing
  slug: string;               // REQUIRED — route identifier (do not change)
  name: string;               // REQUIRED — model name, not translated
  code?: string;              // SKU / business code, NOT a route identifier
  series?: LocalizedText;
  tagline?: LocalizedText;

  // Localized copy
  description?: LocalizedText;
  shortDescription?: LocalizedText;
  features?: LocalizedText[];

  // Structured technical data
  specifications?: SpecificationGroup[];
  certifications?: Certification[];

  // Media — refs only, never bundled
  media?: {
    images?: ProductImage[];
    videos?: ProductVideo[];
  };
  documents?: ProductDocument[];

  // Editorial extras
  faq?: FAQItem[];
  related?: RelatedProductRef[];

  // Per-product SEO overrides
  seo?: ProductSEO;

  // Lifecycle
  status?: ProductStatus;

  // CMS migration metadata
  cmsId?: string;
  createdAt?: string;         // ISO 8601
  updatedAt?: string;         // ISO 8601
};
```

---

## 3. Field Descriptions

### Identity
| Field | Required | Description |
|---|---|---|
| `slug` | yes | URL slug. Stable. Used by the route `/{lang}/products/{category}/{slug}`. Must never change for an existing product. |
| `name` | yes | Model name. Treated as a proper noun — not localized. |
| `code` | no | Internal SKU / business code. Distinct from `slug`. Future CMS likely uses this as the unique business key. |
| `series` | no | Localized series name (e.g. "Upholstered Power Wheelchairs"). |
| `tagline` | no | Short localized strapline. Reserved; not currently rendered. |

### Copy
| Field | Description |
|---|---|
| `description` | Long-form localized description. Rendered above the inquire CTA when present. |
| `shortDescription` | One-line localized blurb suitable for category cards and meta descriptions. |
| `features` | Ordered list of localized bullet points. Rendered as the Key Features list. |

### Technical
| Field | Description |
|---|---|
| `specifications` | Ordered groups of spec items (frame, electrical, dimensions, etc.). Each item has a stable `key`, localized `label`/`value`, and optional `unit`. |
| `certifications` | List of standards/marks (CE, ISO 13485, EN 12183/12184). |

### Media
| Field | Description |
|---|---|
| `media.images[]` | Image refs. `src` may be a `/public/...` path today or a CMS / S3 key later — the resolver converts to a URL. `isPrimary` selects the hero image; otherwise the first entry wins. |
| `media.videos[]` | Video refs with optional provider hint. |
| `documents[]` | Downloadable assets. The first `kind: "brochure"` is surfaced as the primary CTA; remaining documents render in the Downloads section. |

### Editorial
| Field | Description |
|---|---|
| `faq` | Question/answer pairs. Future: feeds `FAQPage` JSON-LD. |
| `related` | References to other products by `(category, slug)`. The frontend resolves and renders cards. |

### SEO
| Field | Description |
|---|---|
| `seo.title` | Overrides the default `<title>`. |
| `seo.description` | Overrides the meta/OG description. |
| `seo.keywords` | Optional keyword array. |
| `seo.canonical` | Absolute canonical URL override. |
| `seo.ogImage` | OG/Twitter share image. Falls back to the primary media image. |

### Lifecycle
| Field | Description |
|---|---|
| `status` | `draft` (CMS hidden), `published` (live), `archived` (kept for SEO/history). The current static list is implicitly `published`. |

### CMS migration metadata
| Field | Description |
|---|---|
| `cmsId` | Opaque identifier from the source CMS (UUID/ULID). Lets the frontend round-trip back to the CMS record without relying on slug. |
| `createdAt` / `updatedAt` | ISO 8601 timestamps. Used for sitemap `lastmod`, sorting, and cache busting. |

---

## 4. Rendering Rules (Frontend Contract)

The product page **MUST** apply these rules:

1. Render any optional section ONLY when its source data is present and
   non-empty.
2. Never substitute fake, demo, or "coming soon" content for missing data.
3. Never hardcode specification values.
4. The image gallery, brochure button, downloads list, specifications,
   certifications, FAQ and related products are all gated on real data.
5. The "Inquire" CTA, breadcrumb, title and category label render
   unconditionally — they depend only on identity fields.

---

## 5. CMS Migration Notes

Target CMS supplies records that satisfy this contract verbatim. Migration
steps when the CMS is introduced:

1. **Identity preservation.** Every existing `slug` must be re-emitted by the
   CMS unchanged. `slug` is the route identifier — changing it breaks SEO and
   external links. `code` may be promoted to the CMS business key but must
   not be used in routes.
2. **Localization.** Persian (`fa`) and Arabic (`ar`) are optional in the
   contract; the `t()` helper falls back to `en`. The CMS should still target
   full trilingual coverage for `description`, `shortDescription`, `features`
   and `specifications`.
3. **Media handling.** `src` is a free-form string. Today it can be a public
   path; tomorrow the CMS layer can return a signed S3 URL or a CMS-internal
   key resolved by a server function. No component imports image files.
4. **Documents.** PDFs live in object storage. `ProductDocument.src` is the
   resolved URL; the CMS records the storage key separately.
5. **Related products.** Stored as `(category, slug)` tuples. The frontend
   resolves against the catalog at render time; if the target is missing the
   reference is silently dropped (no broken cards).
6. **Status.** Only `published` records should be exposed by the public read
   API. `draft` and `archived` are CMS-internal.
7. **Cache invalidation.** `updatedAt` participates in the cache key for ISR /
   loader revalidation strategies.

No backend, no Prisma client, and no CMS code is shipped in Phase 1A.

---

## 6. Prisma Mapping Guidance (Reference Only — Do NOT Implement Yet)

Suggested mapping for when Phase 2 introduces Prisma. This is non-binding
guidance to keep the contract migratable; no schema files are added in 1A.

```prisma
enum ProductStatus { DRAFT PUBLISHED ARCHIVED }

enum DocumentKind { BROCHURE MANUAL DATASHEET CERTIFICATE WARRANTY OTHER }

model Product {
  id            String   @id @default(cuid())        // -> cmsId
  slug          String   @unique                     // route identifier
  code          String?  @unique                     // business SKU
  name          String
  categoryKey   String                               // FK to Category.key
  seriesEn      String?
  seriesFa      String?
  seriesAr      String?
  // localized copy stored as JSON for simplicity, or normalized table
  description   Json?                                // LocalizedText
  shortDescription Json?
  features      Json?                                // LocalizedText[]
  seo           Json?                                // ProductSEO
  status        ProductStatus @default(DRAFT)
  createdAt     DateTime @default(now())
  updatedAt     DateTime @updatedAt

  images          ProductImage[]
  videos          ProductVideo[]
  documents       ProductDocument[]
  specifications  SpecificationGroup[]
  certifications  Certification[]
  faq             FAQItem[]
  relatedFrom     RelatedProduct[] @relation("From")
  relatedTo       RelatedProduct[] @relation("To")

  category        Category @relation(fields: [categoryKey], references: [key])
}

model ProductImage {
  id        String  @id @default(cuid())
  productId String
  src       String                       // S3 key or URL
  alt       Json?
  width     Int?
  height    Int?
  isPrimary Boolean @default(false)
  position  Int     @default(0)
  product   Product @relation(fields: [productId], references: [id], onDelete: Cascade)
}

model ProductDocument {
  id        String       @id @default(cuid())
  productId String
  kind      DocumentKind
  src       String
  title     Json?
  language  String?
  sizeBytes Int?
  product   Product @relation(fields: [productId], references: [id], onDelete: Cascade)
}

model SpecificationGroup {
  id        String @id @default(cuid())
  productId String
  key       String
  label     Json
  position  Int    @default(0)
  items     SpecificationItem[]
  product   Product @relation(fields: [productId], references: [id], onDelete: Cascade)
}

model SpecificationItem {
  id      String @id @default(cuid())
  groupId String
  key     String
  label   Json
  value   Json
  unit    String?
  position Int   @default(0)
  group   SpecificationGroup @relation(fields: [groupId], references: [id], onDelete: Cascade)
}

model RelatedProduct {
  fromId String
  toId   String
  from   Product @relation("From", fields: [fromId], references: [id], onDelete: Cascade)
  to     Product @relation("To",   fields: [toId],   references: [id], onDelete: Cascade)
  @@id([fromId, toId])
}
```

Notes:

- `LocalizedText` columns stored as `Json` are simplest; a normalized
  `Translation` table is acceptable if full i18n tooling is required.
- `Category` remains a small enum-like table keyed by `ProductCategoryKey`.
- The Data API layer projects Prisma rows back into the TS `Product` shape
  defined here — the frontend contract does not change.

---

## 7. Example Record (Schema Demonstration Only — NOT Live Content)

This example exists only to illustrate the shape. It is **not** added to the
catalog and **must not** be shipped as real product data. Real content will
come from the CMS.

```ts
const exampleProduct: Product = {
  slug: "fateh-lx2",
  name: "Fateh LX2 Power Wheelchair",
  code: "FT-LX2",
  series: { en: "Upholstered Power Wheelchairs" },
  status: "published",
  cmsId: "01J9X7K8Z0EXAMPLECMSID",
  createdAt: "2026-06-23T00:00:00Z",
  updatedAt: "2026-06-23T00:00:00Z",
  description: {
    en: "Clinical-grade upholstered power wheelchair engineered for daily institutional use.",
  },
  shortDescription: { en: "Clinical-grade upholstered power wheelchair." },
  features: [
    { en: "Reinforced steel frame" },
    { en: "Programmable controller with diagnostic telemetry" },
  ],
  specifications: [
    {
      key: "frame",
      label: { en: "Frame" },
      items: [
        { key: "material", label: { en: "Frame Material" }, value: { en: "Reinforced steel" } },
        { key: "capacity", label: { en: "Weight Capacity" }, value: { en: "130" }, unit: "kg" },
      ],
    },
  ],
  certifications: [
    { name: "CE" },
    { name: "ISO 13485", issuer: "TÜV" },
  ],
  media: {
    images: [
      { src: "cms://products/fateh-lx2/hero.jpg", alt: { en: "Fateh LX2 hero" }, isPrimary: true },
    ],
  },
  documents: [
    { kind: "brochure", src: "cms://products/fateh-lx2/brochure.pdf", title: { en: "Brochure" } },
  ],
  faq: [
    { question: { en: "What is the warranty?" }, answer: { en: "Two years on the frame." } },
  ],
  related: [{ category: "power-wheelchairs", slug: "fateh-capitan" }],
  seo: {
    title: { en: "Fateh LX2 Power Wheelchair — FARATECH" },
    description: { en: "Upholstered clinical power wheelchair by FARATECH." },
    keywords: ["power wheelchair", "clinical", "FARATECH"],
  },
};
```

---

## 8. Out of Scope for Phase 1A

- No CMS implementation.
- No backend / NestJS / Prisma code.
- No database migration.
- No real or placeholder product images, PDFs, videos.
- No route changes (slug-based routing preserved).
- No architecture refactor (feature-based modules deferred).
- No visual redesign — only conditional rendering of new sections.
