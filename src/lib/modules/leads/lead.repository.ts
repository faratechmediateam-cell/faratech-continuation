/**
 * Lead repository — writes to the `leads` table.
 *
 * Uses the publishable-key server client; the RLS policy
 * `Public can submit leads` authorizes anon INSERTs while keeping
 * SELECT/UPDATE/DELETE locked to service_role.
 */
import { getServerSupabase, type DbClient } from "../shared/supabase-server";
import type { LeadKind } from "./lead.dto";

export interface InsertLeadRow {
  kind: LeadKind;
  email: string;
  name?: string | null;
  organization?: string | null;
  message?: string | null;
  locale?: string | null;
  source?: string | null;
}

export class LeadRepository {
  constructor(private readonly db: DbClient = getServerSupabase()) {}

  async insert(row: InsertLeadRow): Promise<{ id: string; created_at: string }> {
    const { data, error } = await this.db
      .from("leads")
      .insert({
        kind: row.kind,
        email: row.email,
        name: row.name ?? null,
        organization: row.organization ?? null,
        message: row.message ?? null,
        locale: row.locale ?? null,
        source: row.source ?? null,
      })
      .select("id, created_at")
      .single();
    if (error) throw error;
    return data as { id: string; created_at: string };
  }
}
