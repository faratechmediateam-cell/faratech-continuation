BEGIN;
INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:personal-sit-to-stand',
  'personal-sit-to-stand',
  'MOBILITY_AIDS'::public.product_category_key,
  'Personal Lift-personal-sit-to-stand',
  'بالابر (لیفت) شخصی الکترونیکی',
  NULL,
  '{"fa":"لیفت شخصی یک دستگاه بالابر فوق‌سبک با وزن ۱۵ کیلوگرم است که به کاربران امکان جابجایی مستقل را فراهم می‌کند. مجهز به اکچویتور ۶۰۰۰ نیوتن برند Linak و دارای قابلیت جابجایی کاربر (User Displacement)، این لیفت برای استفاده در منازل، مراکز مراقبتی و آسایشگاه‌ها ایده‌آل می‌باشد."}'::jsonb,
  '{"fa":"بالابر شخصی (لیفت) الکترونیکی با اکچویتور ۶۰۰۰ نیوتن Linak و منبع تغذیه ۲۲۰ ولت، مناسب برای جابجایی فردی."}'::jsonb,
  '[{"fa":"جابجایی کاربر توسط خود فرد (User Displacement)"},{"fa":"قابلیت اضافه شدن پد دسترسی پشتی قابل جداسازی (Detachable backrest access pad)"},{"fa":"طراحی مناسب برای محیط‌های داخلی"}]'::jsonb,
  'PUBLISHED'::public.product_status
) ON CONFLICT (slug) DO UPDATE SET
  category_key = EXCLUDED.category_key,
  code = EXCLUDED.code,
  name = EXCLUDED.name,
  series = EXCLUDED.series,
  description = EXCLUDED.description,
  short_description = EXCLUDED.short_description,
  features = EXCLUDED.features,
  status = EXCLUDED.status;
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'personal-sit-to-stand');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'personal-sit-to-stand');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'personal-sit-to-stand');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:personal-sit-to-stand:technical',
  (SELECT id FROM public.products WHERE slug = 'personal-sit-to-stand'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:personal-sit-to-stand:technical:actuator_type',
  'seed:personal-sit-to-stand:technical',
  'actuator_type',
  '{"fa":"نوع اکچویتور","en":"Actuator Type"}'::jsonb,
  '{"fa":"۶۰۰۰ نیوتن (Linak)"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:personal-sit-to-stand:technical:power_source',
  'seed:personal-sit-to-stand:technical',
  'power_source',
  '{"fa":"منبع تغذیه","en":"Power Source"}'::jsonb,
  '{"fa":"۲۲۰ ولت"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:personal-sit-to-stand:technical:weight',
  'seed:personal-sit-to-stand:technical',
  'weight',
  '{"fa":"وزن دستگاه","en":"Weight"}'::jsonb,
  '{"fa":"۱۵ کیلوگرم"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:personal-sit-to-stand:technical:capacity',
  'seed:personal-sit-to-stand:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:personal-sit-to-stand:technical:standards',
  'seed:personal-sit-to-stand:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  4
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:personal-sit-to-stand:cert:0',
  (SELECT id FROM public.products WHERE slug = 'personal-sit-to-stand'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:personal-sit-to-stand:faq:0',
  (SELECT id FROM public.products WHERE slug = 'personal-sit-to-stand'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:personal-sit-to-stand:faq:1',
  (SELECT id FROM public.products WHERE slug = 'personal-sit-to-stand'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

-- migration_log
INSERT INTO public.migration_log (id, status, batch_name, total_records, processed_records, notes) VALUES (
  'phase5-seed-' || to_char(now(), 'YYYYMMDDHH24MISS'),
  'completed', 'phase5_seed_data',
  24,
  24,
  'Phase 5 — Data Import (products + categories + company profile)'
);
COMMIT;
