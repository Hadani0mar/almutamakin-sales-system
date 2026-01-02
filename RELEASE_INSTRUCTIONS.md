# تعليمات إنشاء Release على GitHub

## الخطوات السريعة:

### 1. اذهب إلى صفحة إنشاء Release:
**https://github.com/Hadani0mar/almutamakin-sales-system/releases/new**

### 2. املأ المعلومات التالية:

**Tag version:** 
```
v1.0.0
```

**Release title:**
```
الإصدار 1.0.0
```

**Description:**
```
الإصدار الأولي من نظام المتمكن

## المميزات:
- ✅ نظام نقطة البيع (POS) الاحترافي
- ✅ إدارة الفواتير مع إحصائيات شاملة
- ✅ إدارة المخزون مع تفاصيل كاملة
- ✅ سجل العمليات والأنشطة
- ✅ نظام التحديث التلقائي من GitHub Releases
- ✅ واجهة عربية كاملة مع RTL

## التثبيت:
1. استخرج ملف ZIP
2. شغّل kids_app.exe
3. سجل الدخول باستخدام بيانات المستخدم

## التحديثات:
التطبيق يتحقق تلقائياً من التحديثات. يمكنك التحقق يدوياً من القائمة الجانبية.
```

### 3. ارفع ملف ZIP:
- اضغط على "Attach binaries by dropping them here or selecting them"
- اختر الملف: `C:\Users\DELL\Desktop\Almutamakin_Sales_System\Almutamakin_Sales_System_v1.0.0.zip`

### 4. اضغط "Publish release"

---

## بعد إنشاء Release:

✅ سيتمكن المستخدمون من:
- التحقق من التحديثات تلقائياً
- تنزيل وتثبيت التحديثات من داخل التطبيق
- رؤية ملاحظات الإصدار

✅ للتحديثات المستقبلية:
1. غيّر رقم الإصدار في `pubspec.yaml` (مثل: 1.0.1)
2. ابني التطبيق: `flutter build windows --release`
3. انسخ الملفات إلى مجلد Release
4. أنشئ ZIP جديد
5. أنشئ Release جديد على GitHub برقم الإصدار الجديد

