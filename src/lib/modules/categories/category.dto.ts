import type { ProductCategoryKey, LocalizedText } from "../products/product.dto";

export interface CategoryDto {
  key: ProductCategoryKey;
  label: LocalizedText;
  productCount: number;
}