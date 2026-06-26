
CREATE TYPE public.lead_kind AS ENUM ('contact', 'newsletter');
CREATE TYPE public.lead_status AS ENUM ('new', 'notified', 'archived');

CREATE TABLE public.leads (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  kind public.lead_kind NOT NULL,
  name TEXT,
  email TEXT NOT NULL,
  organization TEXT,
  message TEXT,
  locale TEXT,
  source TEXT,
  status public.lead_status NOT NULL DEFAULT 'new',
  metadata JSONB NOT NULL DEFAULT '{}'::jsonb,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  CONSTRAINT leads_email_format CHECK (email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
  CONSTRAINT leads_contact_requires_message CHECK (
    kind <> 'contact' OR (message IS NOT NULL AND length(message) >= 10)
  )
);

CREATE INDEX leads_kind_created_at_idx ON public.leads (kind, created_at DESC);
CREATE INDEX leads_status_idx ON public.leads (status);

GRANT INSERT ON public.leads TO anon, authenticated;
GRANT ALL ON public.leads TO service_role;

ALTER TABLE public.leads ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public can submit leads"
  ON public.leads FOR INSERT
  TO anon, authenticated
  WITH CHECK (
    status = 'new'
    AND length(email) <= 255
    AND (name IS NULL OR length(name) <= 100)
    AND (organization IS NULL OR length(organization) <= 150)
    AND (message IS NULL OR length(message) <= 2000)
  );

CREATE POLICY "Service role manages leads"
  ON public.leads FOR ALL
  TO service_role
  USING (true) WITH CHECK (true);

CREATE TRIGGER set_leads_updated_at
  BEFORE UPDATE ON public.leads
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();
