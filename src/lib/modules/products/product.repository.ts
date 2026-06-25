/**
 * Product repository.
 *
 * Owns ALL data access for products. Service layer must never touch the
 * Supabase client directly — it goes through this repository.
 *
 * Reads only (Phase 3 scope). RLS guarantees only PUBLISHED rows are
 * returned to the public client.
 */
import { getServerSupabase, type DbClient } from "../shared/supabase-server";
import type { ListProductsQuery } from "./product.dto";

const DETAIL_SELECT = `
  *,
  product_images(*),
  product_videos(*),
  product_documents(*),
  specification_groups(*, specification_items(*)),
  certifications(*),
  faq_items(*),
  product_seo(*),
  related_from:related_products!related_products_from_id_fkey(
    position,
    to:products!related_products_to_id_fkey(slug)
  )
`;

const SUMMARY_SELECT = `
  id, slug, code, name, category_key, series, short_description, status, updated_at,
  product_images(id, src, width, height, is_primary, position, alt)
`;

export class ProductRepository {
  constructor(private readonly db: DbClient = getServerSupabase()) {}

  async findBySlug(slug: string): Promise<Record<string, unknown> | null> {
    const { data, error } = await this.db
      .from("products")
      .select(DETAIL_SELECT)
      .eq("slug", slug)
      .maybeSingle();
    if (error) throw error;
    return (data as Record<string, unknown> | null) ?? null;
  }

  async findById(id: string): Promise<Record<string, unknown> | null> {
    const { data, error } = await this.db
      .from("products")
      .select(DETAIL_SELECT)
      .eq("id", id)
      .maybeSingle();
    if (error) throw error;
    return (data as Record<string, unknown> | null) ?? null;
  }

  async list(query: ListProductsQuery): Promise<{
    rows: Record<string, unknown>[];
    total: number;
  }> {
    const limit = Math.min(Math.max(query.limit ?? 24, 1), 100);
    const offset = Math.max(query.offset ?? 0, 0);

    let q = this.db
      .from("products")
      .select(SUMMARY_SELECT, { count: "exact" })
      .order("updated_at", { ascending: false })
      .range(offset, offset + limit - 1);

    if (query.categoryKey) q = q.eq("category_key", query.categoryKey);

    const { data, error, count } = await q;
    if (error) throw error;
    return {
      rows: (data as Record<string, unknown>[]) ?? [],
      total: count ?? 0,
    };
  }

  /** Counts of PUBLISHED products grouped by category_key. */
  async countsByCategory(): Promise<Record<string, number>> {
    const { data, error } = await this.db
      .from("products")
      .select("category_key");
    if (error) throw error;
    const out: Record<string, number> = {};
    for (const row of (data ?? []) as { category_key: string }[]) {
      out[row.category_key] = (out[row.category_key] ?? 0) + 1;
    }
    return out;
  }
}