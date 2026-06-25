/**
 * Product DTOs — the wire shape returned to clients.
 *
 * These intentionally use the localized `LocalizedText` shape exactly as
 * defined in the source-of-truth Prisma schema: `{ fa, en?, ar? }`.
 */

export type Language = "EN" | "FA" | "AR";
export type ProductStatus = "DRAFT" | "PUBLISHED" | "ARCHIVED";
export type ProductCategoryKey =
  | "POWER_WHEELCHAIRS"
  | "MANUAL_WHEELCHAIRS"
  | "MOBILITY_AIDS"
  | "ACCESSORIES"
  | "SPARE_PARTS";
export type DocumentKind =
  | "BROCHURE"
  | "MANUAL"
  | "DATASHEET"
  | "CERTIFICATE"
  | "WARRANTY"
  | "OTHER";
export type MediaProvider = "YOUTUBE" | "VIMEO" | "SELF_HOSTED";

export interface LocalizedText {
  fa: string;
  en?: string;
  ar?: string;
}

export interface ProductImageDto {
  id: string;
  src: string;
  width: number | null;
  height: number | null;
  isPrimary: boolean;
  position: number;
  alt: LocalizedText | null;
}

export interface ProductVideoDto {
  id: string;
  src: string;
  poster: string | null;
  provider: MediaProvider;
  durationSeconds: number | null;
  title: LocalizedText | null;
  position: number;
}

export interface ProductDocumentDto {
  id: string;
  kind: DocumentKind;
  src: string;
  language: Language | null;
  sizeBytes: number | null;
  title: LocalizedText | null;
  position: number;
}

export interface SpecificationItemDto {
  id: string;
  key: string;
  label: LocalizedText;
  value: LocalizedText;
  unit: string | null;
  position: number;
}

export interface SpecificationGroupDto {
  id: string;
  key: string;
  label: LocalizedText;
  position: number;
  items: SpecificationItemDto[];
}

export interface CertificationDto {
  id: string;
  name: string;
  issuer: string | null;
  reference: string | null;
  position: number;
}

export interface FaqItemDto {
  id: string;
  question: LocalizedText;
  answer: LocalizedText;
  position: number;
}

export interface ProductSeoDto {
  title: LocalizedText | null;
  description: LocalizedText | null;
  keywords: string[];
  canonical: string | null;
  ogImage: string | null;
}

/** Summary used in list views — omits heavy detail collections. */
export interface ProductSummaryDto {
  id: string;
  slug: string;
  code: string | null;
  name: string;
  categoryKey: ProductCategoryKey;
  series: LocalizedText | null;
  shortDescription: LocalizedText | null;
  status: ProductStatus;
  primaryImage: ProductImageDto | null;
  updatedAt: string;
}

/** Full product detail view. */
export interface ProductDetailDto extends ProductSummaryDto {
  description: LocalizedText | null;
  features: LocalizedText[];
  images: ProductImageDto[];
  videos: ProductVideoDto[];
  documents: ProductDocumentDto[];
  specifications: SpecificationGroupDto[];
  certifications: CertificationDto[];
  faqItems: FaqItemDto[];
  seo: ProductSeoDto | null;
  relatedSlugs: string[];
}

export interface ListProductsQuery {
  categoryKey?: ProductCategoryKey;
  limit?: number;
  offset?: number;
}

export interface ListProductsResultDto {
  items: ProductSummaryDto[];
  total: number;
}