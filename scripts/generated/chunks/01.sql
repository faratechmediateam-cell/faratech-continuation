BEGIN;
INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:beta25',
  'beta25',
  'POWER_WHEELCHAIRS'::public.product_category_key,
  'Beta-beta25',
  'ویلچر برقی بتا 25',
  '{"fa":"Foldable Power Wheelchairs","en":"Foldable Power Wheelchairs"}'::jsonb,
  '{"fa":"بتا 25 به عنوان یک ویلچر برقی با قابلیت حمل و نقل آسان طراحی شده است. این دستگاه با بهره‌گیری از دو موتور ۲۵۰ وات تایوان و سیستم کنترلر پیشرفته DYNAMIC یا P&G، امکان حرکت ایمن در شیب‌های تا ۱۲ درصد و حمل کاربرانی با وزن تا ۹۵ کیلوگرم را فراهم می‌آورد. طراحی تاشو و قابلیت تنظیم ارتفاع زیرآرنجی و زیرپایی، آن را به گزینه‌ای ایده‌آل برای استفاده‌های روزمره و جابه‌جایی تبدیل کرده است."}'::jsonb,
  '{"fa":"ویلچر برقی تاشو بتا 25، با دو موتور ۲۵۰ وات ساخت تایوان و کنترلر DYNAMIC / P&G."}'::jsonb,
  '[{"fa":"قابلیت تاشو با باتری"},{"fa":"زیر آرنجی متحرک (قابل تنظیم ارتفاع)"},{"fa":"زیرپایی متحرک (قابل تنظیم ارتفاع)"},{"fa":"سیستم کنترلر DYNAMIC یا P&G"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'beta25');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'beta25');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'beta25');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:beta25:technical',
  (SELECT id FROM public.products WHERE slug = 'beta25'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:weight',
  'seed:beta25:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۴۹ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:capacity',
  'seed:beta25:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۹۵ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:dimensions',
  'seed:beta25:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۰۵ × عرض ۶۰ × ارتفاع ۹۲ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:motor_type',
  'seed:beta25:technical',
  'motor_type',
  '{"fa":"نوع موتور","en":"Motor Type"}'::jsonb,
  '{"fa":"دو موتور DC"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:motor_power',
  'seed:beta25:technical',
  'motor_power',
  '{"fa":"قدرت موتور","en":"Motor Power"}'::jsonb,
  '{"fa":"۲ × ۲۵۰ وات (ساخت تایوان)"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:voltage',
  'seed:beta25:technical',
  'voltage',
  '{"fa":"ولتاژ","en":"Voltage"}'::jsonb,
  '{"fa":"۱۲ ولت"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:battery_capacity',
  'seed:beta25:technical',
  'battery_capacity',
  '{"fa":"ظرفیت باتری","en":"Battery Capacity"}'::jsonb,
  '{"fa":"۱۸ یا ۲۲ آمپر ساعت (۲ عدد)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:speed',
  'seed:beta25:technical',
  'speed',
  '{"fa":"سرعت","en":"Speed"}'::jsonb,
  '{"fa":"۸ کیلومتر بر ساعت (قابل تنظیم)"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:slope',
  'seed:beta25:technical',
  'slope',
  '{"fa":"زاویه شیب حرکت","en":"Slope Angle"}'::jsonb,
  '{"fa":"۱۲ درصد"}'::jsonb,
  8
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:charge_time',
  'seed:beta25:technical',
  'charge_time',
  '{"fa":"زمان شارژ مجدد","en":"Charge Time"}'::jsonb,
  '{"fa":"۳ ساعت"}'::jsonb,
  9
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:finish',
  'seed:beta25:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک (قابل سفارشی‌سازی طبق رنگ دلخواه مشتری)"}'::jsonb,
  10
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:beta25:technical:standards',
  'seed:beta25:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  11
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:beta25:cert:0',
  (SELECT id FROM public.products WHERE slug = 'beta25'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:beta25:faq:0',
  (SELECT id FROM public.products WHERE slug = 'beta25'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:beta25:faq:1',
  (SELECT id FROM public.products WHERE slug = 'beta25'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:delta35',
  'delta35',
  'POWER_WHEELCHAIRS'::public.product_category_key,
  'Delta-delta35',
  'ویلچر برقی دلتا 35',
  '{"fa":"Foldable Power Wheelchairs","en":"Foldable Power Wheelchairs"}'::jsonb,
  '{"fa":"دلتا 35 یک مدل تاشو با توان موتوری بالاتر (۳۵۰ وات) است که برای ارائه عملکردی روان‌تر در مسیرهای متنوع طراحی شده است. با برخورداری از سیستم کنترلرهای باکیفیت DYNAMIC یا P&G، این ویلچر قابلیت حرکت ایمن در شیب‌های تا ۱۲ درصد را دارد. وزن ۵۱ کیلوگرم و ابعاد ۱۱۶×۷۶ سانتی‌متر، همراه با امکانات تنظیم ارتفاع زیرآرنجی و زیرپایی، تجربه کاربری مطلوب و استانداردهای ایمنی قابل قبولی را به کاربر ارائه می‌دهد."}'::jsonb,
  '{"fa":"ویلچر برقی تاشو دلتا 35، با دو موتور قدرتمند ۳۵۰ وات ساخت تایوان و سیستم کنترلر DYNAMIC / P&G."}'::jsonb,
  '[{"fa":"قابلیت تاشو با باتری"},{"fa":"زیر آرنجی متحرک (قابل تنظیم ارتفاع)"},{"fa":"زیرپایی متحرک (قابل تنظیم ارتفاع)"},{"fa":"سیستم کنترلر DYNAMIC یا P&G"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'delta35');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'delta35');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'delta35');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:delta35:technical',
  (SELECT id FROM public.products WHERE slug = 'delta35'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:weight',
  'seed:delta35:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۵۱ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:capacity',
  'seed:delta35:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۹۵ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:dimensions',
  'seed:delta35:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۱۶ × عرض ۷۶ × ارتفاع ۱۰۰ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:motor_type',
  'seed:delta35:technical',
  'motor_type',
  '{"fa":"نوع موتور","en":"Motor Type"}'::jsonb,
  '{"fa":"دو موتور DC"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:motor_power',
  'seed:delta35:technical',
  'motor_power',
  '{"fa":"قدرت موتور","en":"Motor Power"}'::jsonb,
  '{"fa":"۲ × ۳۵۰ وات (ساخت تایوان)"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:voltage',
  'seed:delta35:technical',
  'voltage',
  '{"fa":"ولتاژ","en":"Voltage"}'::jsonb,
  '{"fa":"۱۲ ولت"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:battery_capacity',
  'seed:delta35:technical',
  'battery_capacity',
  '{"fa":"ظرفیت باتری","en":"Battery Capacity"}'::jsonb,
  '{"fa":"۱۸ یا ۲۲ آمپر ساعت (۲ عدد)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:speed',
  'seed:delta35:technical',
  'speed',
  '{"fa":"سرعت","en":"Speed"}'::jsonb,
  '{"fa":"۱۰ کیلومتر بر ساعت (قابل تنظیم)"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:slope',
  'seed:delta35:technical',
  'slope',
  '{"fa":"زاویه شیب حرکت","en":"Slope Angle"}'::jsonb,
  '{"fa":"۱۲ درصد"}'::jsonb,
  8
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:charge_time',
  'seed:delta35:technical',
  'charge_time',
  '{"fa":"زمان شارژ مجدد","en":"Charge Time"}'::jsonb,
  '{"fa":"۳ ساعت"}'::jsonb,
  9
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:finish',
  'seed:delta35:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک (قابل سفارشی‌سازی طبق رنگ دلخواه مشتری)"}'::jsonb,
  10
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:delta35:technical:standards',
  'seed:delta35:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  11
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:delta35:cert:0',
  (SELECT id FROM public.products WHERE slug = 'delta35'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:delta35:faq:0',
  (SELECT id FROM public.products WHERE slug = 'delta35'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:delta35:faq:1',
  (SELECT id FROM public.products WHERE slug = 'delta35'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:gamma45',
  'gamma45',
  'POWER_WHEELCHAIRS'::public.product_category_key,
  'Gamma-gamma45',
  'ویلچر برقی گاما 45 - 45XL',
  '{"fa":"Foldable Power Wheelchairs","en":"Foldable Power Wheelchairs"}'::jsonb,
  '{"fa":"گاما 45-45XL یک ویلچر برقی تاشو با استانداردهای بالای مهندسی پزشکی است. این دستگاه با بهره‌گیری از دو موتور ۴۵۰ وات و سیستم کنترلر DYNAMIC یا P&G، توانایی حرکت در شیب‌های تا ۱۲ درصد و حمل کاربرانی با وزن تا ۱۲۰ کیلوگرم را دارا می‌باشد. سیستم باتری دوگانه ۳۰ آمپر ساعت، زمان شارژ ۴ ساعته را تضمین کرده و قابلیت جداسازی باتری، تاشوندگی، و تنظیم ارتفاع زیرآرنجی و زیرپایی، حمل‌ونقل و انبارش دستگاه را برای مراقبین و کاربران تسهیل می‌نماید."}'::jsonb,
  '{"fa":"ویلچر برقی تاشو گاما 45-45XL، مجهز به سیستم محرکه دوگانه ۴۵۰ وات ساخت تایوان و کنترلرهای معتبر DYNAMIC / P&G، با قابلیت حمل بار تا ۱۲۰ کیلوگرم."}'::jsonb,
  '[{"fa":"قابلیت تاشو و جمع‌آوری"},{"fa":"باتری قابل جداسازی (Detachable battery)"},{"fa":"زیر آرنجی قابل تنظیم ارتفاع"},{"fa":"زیرپایی متحرک و قابل تنظیم"},{"fa":"دارای کمربند ایمنی"},{"fa":"سیستم کنترلر DYNAMIC یا P&G"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'gamma45');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'gamma45');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'gamma45');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:gamma45:technical',
  (SELECT id FROM public.products WHERE slug = 'gamma45'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:weight',
  'seed:gamma45:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۵۸ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:capacity',
  'seed:gamma45:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۲۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:dimensions',
  'seed:gamma45:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۰۴ × عرض ۷۰ × ارتفاع ۹۴ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:motor_type',
  'seed:gamma45:technical',
  'motor_type',
  '{"fa":"نوع موتور","en":"Motor Type"}'::jsonb,
  '{"fa":"دو موتور DC"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:motor_power',
  'seed:gamma45:technical',
  'motor_power',
  '{"fa":"قدرت موتور","en":"Motor Power"}'::jsonb,
  '{"fa":"۲ × ۴۵۰ وات (ساخت تایوان)"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:voltage',
  'seed:gamma45:technical',
  'voltage',
  '{"fa":"ولتاژ","en":"Voltage"}'::jsonb,
  '{"fa":"۱۲ ولت"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:battery_capacity',
  'seed:gamma45:technical',
  'battery_capacity',
  '{"fa":"ظرفیت باتری","en":"Battery Capacity"}'::jsonb,
  '{"fa":"۲۸ یا ۳۰ آمپر ساعت (۲ عدد)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:speed',
  'seed:gamma45:technical',
  'speed',
  '{"fa":"سرعت","en":"Speed"}'::jsonb,
  '{"fa":"۱۰ کیلومتر بر ساعت (قابل تنظیم)"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:slope',
  'seed:gamma45:technical',
  'slope',
  '{"fa":"زاویه شیب حرکت","en":"Slope Angle"}'::jsonb,
  '{"fa":"۱۲ درصد"}'::jsonb,
  8
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:charge_time',
  'seed:gamma45:technical',
  'charge_time',
  '{"fa":"زمان شارژ مجدد","en":"Charge Time"}'::jsonb,
  '{"fa":"۴ ساعت"}'::jsonb,
  9
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:finish',
  'seed:gamma45:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک (قابل سفارشی‌سازی طبق رنگ دلخواه مشتری)"}'::jsonb,
  10
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:gamma45:technical:standards',
  'seed:gamma45:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  11
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:gamma45:cert:0',
  (SELECT id FROM public.products WHERE slug = 'gamma45'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:gamma45:faq:0',
  (SELECT id FROM public.products WHERE slug = 'gamma45'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:gamma45:faq:1',
  (SELECT id FROM public.products WHERE slug = 'gamma45'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:super-gamma',
  'super-gamma',
  'POWER_WHEELCHAIRS'::public.product_category_key,
  'Gamma-super-gamma',
  'ویلچر برقی سوپر گاما',
  '{"fa":"Foldable Power Wheelchairs","en":"Foldable Power Wheelchairs"}'::jsonb,
  '{"fa":"سوپر گاما یک ویلچر برقی تاشوی پیشرفته در کلاس سنگین است که با دو موتور ۵۰۰ وات و سیستم کنترلر DYNAMIC یا P&G، قدرت مانور و شتاب بالایی را ارائه می‌دهد. این دستگاه قادر است کاربرانی تا وزن ۱۲۰ کیلوگرم را به راحتی جابجا کرده و در شیب‌های تا ۱۲ درصد به صورت ایمن تردد نماید. طراحی تاشو، باتری جداشونده، امکان تنظیم زیرآرنجی و زیرپایی، همراه با سیستم روشنایی و کمربند ایمنی، استانداردهای یک ویلچر برقی مدرن و کاربردی را فراهم می‌آورد."}'::jsonb,
  '{"fa":"ویلچر برقی تاشو سوپر گاما، مجهز به دو موتور قدرتمند ۵۰۰ وات ساخت تایوان و سیستم کنترلر DYNAMIC / P&G، با بیشینه سرعت ۱۵ کیلومتر بر ساعت."}'::jsonb,
  '[{"fa":"قابلیت تاشو و جمع‌آوری"},{"fa":"باتری قابل جداسازی"},{"fa":"زیر آرنجی و زیرپایی قابل تنظیم"},{"fa":"سیستم روشنایی"},{"fa":"کمربند ایمنی"},{"fa":"سیستم کنترلر DYNAMIC یا P&G"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'super-gamma');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'super-gamma');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'super-gamma');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:super-gamma:technical',
  (SELECT id FROM public.products WHERE slug = 'super-gamma'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:weight',
  'seed:super-gamma:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۶۰ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:capacity',
  'seed:super-gamma:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۲۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:dimensions',
  'seed:super-gamma:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۰۴ × عرض ۶۱ × ارتفاع ۹۸ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:motor_type',
  'seed:super-gamma:technical',
  'motor_type',
  '{"fa":"نوع موتور","en":"Motor Type"}'::jsonb,
  '{"fa":"دو موتور DC"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:motor_power',
  'seed:super-gamma:technical',
  'motor_power',
  '{"fa":"قدرت موتور","en":"Motor Power"}'::jsonb,
  '{"fa":"۲ × ۵۰۰ وات (ساخت تایوان)"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:voltage',
  'seed:super-gamma:technical',
  'voltage',
  '{"fa":"ولتاژ","en":"Voltage"}'::jsonb,
  '{"fa":"۱۲ ولت"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:battery_capacity',
  'seed:super-gamma:technical',
  'battery_capacity',
  '{"fa":"ظرفیت باتری","en":"Battery Capacity"}'::jsonb,
  '{"fa":"۲۸ یا ۳۰ آمپر ساعت (۲ عدد)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:speed',
  'seed:super-gamma:technical',
  'speed',
  '{"fa":"سرعت","en":"Speed"}'::jsonb,
  '{"fa":"۱۵ کیلومتر بر ساعت (قابل تنظیم)"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:slope',
  'seed:super-gamma:technical',
  'slope',
  '{"fa":"زاویه شیب حرکت","en":"Slope Angle"}'::jsonb,
  '{"fa":"۱۲ درصد"}'::jsonb,
  8
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:charge_time',
  'seed:super-gamma:technical',
  'charge_time',
  '{"fa":"زمان شارژ مجدد","en":"Charge Time"}'::jsonb,
  '{"fa":"۴ ساعت"}'::jsonb,
  9
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:finish',
  'seed:super-gamma:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک (قابل سفارشی‌سازی طبق رنگ دلخواه مشتری)"}'::jsonb,
  10
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:super-gamma:technical:standards',
  'seed:super-gamma:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  11
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:super-gamma:cert:0',
  (SELECT id FROM public.products WHERE slug = 'super-gamma'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:super-gamma:faq:0',
  (SELECT id FROM public.products WHERE slug = 'super-gamma'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:super-gamma:faq:1',
  (SELECT id FROM public.products WHERE slug = 'super-gamma'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:fateh-lx2',
  'fateh-lx2',
  'POWER_WHEELCHAIRS'::public.product_category_key,
  'Fateh-fateh-lx2',
  'ویلچر برقی فاتح LX2',
  '{"fa":"Upholstered Power Wheelchairs","en":"Upholstered Power Wheelchairs"}'::jsonb,
  '{"fa":"فاطح LX2 یک ویلچر برقی سنگین و با دوام است که برای عبور از مسیرهای سخت و خارجی طراحی شده است. این دستگاه با بهره‌گیری از دو موتور قدرتمند ۵۰۰ یا ۴۵۰ وات ساخت تایوان، سیستم کمک‌فنر (شاک‌آبسورب)، و کنترلرهای DYNAMIC یا P&G، قدرت و نرمی حرکت را تضمین می‌کند. صندلی زاویه‌دار و قابلیت افزایش ظرفیت باتری تا ۴ عدد، آن را به انتخابی استراتژیک برای استفاده‌های سنگین تبدیل نموده است."}'::jsonb,
  '{"fa":"ویلچر برقی فاتح LX2 با دو موتور ۵۰۰ یا ۴۵۰ وات و سیستم تعلیق کمک‌فنر، مناسب برای مسیرهای خارجی و ناهموار."}'::jsonb,
  '[{"fa":"صندلی زاویه‌دار"},{"fa":"سیستم تعلیق کمک‌فنر"},{"fa":"قابلیت افزایش تعداد باتری تا ۴ عدد"},{"fa":"زیر آرنجی و زیرپایی قابل تنظیم"},{"fa":"سیستم روشنایی"},{"fa":"کمربند ایمنی"},{"fa":"سیستم ضد واژگونی"},{"fa":"سیستم کنترلر DYNAMIC یا P&G"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-lx2');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-lx2');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-lx2');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:fateh-lx2:technical',
  (SELECT id FROM public.products WHERE slug = 'fateh-lx2'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:weight',
  'seed:fateh-lx2:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۹۸ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:capacity',
  'seed:fateh-lx2:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:dimensions',
  'seed:fateh-lx2:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۰۶ × عرض ۶۹ × ارتفاع ۱۱۲ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:motor_type',
  'seed:fateh-lx2:technical',
  'motor_type',
  '{"fa":"نوع موتور","en":"Motor Type"}'::jsonb,
  '{"fa":"دو موتور DC"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:motor_power',
  'seed:fateh-lx2:technical',
  'motor_power',
  '{"fa":"قدرت موتور","en":"Motor Power"}'::jsonb,
  '{"fa":"۲ × ۵۰۰ یا ۴۵۰ وات (ساخت تایوان)"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:voltage',
  'seed:fateh-lx2:technical',
  'voltage',
  '{"fa":"ولتاژ","en":"Voltage"}'::jsonb,
  '{"fa":"۱۲ ولت"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:battery_capacity',
  'seed:fateh-lx2:technical',
  'battery_capacity',
  '{"fa":"ظرفیت باتری","en":"Battery Capacity"}'::jsonb,
  '{"fa":"۴۰ یا ۴۵ آمپر ساعت (۲ عدد - قابل افزایش تا ۴ عدد)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:speed',
  'seed:fateh-lx2:technical',
  'speed',
  '{"fa":"سرعت","en":"Speed"}'::jsonb,
  '{"fa":"۱۵ کیلومتر بر ساعت (قابل تنظیم)"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:slope',
  'seed:fateh-lx2:technical',
  'slope',
  '{"fa":"زاویه شیب حرکت","en":"Slope Angle"}'::jsonb,
  '{"fa":"۱۲ درصد"}'::jsonb,
  8
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:charge_time',
  'seed:fateh-lx2:technical',
  'charge_time',
  '{"fa":"زمان شارژ مجدد","en":"Charge Time"}'::jsonb,
  '{"fa":"۵ ساعت"}'::jsonb,
  9
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:finish',
  'seed:fateh-lx2:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک (قابل سفارشی‌سازی طبق رنگ دلخواه مشتری)"}'::jsonb,
  10
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-lx2:technical:standards',
  'seed:fateh-lx2:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  11
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:fateh-lx2:cert:0',
  (SELECT id FROM public.products WHERE slug = 'fateh-lx2'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:fateh-lx2:faq:0',
  (SELECT id FROM public.products WHERE slug = 'fateh-lx2'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:fateh-lx2:faq:1',
  (SELECT id FROM public.products WHERE slug = 'fateh-lx2'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);

INSERT INTO public.products (id, slug, category_key, code, name, series, description, short_description, features, status)
VALUES (
  'seed:fateh-jx2-lift',
  'fateh-jx2-lift',
  'POWER_WHEELCHAIRS'::public.product_category_key,
  'Fateh-fateh-jx2-lift',
  'ویلچر برقی فاتح JX2',
  '{"fa":"Upholstered Power Wheelchairs","en":"Upholstered Power Wheelchairs"}'::jsonb,
  '{"fa":"فاطح JX2 مدلی از سری حرفه‌ای فاتح است که بر روی ارگونومی و راحتی کاربر تمرکز دارد. با بهره‌گیری از دو موتور ۵۰۰/۴۵۰ وات تایوان، کنترلرهای DYNAMIC یا P&G، و سیستم تعلیق کمک‌فنر، حرکتی نرم و قدرتمند را ارائه می‌دهد. قابلیت تنظیم ارتفاع صندلی، زیرآرنجی، و زیرپایی، شخصی‌سازی کامل را برای کاربران فراهم می‌سازد."}'::jsonb,
  '{"fa":"ویلچر برقی فاتح JX2، مجهز به سیستم تعلیق کمک‌فنر، صندلی و زیرآرنجی کاملاً تنظیم‌شونده با دو موتور ۵۰۰ یا ۴۵۰ وات."}'::jsonb,
  '[{"fa":"صندلی و زیرآرنجی قابل تنظیم ارتفاع"},{"fa":"زیرپایی متحرک و قابل تنظیم"},{"fa":"سیستم تعلیق کمک‌فنر"},{"fa":"سیستم روشنایی"},{"fa":"کمربند ایمنی"},{"fa":"سیستم ضد واژگونی"},{"fa":"سیستم کنترلر DYNAMIC یا P&G"}]'::jsonb,
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
DELETE FROM public.specification_groups WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-jx2-lift');
DELETE FROM public.certifications      WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-jx2-lift');
DELETE FROM public.faq_items           WHERE product_id = (SELECT id FROM public.products WHERE slug = 'fateh-jx2-lift');
INSERT INTO public.specification_groups (id, product_id, key, label, position) VALUES (
  'seed:fateh-jx2-lift:technical',
  (SELECT id FROM public.products WHERE slug = 'fateh-jx2-lift'),
  'technical',
  '{"fa":"مشخصات فنی","en":"Technical Specifications"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:weight',
  'seed:fateh-jx2-lift:technical',
  'weight',
  '{"fa":"وزن","en":"Weight"}'::jsonb,
  '{"fa":"۱۰۲ کیلوگرم"}'::jsonb,
  0
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:capacity',
  'seed:fateh-jx2-lift:technical',
  'capacity',
  '{"fa":"تحمل وزن","en":"Weight Capacity"}'::jsonb,
  '{"fa":"۱۵۰ کیلوگرم"}'::jsonb,
  1
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:dimensions',
  'seed:fateh-jx2-lift:technical',
  'dimensions',
  '{"fa":"ابعاد دستگاه","en":"Dimensions"}'::jsonb,
  '{"fa":"طول ۱۰۸ × عرض ۶۵ × ارتفاع ۱۲۲ سانتی‌متر"}'::jsonb,
  2
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:motor_type',
  'seed:fateh-jx2-lift:technical',
  'motor_type',
  '{"fa":"نوع موتور","en":"Motor Type"}'::jsonb,
  '{"fa":"دو موتور DC"}'::jsonb,
  3
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:motor_power',
  'seed:fateh-jx2-lift:technical',
  'motor_power',
  '{"fa":"قدرت موتور","en":"Motor Power"}'::jsonb,
  '{"fa":"۲ × ۵۰۰ یا ۴۵۰ وات (ساخت تایوان)"}'::jsonb,
  4
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:voltage',
  'seed:fateh-jx2-lift:technical',
  'voltage',
  '{"fa":"ولتاژ","en":"Voltage"}'::jsonb,
  '{"fa":"۱۲ ولت"}'::jsonb,
  5
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:battery_capacity',
  'seed:fateh-jx2-lift:technical',
  'battery_capacity',
  '{"fa":"ظرفیت باتری","en":"Battery Capacity"}'::jsonb,
  '{"fa":"۴۰ یا ۴۵ آمپر ساعت (۲ عدد)"}'::jsonb,
  6
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:speed',
  'seed:fateh-jx2-lift:technical',
  'speed',
  '{"fa":"سرعت","en":"Speed"}'::jsonb,
  '{"fa":"۱۵ کیلومتر بر ساعت (قابل تنظیم)"}'::jsonb,
  7
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:slope',
  'seed:fateh-jx2-lift:technical',
  'slope',
  '{"fa":"زاویه شیب حرکت","en":"Slope Angle"}'::jsonb,
  '{"fa":"۱۲ درصد"}'::jsonb,
  8
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:charge_time',
  'seed:fateh-jx2-lift:technical',
  'charge_time',
  '{"fa":"زمان شارژ مجدد","en":"Charge Time"}'::jsonb,
  '{"fa":"۵ ساعت"}'::jsonb,
  9
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:finish',
  'seed:fateh-jx2-lift:technical',
  'finish',
  '{"fa":"جنس رنگ","en":"Finish"}'::jsonb,
  '{"fa":"الکترواستاتیک (قابل سفارشی‌سازی طبق رنگ دلخواه مشتری)"}'::jsonb,
  10
);
INSERT INTO public.specification_items (id, group_id, key, label, value, position) VALUES (
  'seed:fateh-jx2-lift:technical:standards',
  'seed:fateh-jx2-lift:technical',
  'standards',
  '{"fa":"استانداردها","en":"Standards"}'::jsonb,
  '{"fa":"ISO 13485"}'::jsonb,
  11
);
INSERT INTO public.certifications (id, product_id, name, position) VALUES (
  'seed:fateh-jx2-lift:cert:0',
  (SELECT id FROM public.products WHERE slug = 'fateh-jx2-lift'),
  'ISO 13485',
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:fateh-jx2-lift:faq:0',
  (SELECT id FROM public.products WHERE slug = 'fateh-jx2-lift'),
  '{"fa":"مدت گارانتی چقدر است؟"}'::jsonb,
  '{"fa":"۱ سال — دستگاه مشمول گارانتی می‌شود در صورتی که دچار سانحه، تصادف، یا آسیب فیزیکی ناشی از استفاده نادرست توسط مشتری نشده باشد (خرابی ناشی از استفاده غلط مشمول گارانتی نمی‌شود)."}'::jsonb,
  0
);
INSERT INTO public.faq_items (id, product_id, question, answer, position) VALUES (
  'seed:fateh-jx2-lift:faq:1',
  (SELECT id FROM public.products WHERE slug = 'fateh-jx2-lift'),
  '{"fa":"خدمات پس از فروش چگونه است؟"}'::jsonb,
  '{"fa":"ارائه خدمات، تعمیرات و پشتیبانی قطعات به مدت ۵ سال رسمی (به دلیل واردات مستقیم، تأمین قطعات تا ۱۰ الی ۱۵ سال نیز توسط مجموعه امکان‌پذیر است)."}'::jsonb,
  1
);
COMMIT;
