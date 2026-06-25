
-- ============================================================================
-- ENUMS
-- ============================================================================
CREATE TYPE public.product_status AS ENUM ('DRAFT','PUBLISHED','ARCHIVED');
CREATE TYPE public.product_category_key AS ENUM ('POWER_WHEELCHAIRS','MANUAL_WHEELCHAIRS','MOBILITY_AIDS','ACCESSORIES','SPARE_PARTS');
CREATE TYPE public.document_kind AS ENUM ('BROCHURE','MANUAL','DATASHEET','CERTIFICATE','WARRANTY','OTHER');
CREATE TYPE public.media_provider AS ENUM ('YOUTUBE','VIMEO','SELF_HOSTED');
CREATE TYPE public.language AS ENUM ('EN','FA','AR');

-- ============================================================================
-- updated_at trigger helper
-- ============================================================================
CREATE OR REPLACE FUNCTION public.set_updated_at()
RETURNS TRIGGER LANGUAGE plpgsql SET search_path = public AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END;
$$;

-- ============================================================================
-- PRODUCTS
-- ============================================================================
CREATE TABLE public.products (
  id text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  slug text UNIQUE NOT NULL,
  category_key public.product_category_key NOT NULL,
  code text UNIQUE,
  name text NOT NULL,
  series jsonb,
  description jsonb,
  short_description jsonb,
  features jsonb,
  status public.product_status NOT NULL DEFAULT 'DRAFT',
  cms_id text UNIQUE,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX products_category_key_idx ON public.products(category_key);
CREATE INDEX products_status_idx ON public.products(status);
CREATE INDEX products_updated_at_idx ON public.products(updated_at);
CREATE INDEX products_code_idx ON public.products(code);
CREATE INDEX products_name_idx ON public.products(name);
CREATE TRIGGER products_set_updated_at BEFORE UPDATE ON public.products
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

GRANT SELECT ON public.products TO anon, authenticated;
GRANT ALL ON public.products TO service_role;
ALTER TABLE public.products ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read published products"
  ON public.products FOR SELECT
  USING (status = 'PUBLISHED');

-- ============================================================================
-- PRODUCT IMAGES
-- ============================================================================
CREATE TABLE public.product_images (
  id text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  product_id text NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  src text NOT NULL,
  width int,
  height int,
  is_primary boolean NOT NULL DEFAULT false,
  position int NOT NULL DEFAULT 0,
  alt jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX product_images_product_id_idx ON public.product_images(product_id);
CREATE INDEX product_images_is_primary_idx ON public.product_images(is_primary);
CREATE INDEX product_images_src_idx ON public.product_images(src);
CREATE UNIQUE INDEX product_images_product_primary_uq
  ON public.product_images(product_id, is_primary);
CREATE TRIGGER product_images_set_updated_at BEFORE UPDATE ON public.product_images
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

GRANT SELECT ON public.product_images TO anon, authenticated;
GRANT ALL ON public.product_images TO service_role;
ALTER TABLE public.product_images ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read images of published products"
  ON public.product_images FOR SELECT
  USING (EXISTS (SELECT 1 FROM public.products p WHERE p.id = product_id AND p.status = 'PUBLISHED'));

-- ============================================================================
-- PRODUCT VIDEOS
-- ============================================================================
CREATE TABLE public.product_videos (
  id text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  product_id text NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  src text NOT NULL,
  poster text,
  provider public.media_provider NOT NULL DEFAULT 'SELF_HOSTED',
  duration_seconds int,
  title jsonb,
  position int NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX product_videos_product_id_idx ON public.product_videos(product_id);
CREATE INDEX product_videos_provider_idx ON public.product_videos(provider);
CREATE INDEX product_videos_src_idx ON public.product_videos(src);

GRANT SELECT ON public.product_videos TO anon, authenticated;
GRANT ALL ON public.product_videos TO service_role;
ALTER TABLE public.product_videos ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read videos of published products"
  ON public.product_videos FOR SELECT
  USING (EXISTS (SELECT 1 FROM public.products p WHERE p.id = product_id AND p.status = 'PUBLISHED'));

-- ============================================================================
-- PRODUCT DOCUMENTS
-- ============================================================================
CREATE TABLE public.product_documents (
  id text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  product_id text NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  kind public.document_kind NOT NULL,
  src text NOT NULL,
  language public.language DEFAULT 'EN',
  size_bytes int,
  title jsonb,
  position int NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX product_documents_product_id_idx ON public.product_documents(product_id);
CREATE INDEX product_documents_kind_idx ON public.product_documents(kind);
CREATE INDEX product_documents_language_idx ON public.product_documents(language);
CREATE INDEX product_documents_src_idx ON public.product_documents(src);

GRANT SELECT ON public.product_documents TO anon, authenticated;
GRANT ALL ON public.product_documents TO service_role;
ALTER TABLE public.product_documents ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read documents of published products"
  ON public.product_documents FOR SELECT
  USING (EXISTS (SELECT 1 FROM public.products p WHERE p.id = product_id AND p.status = 'PUBLISHED'));

-- ============================================================================
-- SPECIFICATIONS
-- ============================================================================
CREATE TABLE public.specification_groups (
  id text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  product_id text NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  key text NOT NULL,
  label jsonb NOT NULL,
  position int NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  UNIQUE (product_id, key)
);
CREATE INDEX specification_groups_product_id_idx ON public.specification_groups(product_id);
CREATE INDEX specification_groups_key_idx ON public.specification_groups(key);
CREATE TRIGGER specification_groups_set_updated_at BEFORE UPDATE ON public.specification_groups
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

GRANT SELECT ON public.specification_groups TO anon, authenticated;
GRANT ALL ON public.specification_groups TO service_role;
ALTER TABLE public.specification_groups ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read spec groups of published products"
  ON public.specification_groups FOR SELECT
  USING (EXISTS (SELECT 1 FROM public.products p WHERE p.id = product_id AND p.status = 'PUBLISHED'));

CREATE TABLE public.specification_items (
  id text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  group_id text NOT NULL REFERENCES public.specification_groups(id) ON DELETE CASCADE,
  key text NOT NULL,
  label jsonb NOT NULL,
  value jsonb NOT NULL,
  unit text,
  position int NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX specification_items_group_id_idx ON public.specification_items(group_id);
CREATE INDEX specification_items_key_idx ON public.specification_items(key);
CREATE TRIGGER specification_items_set_updated_at BEFORE UPDATE ON public.specification_items
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

GRANT SELECT ON public.specification_items TO anon, authenticated;
GRANT ALL ON public.specification_items TO service_role;
ALTER TABLE public.specification_items ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read spec items of published products"
  ON public.specification_items FOR SELECT
  USING (EXISTS (
    SELECT 1 FROM public.specification_groups g
    JOIN public.products p ON p.id = g.product_id
    WHERE g.id = group_id AND p.status = 'PUBLISHED'
  ));

-- ============================================================================
-- CERTIFICATIONS
-- ============================================================================
CREATE TABLE public.certifications (
  id text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  product_id text NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  name text NOT NULL,
  issuer text,
  reference text,
  position int NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX certifications_product_id_idx ON public.certifications(product_id);
CREATE INDEX certifications_name_idx ON public.certifications(name);

GRANT SELECT ON public.certifications TO anon, authenticated;
GRANT ALL ON public.certifications TO service_role;
ALTER TABLE public.certifications ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read certifications of published products"
  ON public.certifications FOR SELECT
  USING (EXISTS (SELECT 1 FROM public.products p WHERE p.id = product_id AND p.status = 'PUBLISHED'));

-- ============================================================================
-- FAQ ITEMS
-- ============================================================================
CREATE TABLE public.faq_items (
  id text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  product_id text NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  question jsonb NOT NULL,
  answer jsonb NOT NULL,
  position int NOT NULL DEFAULT 0,
  created_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX faq_items_product_id_idx ON public.faq_items(product_id);

GRANT SELECT ON public.faq_items TO anon, authenticated;
GRANT ALL ON public.faq_items TO service_role;
ALTER TABLE public.faq_items ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read FAQ of published products"
  ON public.faq_items FOR SELECT
  USING (EXISTS (SELECT 1 FROM public.products p WHERE p.id = product_id AND p.status = 'PUBLISHED'));

-- ============================================================================
-- RELATED PRODUCTS
-- ============================================================================
CREATE TABLE public.related_products (
  from_id text NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  to_id   text NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  position int NOT NULL DEFAULT 0,
  PRIMARY KEY (from_id, to_id)
);
CREATE INDEX related_products_to_id_idx ON public.related_products(to_id);
CREATE INDEX related_products_from_id_idx ON public.related_products(from_id);

GRANT SELECT ON public.related_products TO anon, authenticated;
GRANT ALL ON public.related_products TO service_role;
ALTER TABLE public.related_products ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read related links when both sides are published"
  ON public.related_products FOR SELECT
  USING (
    EXISTS (SELECT 1 FROM public.products p WHERE p.id = from_id AND p.status = 'PUBLISHED')
    AND EXISTS (SELECT 1 FROM public.products p WHERE p.id = to_id AND p.status = 'PUBLISHED')
  );

-- ============================================================================
-- PRODUCT SEO
-- ============================================================================
CREATE TABLE public.product_seo (
  id text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  product_id text UNIQUE NOT NULL REFERENCES public.products(id) ON DELETE CASCADE,
  title jsonb,
  description jsonb,
  keywords text[] NOT NULL DEFAULT '{}',
  canonical text,
  og_image text,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX product_seo_product_id_idx ON public.product_seo(product_id);
CREATE TRIGGER product_seo_set_updated_at BEFORE UPDATE ON public.product_seo
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

GRANT SELECT ON public.product_seo TO anon, authenticated;
GRANT ALL ON public.product_seo TO service_role;
ALTER TABLE public.product_seo ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read SEO of published products"
  ON public.product_seo FOR SELECT
  USING (EXISTS (SELECT 1 FROM public.products p WHERE p.id = product_id AND p.status = 'PUBLISHED'));

-- ============================================================================
-- MIGRATION LOG (audit table, internal)
-- ============================================================================
CREATE TABLE public.migration_log (
  id text PRIMARY KEY DEFAULT gen_random_uuid()::text,
  timestamp timestamptz NOT NULL DEFAULT now(),
  status text NOT NULL,
  batch_name text NOT NULL,
  total_records int NOT NULL,
  processed_records int NOT NULL DEFAULT 0,
  failed_records int NOT NULL DEFAULT 0,
  error_log text,
  notes text
);
CREATE INDEX migration_log_timestamp_idx ON public.migration_log(timestamp);
CREATE INDEX migration_log_status_idx ON public.migration_log(status);

GRANT ALL ON public.migration_log TO service_role;
ALTER TABLE public.migration_log ENABLE ROW LEVEL SECURITY;
-- No public/authenticated policies: service_role only.

-- ============================================================================
-- COMPANY PROFILE (single row)
-- ============================================================================
CREATE TABLE public.company_profile (
  id text PRIMARY KEY DEFAULT 'default',
  name jsonb NOT NULL,                -- { fa, en, ar? }
  mission jsonb,
  vision jsonb,
  history jsonb,
  certificates jsonb,                 -- array of { name, issuer?, reference? }
  contact jsonb,                      -- { phones[], emails[], address, social{} }
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  CONSTRAINT company_profile_single_row CHECK (id = 'default')
);
CREATE TRIGGER company_profile_set_updated_at BEFORE UPDATE ON public.company_profile
  FOR EACH ROW EXECUTE FUNCTION public.set_updated_at();

GRANT SELECT ON public.company_profile TO anon, authenticated;
GRANT ALL ON public.company_profile TO service_role;
ALTER TABLE public.company_profile ENABLE ROW LEVEL SECURITY;
CREATE POLICY "Public can read the company profile"
  ON public.company_profile FOR SELECT
  USING (true);
