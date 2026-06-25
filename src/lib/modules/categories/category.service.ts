import type { CategoryDto } from "./category.dto";
import { CategoryRepository } from "./category.repository";
import { ALL_CATEGORY_KEYS, mapCategory } from "./category.mapper";

export class CategoryService {
  constructor(private readonly repo: CategoryRepository = new CategoryRepository()) {}

  async list(): Promise<CategoryDto[]> {
    const counts = await this.repo.countsByCategory();
    return ALL_CATEGORY_KEYS.map((k) => mapCategory(k, counts[k] ?? 0));
  }
}