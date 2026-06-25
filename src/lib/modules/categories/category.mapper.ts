import type { CategoryDto } from "./category.dto";
import type { LocalizedText, ProductCategoryKey } from "../products/product.dto";

/**
 * Built-in labels for each category. Categories themselves are an enum in
 * the source-of-truth schema, so labels live in the application layer.
 */
const LABELS: Record<ProductCategoryKey, LocalizedText> = {
  POWER_WHEELCHAIRS: { fa: "ویلچر برقی", en: "Power Wheelchairs" },
  MANUAL_WHEELCHAIRS: { fa: "ویلچر دستی", en: "Manual Wheelchairs" },
  MOBILITY_AIDS: { fa: "کمک‌حرکتی", en: "Mobility Aids" },
  ACCESSORIES: { fa: "لوازم جانبی", en: "Accessories" },
  SPARE_PARTS: { fa: "قطعات یدکی", en: "Spare Parts" },
};

export const ALL_CATEGORY_KEYS: ProductCategoryKey[] = [
  "POWER_WHEELCHAIRS",
  "MANUAL_WHEELCHAIRS",
  "MOBILITY_AIDS",
  "ACCESSORIES",
  "SPARE_PARTS",
];

export function mapCategory(
  key: ProductCategoryKey,
  count: number,
): CategoryDto {
  return { key, label: LABELS[key], productCount: count };
}