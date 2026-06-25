// Client-side lead capture submission helper.
//
// TODO(backend): replace this stub with a real endpoint once Phase 1
// (NestJS backend) is in place. Until then we POST to a configurable URL
// (e.g. Formspree / Web3Forms) read from `VITE_LEAD_CAPTURE_URL`, and fall
// back to a no-op success in dev so the UI flow remains testable without
// leaking submissions.
import { z } from "zod";

export const contactSchema = z.object({
  name: z.string().trim().min(2, "validation_name").max(100),
  email: z.string().trim().email("validation_email").max(255),
  organization: z.string().trim().max(150).optional().or(z.literal("")),
  message: z.string().trim().min(10, "validation_message").max(2000),
});

export type ContactInput = z.infer<typeof contactSchema>;

export const newsletterSchema = z.object({
  email: z.string().trim().email("validation_email").max(255),
});

export type NewsletterInput = z.infer<typeof newsletterSchema>;

const ENDPOINT =
  (import.meta as unknown as { env?: Record<string, string | undefined> }).env
    ?.VITE_LEAD_CAPTURE_URL ?? "";

async function submit(kind: "contact" | "newsletter", payload: Record<string, unknown>) {
  if (!ENDPOINT) {
    // Dev fallback: log and resolve so UI states still work end-to-end.
    if (typeof console !== "undefined") {
      // eslint-disable-next-line no-console
      console.info(`[lead-capture] ${kind} submission (no endpoint configured)`, payload);
    }
    await new Promise((r) => setTimeout(r, 400));
    return;
  }
  const res = await fetch(ENDPOINT, {
    method: "POST",
    headers: { "Content-Type": "application/json", Accept: "application/json" },
    body: JSON.stringify({ kind, ...payload }),
  });
  if (!res.ok) throw new Error(`submission_failed_${res.status}`);
}

export const submitContact = (data: ContactInput) => submit("contact", data);
export const submitNewsletter = (data: NewsletterInput) => submit("newsletter", data);
