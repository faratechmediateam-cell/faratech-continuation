/**
 * Product "controller" — exposes the service via TanStack server functions.
 *
 * This is the public-facing RPC surface. Validates input with Zod, calls
 * the service, returns DTOs. No business logic lives here.
 */
import { createServerFn } from "@tanstack/react-start";
import { notFound } from "@tanstack/react-router";
import { z } from "zod";

import { ProductService, ProductNotFoundError } from "./product.service";
import type {
  ListProductsResultDto,
  ProductDetailDto,
} from "./product.dto";

const CategorySchema = z.enum([
  "POWER_WHEELCHAIRS",
  "MANUAL_WHEELCHAIRS",
  "MOBILITY_AIDS",
  "ACCESSORIES",
  "SPARE_PARTS",
]);

const ListSchema = z.object({
  categoryKey: CategorySchema.optional(),
  limit: z.number().int().min(1).max(100).optional(),
  offset: z.number().int().min(0).optional(),
});

const SlugSchema = z.object({
  slug: z.string().min(1).max(200),
});

export const listProducts = createServerFn({ method: "GET" })
  .inputValidator((d: unknown) => ListSchema.parse(d ?? {}))
  .handler(async ({ data }): Promise<ListProductsResultDto> => {
    const service = new ProductService();
    return service.list(data);
  });

export const getProductBySlug = createServerFn({ method: "GET" })
  .inputValidator((d: unknown) => SlugSchema.parse(d))
  .handler(async ({ data }): Promise<ProductDetailDto> => {
    const service = new ProductService();
    try {
      return await service.getBySlug(data.slug);
    } catch (err) {
      if (err instanceof ProductNotFoundError) throw notFound();
      throw err;
    }
  });