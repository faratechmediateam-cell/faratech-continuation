import { createServerFn } from "@tanstack/react-start";
import type { CategoryDto } from "./category.dto";
import { CategoryService } from "./category.service";

export const listCategories = createServerFn({ method: "GET" }).handler(
  async (): Promise<CategoryDto[]> => {
    const service = new CategoryService();
    return service.list();
  },
);