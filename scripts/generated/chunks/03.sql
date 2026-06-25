BEGIN;
INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:l280',
  'l280',
  'MOBILITY_AIDS'::public.product_category_key,
  'Electric Patient Lift-l280',
  'بالابر (لیفت) الکترونیکی بیمار L280',
  NULL,
  '{"fa":"مدل L280 بالاترین سطح تکنولوژی را در لیفت‌های بیمار ارائه می‌دهد و دارای پایه کنترل زاویه‌دار الکتریکی (به جای مکانیکی/پدالی) و اکچویتور ۶۰۰۰ نیوتن Linak است. با تحمل وزن ۱۵۰ کیلوگرم، این دستگاه برای بالاترین استانداردهای ایمنی در بیمارستان‌ها و مراکز مراقبت ویژه طراحی شده است."}'::jsonb,
  '{"fa":"لیفت بیمار الکترونیکی L280 با پایه کنترل زاویه‌دار الکتریکی و اکچویتور ۶۰۰۰ نیوتن Linak، مناسب برای بیماران سنگین‌وزن."}'::jsonb,
  '[{"fa":"پایه کنترل زاویه‌دار الکتریکی (Electrical Angular Foot)"},{"fa":"قابلیت تاشوندگی برای حمل‌ونقل"},{"fa":"عملکرد روان اکچویتور Linak"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'l280');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'l280');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'l280');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:l280:technical',
  (SELECT id FROM public.products WHERE slug = 'l280'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l280:technical:actuator_type',
  'seed:l280:technical',
  'actuator_type',
  '{"fa":"نوع اکچویتور","en":"Actuator Type"}'::jsonb,
  '{"fa":"۶۰۰۰ نیوتن (Linak)"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l280:technical:battery',
  'seed:l280:technical',
  'battery',
  '{"fa":"باتری","en":"Battery"}'::jsonb,
  '{"fa":"۲×۲/۹ آمپر ساعت"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l280:technical:weight',
  'seed:l280:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۵۲ کیلوگرم"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l280:technical:capacity',
  'seed:l280:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l280:technical:dimensions',
  'seed:l280:technical',
  'dimensions',
  '{"fa":"ابعاد پایه","en":"Base Dimensions"}'::jsonb,
  '{"fa":"طول ۱۱۹ × عرض ۶۸ سانتی‌متر"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l280:technical:standards',
  'seed:l280:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  5
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:l280:cert:0',
  (SELECT id FROM public.products WHERE slug = 'l280'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:l280:faq:0',
  (SELECT id FROM public.products WHERE slug = 'l280'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:l280:faq:1',
  (SELECT id FROM public.products WHERE slug = 'l280'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:alpha850-al',
  'alpha850-al',
  'MANUAL_WHEELCHAIRS'::public.product_category_key,
  'Alpha-alpha850-al',
  'ویلچر دستی تاشو آلفا 850',
  NULL,
  '{"fa":"آلفا 850 یک ویلچر دستی تاشو با طراحی مهندسی‌شده برای حمل‌ونقل آسان و دوام بالا است. ساختار شاسی از ترکیب فولاد و آلومینیوم و رنگ الکترواستاتیک پودری، استحکام و ماندگاری آن را تضمین کرده و با تحمل وزن ۱۵۰ کیلوگرم، گزینه‌ای استاندارد برای مصارف پزشکی، بیمارستانی و خانگی محسوب می‌شود."}'::jsonb,
  '{"fa":"ویلچر دستی تاشو آلفا 850، با وزن ۱۹ کیلوگرم، شاسی فولاد و آلومینیوم و رنگ الکترواستاتیک پودری."}'::jsonb,
  '[{"fa":"قابلیت تاشوندگی"},{"fa":"زیرآرنجی متحرک و قابل تنظیم"},{"fa":"زیرپایی متحرک"},{"fa":"پشتی ثابت"},{"fa":"کمربند ضربدری (Double Cross Over)"},{"fa":"رنگ الکترواستاتیک پودری مقاوم"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha850-al');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha850-al');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha850-al');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:alpha850-al:technical',
  (SELECT id FROM public.products WHERE slug = 'alpha850-al'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha850-al:technical:weight',
  'seed:alpha850-al:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۱۹ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha850-al:technical:capacity',
  'seed:alpha850-al:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha850-al:technical:dimensions',
  'seed:alpha850-al:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۰۰ × عرض ۶۶ × ارتفاع ۸۸ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha850-al:technical:frame_material',
  'seed:alpha850-al:technical',
  'frame_material',
  '{"fa":"جنس فریم","en":"Frame Material"}'::jsonb,
  '{"fa":"فولاد و آلومینیوم"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha850-al:technical:finish',
  'seed:alpha850-al:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک پودری"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha850-al:technical:rear_wheel',
  'seed:alpha850-al:technical',
  'rear_wheel',
  '{"fa":"چرخ عقب","en":"Rear Wheel"}'::jsonb,
  '{"fa":"۲۴ اینچ (توپر)"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha850-al:technical:front_wheel',
  'seed:alpha850-al:technical',
  'front_wheel',
  '{"fa":"چرخ جلو","en":"Front Wheel"}'::jsonb,
  '{"fa":"۶ اینچ (توپر)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha850-al:technical:seat_size',
  'seed:alpha850-al:technical',
  'seat_size',
  '{"fa":"سایز صندلی","en":"Seat Size"}'::jsonb,
  '{"fa":"۴۲ سانتی‌متر"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha850-al:technical:standards',
  'seed:alpha850-al:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  8
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:alpha850-al:cert:0',
  (SELECT id FROM public.products WHERE slug = 'alpha850-al'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:alpha850-al:faq:0',
  (SELECT id FROM public.products WHERE slug = 'alpha850-al'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:alpha850-al:faq:1',
  (SELECT id FROM public.products WHERE slug = 'alpha850-al'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:alpha851-al',
  'alpha851-al',
  'MANUAL_WHEELCHAIRS'::public.product_category_key,
  'Alpha-alpha851-al',
  'ویلچر دستی تاشو آلفا 851',
  NULL,
  '{"fa":"آلفا 851 با ترکیب شاسی فولاد و آلومینیوم، وزن ۲۰ کیلوگرم و قابلیت تحمل ۱۵۰ کیلوگرم، محصولی پایدار و مقاوم برای استفاده‌های روزمره است. رنگ پودری الکترواستاتیک، دوام آن را در برابر خوردگی و سایش افزایش داده و مناسب برای بیمارستان‌ها، مراکز درمانی و منازل است."}'::jsonb,
  '{"fa":"ویلچر دستی تاشو آلفا 851، با وزن ۲۰ کیلوگرم، دارای شاسی فولاد و آلومینیوم و قابلیت تحمل وزن ۱۵۰ کیلوگرم."}'::jsonb,
  '[{"fa":"قابلیت تاشوندگی"},{"fa":"زیرآرنجی متحرک و قابل تنظیم"},{"fa":"زیرپایی متحرک"},{"fa":"پشتی ثابت"},{"fa":"کمربند ضربدری (Double Cross Over)"},{"fa":"رنگ الکترواستاتیک پودری مقاوم"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha851-al');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha851-al');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha851-al');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:alpha851-al:technical',
  (SELECT id FROM public.products WHERE slug = 'alpha851-al'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha851-al:technical:weight',
  'seed:alpha851-al:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۲۰ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha851-al:technical:capacity',
  'seed:alpha851-al:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha851-al:technical:dimensions',
  'seed:alpha851-al:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۰۰ × عرض ۶۶ × ارتفاع ۸۸ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha851-al:technical:frame_material',
  'seed:alpha851-al:technical',
  'frame_material',
  '{"fa":"جنس فریم","en":"Frame Material"}'::jsonb,
  '{"fa":"فولاد و آلومینیوم"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha851-al:technical:finish',
  'seed:alpha851-al:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک پودری"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha851-al:technical:rear_wheel',
  'seed:alpha851-al:technical',
  'rear_wheel',
  '{"fa":"چرخ عقب","en":"Rear Wheel"}'::jsonb,
  '{"fa":"۲۴ اینچ (توپر)"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha851-al:technical:front_wheel',
  'seed:alpha851-al:technical',
  'front_wheel',
  '{"fa":"چرخ جلو","en":"Front Wheel"}'::jsonb,
  '{"fa":"۶ اینچ (توپر)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha851-al:technical:seat_size',
  'seed:alpha851-al:technical',
  'seat_size',
  '{"fa":"سایز صندلی","en":"Seat Size"}'::jsonb,
  '{"fa":"۴۲ سانتی‌متر"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha851-al:technical:standards',
  'seed:alpha851-al:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  8
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:alpha851-al:cert:0',
  (SELECT id FROM public.products WHERE slug = 'alpha851-al'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:alpha851-al:faq:0',
  (SELECT id FROM public.products WHERE slug = 'alpha851-al'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:alpha851-al:faq:1',
  (SELECT id FROM public.products WHERE slug = 'alpha851-al'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:alpha950',
  'alpha950',
  'MANUAL_WHEELCHAIRS'::public.product_category_key,
  'Alpha-alpha950',
  'ویلچر دستی تاشو آلفا 950',
  NULL,
  '{"fa":"آلفا 950 به عنوان مدل بزرگ‌تر و با صندلی ۵۲ سانتی‌متری، برای کاربرانی با ابعاد بدنی بزرگتر طراحی شده است. وزن ۲۱ کیلوگرمی آن با ساختار مقاوم فولاد و آلومینیوم، تحمل وزن ۱۵۰ کیلوگرم را فراهم کرده و رنگ الکترواستاتیک پودری آن مقاومت بالایی در برابر شرایط محیطی دارد."}'::jsonb,
  '{"fa":"ویلچر دستی تاشو آلفا 950، با صندلی ۵۲ سانتی‌متری و وزن ۲۱ کیلوگرم، شاسی فولاد و آلومینیوم."}'::jsonb,
  '[{"fa":"صندلی ۵۲ سانتی‌متری (بزرگ‌تر از سری ۸۵۰)"},{"fa":"قابلیت تاشوندگی"},{"fa":"زیرآرنجی متحرک و قابل تنظیم"},{"fa":"زیرپایی متحرک"},{"fa":"پشتی ثابت"},{"fa":"کمربند ضربدری (Double Cross Over)"},{"fa":"رنگ الکترواستاتیک پودری مقاوم"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha950');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha950');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha950');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:alpha950:technical',
  (SELECT id FROM public.products WHERE slug = 'alpha950'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha950:technical:weight',
  'seed:alpha950:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۲۱ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha950:technical:capacity',
  'seed:alpha950:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha950:technical:dimensions',
  'seed:alpha950:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۰۰ × عرض ۷۰ × ارتفاع ۸۸ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha950:technical:frame_material',
  'seed:alpha950:technical',
  'frame_material',
  '{"fa":"جنس فریم","en":"Frame Material"}'::jsonb,
  '{"fa":"فولاد و آلومینیوم"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha950:technical:finish',
  'seed:alpha950:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک پودری"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha950:technical:rear_wheel',
  'seed:alpha950:technical',
  'rear_wheel',
  '{"fa":"چرخ عقب","en":"Rear Wheel"}'::jsonb,
  '{"fa":"۲۴ اینچ (توپر)"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha950:technical:front_wheel',
  'seed:alpha950:technical',
  'front_wheel',
  '{"fa":"چرخ جلو","en":"Front Wheel"}'::jsonb,
  '{"fa":"۸ اینچ (توپر)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha950:technical:seat_size',
  'seed:alpha950:technical',
  'seat_size',
  '{"fa":"سایز صندلی","en":"Seat Size"}'::jsonb,
  '{"fa":"۵۲ سانتی‌متر"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha950:technical:standards',
  'seed:alpha950:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  8
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:alpha950:cert:0',
  (SELECT id FROM public.products WHERE slug = 'alpha950'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:alpha950:faq:0',
  (SELECT id FROM public.products WHERE slug = 'alpha950'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:alpha950:faq:1',
  (SELECT id FROM public.products WHERE slug = 'alpha950'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:alpha750',
  'alpha750',
  'MANUAL_WHEELCHAIRS'::public.product_category_key,
  'Alpha-alpha750',
  'ویلچر دستی تاشو آلفا 750',
  NULL,
  '{"fa":"آلفا 750 یک ویلچر دستی فوق‌سبک و ایده‌آل برای کاربرانی است که به دنبال حمل‌ونقل آسان هستند. با وزن تنها ۱۷ کیلوگرم و شاسی ترکیبی فولاد و آلومینیوم، دوام بالایی دارد. چرخ‌های ۱۲ اینچ توپر جلو و عقب، آن را برای جابجایی در فضاهای مختلف بسیار کاربردی کرده و رنگ پودری الکترواستاتیک نیز مقاومت بالایی در برابر خط و خش ایجاد می‌کند."}'::jsonb,
  '{"fa":"ویلچر دستی تاشو آلفا 750، فوق‌سبک با وزن ۱۷ کیلوگرم، شاسی فولاد و آلومینیوم و چرخ‌های ۱۲ اینچ."}'::jsonb,
  '[{"fa":"قابلیت تاشوندگی"},{"fa":"زیرآرنجی متحرک و قابل تنظیم"},{"fa":"زیرپایی متحرک و قابل تنظیم ارتفاع صندلی"},{"fa":"کمربند ضربدری (Double Cross Over)"},{"fa":"رنگ الکترواستاتیک پودری مقاوم"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha750');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha750');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'alpha750');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:alpha750:technical',
  (SELECT id FROM public.products WHERE slug = 'alpha750'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha750:technical:weight',
  'seed:alpha750:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۱۷ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha750:technical:capacity',
  'seed:alpha750:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha750:technical:dimensions',
  'seed:alpha750:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۹۷ × عرض ۵۶ × ارتفاع ۸۹ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha750:technical:frame_material',
  'seed:alpha750:technical',
  'frame_material',
  '{"fa":"جنس فریم","en":"Frame Material"}'::jsonb,
  '{"fa":"فولاد و آلومینیوم"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha750:technical:finish',
  'seed:alpha750:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک پودری"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha750:technical:wheel_type',
  'seed:alpha750:technical',
  'wheel_type',
  '{"fa":"نوع چرخ","en":"Wheel Type"}'::jsonb,
  '{"fa":"چرخ‌های جلو و عقب ۱۲ اینچ (توپر)"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:alpha750:technical:standards',
  'seed:alpha750:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  6
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:alpha750:cert:0',
  (SELECT id FROM public.products WHERE slug = 'alpha750'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:alpha750:faq:0',
  (SELECT id FROM public.products WHERE slug = 'alpha750'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:alpha750:faq:1',
  (SELECT id FROM public.products WHERE slug = 'alpha750'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);
COMMIT;
