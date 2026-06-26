import { createServerFn } from "@tanstack/react-start";
import { z } from "zod";
import type { LeadSubmissionResult } from "./lead.dto";
import { LeadService } from "./lead.service";

const contactSchema = z.object({
  name: z.string().trim().min(2).max(100),
  email: z.string().trim().email().max(255),
  organization: z.string().trim().max(150).optional().nullable(),
  message: z.string().trim().min(10).max(2000),
  locale: z.string().trim().max(8).optional().nullable(),
  source: z.string().trim().max(64).optional().nullable(),
});

const newsletterSchema = z.object({
  email: z.string().trim().email().max(255),
  locale: z.string().trim().max(8).optional().nullable(),
  source: z.string().trim().max(64).optional().nullable(),
});

export const submitContactLead = createServerFn({ method: "POST" })
  .inputValidator((data: unknown) => contactSchema.parse(data))
  .handler(async ({ data }): Promise<LeadSubmissionResult> => {
    const service = new LeadService();
    return service.submitContact(data);
  });

export const submitNewsletterLead = createServerFn({ method: "POST" })
  .inputValidator((data: unknown) => newsletterSchema.parse(data))
  .handler(async ({ data }): Promise<LeadSubmissionResult> => {
    const service = new LeadService();
    return service.submitNewsletter(data);
  });
