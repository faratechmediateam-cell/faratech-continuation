/**
 * Category repository.
 *
 * Categories are an enum in the schema; this repo aggregates published
 * product counts per category via the products table.
 */
import { ProductRepository } from "../products/product.repository";

export class CategoryRepository {
  constructor(
    private readonly productRepo: ProductRepository = new ProductRepository(),
  ) {}

  countsByCategory(): Promise<Record<string, number>> {
    return this.productRepo.countsByCategory();
  }
}