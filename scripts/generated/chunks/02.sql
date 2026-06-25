BEGIN;
INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:fateh-luxury',
  'fateh-luxury',
  'POWER_WHEELCHAIRS'::public.product_category_key,
  'Fateh-fateh-luxury',
  'ویلچر برقی فاتح لاکچری',
  '{"fa":"Upholstered Power Wheelchairs","en":"Upholstered Power Wheelchairs"}'::jsonb,
  '{"fa":"فاطح لاکچری یک ویلچر برقی رده بالا با طراحی ارگونومیک و صندلی زاویه‌دار است که برای راحتی حداکثری کاربر طراحی شده است. موتورهای ۵۰۰ یا ۴۵۰ وات تایوان به همراه کنترلرهای DYNAMIC یا P&G و سیستم کمک‌فنر، حرکتی نرم و پایدار را تضمین می‌کنند. قابلیت افزایش ظرفیت باتری تا ۴ واحد، برد حرکتی بسیار بالایی را برای کاربران فراهم می‌آورد."}'::jsonb,
  '{"fa":"ویلچر برقی فاتح لاکچری با صندلی زاویه‌دار و ارگونومیک، سیستم کمک‌فنر و قابلیت افزایش باتری تا ۴ عدد."}'::jsonb,
  '[{"fa":"صندلی و زیرآرنجی زاویه‌دار و ارگونومیک"},{"fa":"زیرپایی قابل تنظیم"},{"fa":"سیستم تعلیق کمک‌فنر"},{"fa":"قابلیت افزایش تعداد باتری تا ۴ عدد"},{"fa":"سیستم روشنایی"},{"fa":"کمربند ایمنی"},{"fa":"سیستم ضد واژگونی"},{"fa":"سیستم کنترلر DYNAMIC یا P&G"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-luxury');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-luxury');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-luxury');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:fateh-luxury:technical',
  (SELECT id FROM public.products WHERE slug = 'fateh-luxury'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:weight',
  'seed:fateh-luxury:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۹۸ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:capacity',
  'seed:fateh-luxury:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:dimensions',
  'seed:fateh-luxury:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۰۶ × عرض ۶۸ × ارتفاع ۱۲۰ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:motor_type',
  'seed:fateh-luxury:technical',
  'motor_type',
  '{"fa":"نوع موتور","en":"Motor Type"}'::jsonb,
  '{"fa":"دو موتور DC"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:motor_power',
  'seed:fateh-luxury:technical',
  'motor_power',
  '{"fa":"قدرت موتور","en":"Motor Power"}'::jsonb,
  '{"fa":"۲ × ۵۰۰ یا ۴۵۰ وات (ساخت تایوان)"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:voltage',
  'seed:fateh-luxury:technical',
  'voltage',
  '{"fa":"ولتاژ","en":"Voltage"}'::jsonb,
  '{"fa":"۱۲ ولت"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:battery_capacity',
  'seed:fateh-luxury:technical',
  'battery_capacity',
  '{"fa":"ظرفیت باتری","en":"Battery Capacity"}'::jsonb,
  '{"fa":"۴۰ یا ۴۵ آمپر ساعت (۲ عدد - قابل افزایش تا ۴ عدد)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:speed',
  'seed:fateh-luxury:technical',
  'speed',
  '{"fa":"سرعت","en":"Speed"}'::jsonb,
  '{"fa":"۱۵ کیلومتر بر ساعت (قابل تنظیم)"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:slope',
  'seed:fateh-luxury:technical',
  'slope',
  '{"fa":"زاویه شیب حرکت","en":"Slope Angle"}'::jsonb,
  '{"fa":"۱۲ درصد"}'::jsonb,
  8
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:charge_time',
  'seed:fateh-luxury:technical',
  'charge_time',
  '{"fa":"زمان شارژ مجدد","en":"Charge Time"}'::jsonb,
  '{"fa":"۵ ساعت"}'::jsonb,
  9
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:finish',
  'seed:fateh-luxury:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک (قابل سفارشی‌سازی طبق رنگ دلخواه مشتری)"}'::jsonb,
  10
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-luxury:technical:standards',
  'seed:fateh-luxury:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  11
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:fateh-luxury:cert:0',
  (SELECT id FROM public.products WHERE slug = 'fateh-luxury'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:fateh-luxury:faq:0',
  (SELECT id FROM public.products WHERE slug = 'fateh-luxury'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:fateh-luxury:faq:1',
  (SELECT id FROM public.products WHERE slug = 'fateh-luxury'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:fateh-capitan',
  'fateh-capitan',
  'POWER_WHEELCHAIRS'::public.product_category_key,
  'Fateh-fateh-capitan',
  'ویلچر برقی فاتح کاپیتان',
  '{"fa":"Upholstered Power Wheelchairs","en":"Upholstered Power Wheelchairs"}'::jsonb,
  '{"fa":"فاطح کاپیتان قدرتمندترین مدل سری فاتح با بیشینه سرعت ۱۸ کیلومتر بر ساعت و سیستم تعلیق کمک‌فنر است. با دو موتور ۵۰۰ یا ۴۵۰ وات و کنترلرهای DYNAMIC یا P&G، این ویلچر برای کاربرانی که نیازمند سرعت بالا و تردد در مسیرهای طولانی و چالش‌برانگیز هستند طراحی شده است. صندلی و زیرآرنجی زاویه‌دار، سیستم ضد واژگونی و قابلیت افزایش ظرفیت باتری تا ۴ عدد، ایمنی و کارایی آن را تضمین می‌کنند."}'::jsonb,
  '{"fa":"ویلچر برقی فاتح کاپیتان با بیشینه سرعت ۱۸ کیلومتر بر ساعت، موتورهای ۵۰۰/۴۵۰ وات و سیستم تعلیق کمک‌فنر کامل."}'::jsonb,
  '[{"fa":"صندلی و زیرآرنجی زاویه‌دار و ارگونومیک"},{"fa":"زیرپایی قابل تنظیم"},{"fa":"سیستم تعلیق کمک‌فنر"},{"fa":"قابلیت افزایش تعداد باتری تا ۴ عدد"},{"fa":"سیستم روشنایی"},{"fa":"کمربند ایمنی"},{"fa":"سیستم ضد واژگونی"},{"fa":"سیستم کنترلر DYNAMIC یا P&G"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-capitan');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-capitan');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-capitan');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:fateh-capitan:technical',
  (SELECT id FROM public.products WHERE slug = 'fateh-capitan'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:weight',
  'seed:fateh-capitan:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۱۰۲ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:capacity',
  'seed:fateh-capitan:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:dimensions',
  'seed:fateh-capitan:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۱۸ × عرض ۷۸ × ارتفاع ۱۲۲ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:motor_type',
  'seed:fateh-capitan:technical',
  'motor_type',
  '{"fa":"نوع موتور","en":"Motor Type"}'::jsonb,
  '{"fa":"دو موتور DC"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:motor_power',
  'seed:fateh-capitan:technical',
  'motor_power',
  '{"fa":"قدرت موتور","en":"Motor Power"}'::jsonb,
  '{"fa":"۲ × ۵۰۰ یا ۴۵۰ وات (ساخت تایوان)"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:voltage',
  'seed:fateh-capitan:technical',
  'voltage',
  '{"fa":"ولتاژ","en":"Voltage"}'::jsonb,
  '{"fa":"۱۲ ولت"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:battery_capacity',
  'seed:fateh-capitan:technical',
  'battery_capacity',
  '{"fa":"ظرفیت باتری","en":"Battery Capacity"}'::jsonb,
  '{"fa":"۴۰ یا ۴۵ آمپر ساعت (۲ عدد - قابل افزایش تا ۴ عدد)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:speed',
  'seed:fateh-capitan:technical',
  'speed',
  '{"fa":"سرعت","en":"Speed"}'::jsonb,
  '{"fa":"۱۸ کیلومتر بر ساعت (قابل تنظیم)"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:slope',
  'seed:fateh-capitan:technical',
  'slope',
  '{"fa":"زاویه شیب حرکت","en":"Slope Angle"}'::jsonb,
  '{"fa":"۱۲ درصد"}'::jsonb,
  8
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:charge_time',
  'seed:fateh-capitan:technical',
  'charge_time',
  '{"fa":"زمان شارژ مجدد","en":"Charge Time"}'::jsonb,
  '{"fa":"۵ ساعت"}'::jsonb,
  9
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:finish',
  'seed:fateh-capitan:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک (قابل سفارشی‌سازی طبق رنگ دلخواه مشتری)"}'::jsonb,
  10
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-capitan:technical:standards',
  'seed:fateh-capitan:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  11
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:fateh-capitan:cert:0',
  (SELECT id FROM public.products WHERE slug = 'fateh-capitan'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:fateh-capitan:faq:0',
  (SELECT id FROM public.products WHERE slug = 'fateh-capitan'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:fateh-capitan:faq:1',
  (SELECT id FROM public.products WHERE slug = 'fateh-capitan'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:fateh-extra-new',
  'fateh-extra-new',
  'POWER_WHEELCHAIRS'::public.product_category_key,
  'Fateh-fateh-extra-new',
  'ویلچر برقی فاتح اکسترا',
  '{"fa":"Upholstered Power Wheelchairs","en":"Upholstered Power Wheelchairs"}'::jsonb,
  '{"fa":"فاطح اکسترا ویژه‌ترین مدل از سری فاتح است که با تحمل وزن ۲۰۰ کیلوگرم و دو موتور ۵۰۰ یا ۴۵۰ وات ساخت تایوان، برای سنگین‌ترین کاربران طراحی شده است. کنترلرهای DYNAMIC یا P&G، سیستم کمک‌فنر و صندلی زاویه‌دار، تجربه‌ای ایمن، بادوام و قدرتمند را برای کاربران تضمین می‌کند. قابلیت افزایش باتری تا ۴ عدد نیز برای برد حرکتی بالا در نظر گرفته شده است."}'::jsonb,
  '{"fa":"ویلچر برقی فاتح اکسترا با تحمل وزن بی‌نظیر ۲۰۰ کیلوگرم، دو موتور ۵۰۰/۴۵۰ وات و سیستم تعلیق کمک‌فنر."}'::jsonb,
  '[{"fa":"صندلی زاویه‌دار"},{"fa":"زیرآرنجی و زیرپایی قابل تنظیم"},{"fa":"سیستم تعلیق کمک‌فنر"},{"fa":"قابلیت افزایش تعداد باتری تا ۴ عدد"},{"fa":"سیستم روشنایی"},{"fa":"کمربند ایمنی"},{"fa":"سیستم ضد واژگونی"},{"fa":"سیستم کنترلر DYNAMIC یا P&G"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-extra-new');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-extra-new');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-extra-new');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:fateh-extra-new:technical',
  (SELECT id FROM public.products WHERE slug = 'fateh-extra-new'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:weight',
  'seed:fateh-extra-new:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۱۰۵ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:capacity',
  'seed:fateh-extra-new:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۲۰۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:dimensions',
  'seed:fateh-extra-new:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۰۸ × عرض ۷۰ × ارتفاع ۱۲۰ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:motor_type',
  'seed:fateh-extra-new:technical',
  'motor_type',
  '{"fa":"نوع موتور","en":"Motor Type"}'::jsonb,
  '{"fa":"دو موتور DC"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:motor_power',
  'seed:fateh-extra-new:technical',
  'motor_power',
  '{"fa":"قدرت موتور","en":"Motor Power"}'::jsonb,
  '{"fa":"۲ × ۵۰۰ یا ۴۵۰ وات (ساخت تایوان)"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:voltage',
  'seed:fateh-extra-new:technical',
  'voltage',
  '{"fa":"ولتاژ","en":"Voltage"}'::jsonb,
  '{"fa":"۱۲ ولت"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:battery_capacity',
  'seed:fateh-extra-new:technical',
  'battery_capacity',
  '{"fa":"ظرفیت باتری","en":"Battery Capacity"}'::jsonb,
  '{"fa":"۴۰ یا ۴۵ آمپر ساعت (۲ عدد - قابل افزایش تا ۴ عدد)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:speed',
  'seed:fateh-extra-new:technical',
  'speed',
  '{"fa":"سرعت","en":"Speed"}'::jsonb,
  '{"fa":"۱۵ کیلومتر بر ساعت (قابل تنظیم)"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:slope',
  'seed:fateh-extra-new:technical',
  'slope',
  '{"fa":"زاویه شیب حرکت","en":"Slope Angle"}'::jsonb,
  '{"fa":"۱۲ درصد"}'::jsonb,
  8
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:charge_time',
  'seed:fateh-extra-new:technical',
  'charge_time',
  '{"fa":"زمان شارژ مجدد","en":"Charge Time"}'::jsonb,
  '{"fa":"۵ ساعت"}'::jsonb,
  9
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:finish',
  'seed:fateh-extra-new:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک (قابل سفارشی‌سازی طبق رنگ دلخواه مشتری)"}'::jsonb,
  10
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-extra-new:technical:standards',
  'seed:fateh-extra-new:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  11
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:fateh-extra-new:cert:0',
  (SELECT id FROM public.products WHERE slug = 'fateh-extra-new'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:fateh-extra-new:faq:0',
  (SELECT id FROM public.products WHERE slug = 'fateh-extra-new'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:fateh-extra-new:faq:1',
  (SELECT id FROM public.products WHERE slug = 'fateh-extra-new'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:m150-4wheel',
  'm150-4wheel',
  'MOBILITY_AIDS'::public.product_category_key,
  'Mobility Scooter-m150-4wheel',
  'اسکوتر الکترونیکی M150',
  NULL,
  '{"fa":"اسکوتر M150 یک وسیله نقلیه شخصی برقی با قابلیت جابه‌جایی آسان در فضاهای داخلی و خارجی است. با برخورداری از یک موتور ۵۰۰ وات تایوان، سیستم تعلیق کمک‌فنر، فرمان کنترل‌شونده و آینه‌های بغل، تجربه رانندگی ایمن و راحتی را برای کاربران فراهم می‌آورد. ظرفیت بالای باتری (۴۵ آمپر ساعت) و تحمل وزن ۱۵۰ کیلوگرم، آن را به گزینه‌ای برای سفرهای روزمره طولانی تبدیل کرده است."}'::jsonb,
  '{"fa":"اسکوتر برقی M150 با یک موتور ۵۰۰ وات، دارای سیستم تعلیق، آینه بغل و قابلیت حمل بار تا ۱۵۰ کیلوگرم."}'::jsonb,
  '[{"fa":"آینه بغل"},{"fa":"سیستم تعلیق کمک‌فنر"},{"fa":"قابلیت تنظیم ارتفاع زیرآرنجی"},{"fa":"سیستم روشنایی"},{"fa":"دارای سبد خرید (Shopping basket)"},{"fa":"صندلی ارگونومیک"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'm150-4wheel');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'm150-4wheel');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'm150-4wheel');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:m150-4wheel:technical',
  (SELECT id FROM public.products WHERE slug = 'm150-4wheel'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:weight',
  'seed:m150-4wheel:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۹۰ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:capacity',
  'seed:m150-4wheel:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:dimensions',
  'seed:m150-4wheel:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۲۶ × عرض ۶۴ × ارتفاع ۹۰ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:motor_type',
  'seed:m150-4wheel:technical',
  'motor_type',
  '{"fa":"نوع موتور","en":"Motor Type"}'::jsonb,
  '{"fa":"تک موتور DC"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:motor_power',
  'seed:m150-4wheel:technical',
  'motor_power',
  '{"fa":"قدرت موتور","en":"Motor Power"}'::jsonb,
  '{"fa":"۱ × ۵۰۰ وات (ساخت تایوان)"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:voltage',
  'seed:m150-4wheel:technical',
  'voltage',
  '{"fa":"ولتاژ","en":"Voltage"}'::jsonb,
  '{"fa":"۱۲ ولت"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:battery_capacity',
  'seed:m150-4wheel:technical',
  'battery_capacity',
  '{"fa":"ظرفیت باتری","en":"Battery Capacity"}'::jsonb,
  '{"fa":"۴۰ یا ۴۵ آمپر ساعت (۲ عدد)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:speed',
  'seed:m150-4wheel:technical',
  'speed',
  '{"fa":"سرعت","en":"Speed"}'::jsonb,
  '{"fa":"۱۲ کیلومتر بر ساعت (قابل تنظیم)"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:slope',
  'seed:m150-4wheel:technical',
  'slope',
  '{"fa":"زاویه شیب حرکت","en":"Slope Angle"}'::jsonb,
  '{"fa":"۱۲ درصد"}'::jsonb,
  8
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:charge_time',
  'seed:m150-4wheel:technical',
  'charge_time',
  '{"fa":"زمان شارژ مجدد","en":"Charge Time"}'::jsonb,
  '{"fa":"۵ ساعت"}'::jsonb,
  9
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:finish',
  'seed:m150-4wheel:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک"}'::jsonb,
  10
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:m150-4wheel:technical:standards',
  'seed:m150-4wheel:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  11
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:m150-4wheel:cert:0',
  (SELECT id FROM public.products WHERE slug = 'm150-4wheel'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:m150-4wheel:faq:0',
  (SELECT id FROM public.products WHERE slug = 'm150-4wheel'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:m150-4wheel:faq:1',
  (SELECT id FROM public.products WHERE slug = 'm150-4wheel'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:l160',
  'l160',
  'MOBILITY_AIDS'::public.product_category_key,
  'Electric Patient Lift-l160',
  'بالابر (لیفت) الکترونیکی بیمار L160',
  NULL,
  '{"fa":"بالابر بیمار مدل L160 با اکچویتور قدرتمند ۶۰۰۰ نیوتن برند Linak و ابعاد پایه ۶۸×۱۱۹ سانتی‌متر، برای انتقال ایمن و کم‌خطر بیماران طراحی شده است. ساختار تاشو برای حمل‌ونقل، همراه با سیستم کنترل پدالی و باتری‌های ۲×۹ آمپر ساعت، یک راه‌حل تخصصی و استاندارد برای مراکز درمانی و مراقبت‌های خانگی ارائه می‌دهد."}'::jsonb,
  '{"fa":"لیفت بیمار الکترونیکی L160، مجهز به اکچویتور ۶۰۰۰ نیوتن Linak و قابلیت تحمل وزن ۱۲۰ کیلوگرم."}'::jsonb,
  '[{"fa":"پدال کنترل زاویه‌دار (Angular Foot Pedal)"},{"fa":"قابلیت تاشوندگی برای حمل‌ونقل"},{"fa":"عملکرد روان اکچویتور Linak"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'l160');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'l160');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'l160');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:l160:technical',
  (SELECT id FROM public.products WHERE slug = 'l160'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l160:technical:actuator_type',
  'seed:l160:technical',
  'actuator_type',
  '{"fa":"نوع اکچویتور","en":"Actuator Type"}'::jsonb,
  '{"fa":"۶۰۰۰ نیوتن (Linak)"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l160:technical:battery',
  'seed:l160:technical',
  'battery',
  '{"fa":"باتری","en":"Battery"}'::jsonb,
  '{"fa":"۲×۲/۹ آمپر ساعت"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l160:technical:weight',
  'seed:l160:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۵۰ کیلوگرم"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l160:technical:capacity',
  'seed:l160:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۲۰ کیلوگرم"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l160:technical:dimensions',
  'seed:l160:technical',
  'dimensions',
  '{"fa":"ابعاد پایه","en":"Base Dimensions"}'::jsonb,
  '{"fa":"طول ۱۱۹ × عرض ۶۸ سانتی‌متر"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l160:technical:standards',
  'seed:l160:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  5
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:l160:cert:0',
  (SELECT id FROM public.products WHERE slug = 'l160'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:l160:faq:0',
  (SELECT id FROM public.products WHERE slug = 'l160'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:l160:faq:1',
  (SELECT id FROM public.products WHERE slug = 'l160'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:l180',
  'l180',
  'MOBILITY_AIDS'::public.product_category_key,
  'Electric Patient Lift-l180',
  'بالابر (لیفت) الکترونیکی بیمار L180',
  NULL,
  '{"fa":"بالابر بیمار مدل L180 با قابلیت تحمل ۱۵۰ کیلوگرم وزن، به کاربران امکان جابجایی بیماران سنگین‌وزن را با استفاده از اکچویتور ۶۰۰۰ نیوتن برند Linak می‌دهد. سیستم پدال کنترل زاویه‌دار و قابلیت تاشوندگی، آن را به یکی از تجهیزات حیاتی و ضروری در کلینیک‌ها و مراکز مراقبت‌های ویژه تبدیل کرده است."}'::jsonb,
  '{"fa":"لیفت بیمار الکترونیکی L180، مجهز به اکچویتور ۶۰۰۰ نیوتن Linak و قابلیت تحمل وزن ۱۵۰ کیلوگرم."}'::jsonb,
  '[{"fa":"پدال کنترل زاویه‌دار (Angular Foot Pedal)"},{"fa":"قابلیت تاشوندگی برای حمل‌ونقل"},{"fa":"عملکرد روان اکچویتور Linak"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'l180');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'l180');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'l180');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:l180:technical',
  (SELECT id FROM public.products WHERE slug = 'l180'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l180:technical:actuator_type',
  'seed:l180:technical',
  'actuator_type',
  '{"fa":"نوع اکچویتور","en":"Actuator Type"}'::jsonb,
  '{"fa":"۶۰۰۰ نیوتن (Linak)"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l180:technical:battery',
  'seed:l180:technical',
  'battery',
  '{"fa":"باتری","en":"Battery"}'::jsonb,
  '{"fa":"۲×۲/۹ آمپر ساعت"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l180:technical:weight',
  'seed:l180:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۵۲ کیلوگرم"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l180:technical:capacity',
  'seed:l180:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l180:technical:dimensions',
  'seed:l180:technical',
  'dimensions',
  '{"fa":"ابعاد پایه","en":"Base Dimensions"}'::jsonb,
  '{"fa":"طول ۱۱۹ × عرض ۶۸ سانتی‌متر"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:l180:technical:standards',
  'seed:l180:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  5
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:l180:cert:0',
  (SELECT id FROM public.products WHERE slug = 'l180'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:l180:faq:0',
  (SELECT id FROM public.products WHERE slug = 'l180'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:l180:faq:1',
  (SELECT id FROM public.products WHERE slug = 'l180'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);
COMMIT;
