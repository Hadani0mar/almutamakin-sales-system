# نظام المتمكن - Almutamakin Sales System

نظام إدارة المبيعات والمخزون الشامل مبني باستخدام Flutter.

## المميزات

- **نقطة البيع (POS)**: واجهة بيع احترافية مع دعم طرق دفع متعددة
- **إدارة الفواتير**: عرض وإدارة فواتير المبيعات مع إحصائيات شاملة
- **إدارة المخزون**: عرض وإدارة المنتجات مع تفاصيل كاملة
- **سجل العمليات**: تتبع جميع العمليات والأنشطة في النظام
- **واجهة عربية كاملة**: دعم كامل للغة العربية مع RTL

## المتطلبات

- Flutter SDK 3.9.2 أو أحدث
- Windows 10 أو أحدث
- SQL Server Database
- Visual C++ Redistributable

## التثبيت

1. استنسخ المستودع:
```bash
git clone https://github.com/Hadani0mar/almutamakin-sales-system.git
cd almutamakin-sales-system
```

2. تثبيت الحزم:
```bash
flutter pub get
```

3. تشغيل التطبيق:
```bash
flutter run -d windows
```

## البناء للنشر

لإنشاء نسخة release جاهزة للنشر:

```bash
flutter build windows --release
```

الملفات المبنية ستكون في: `build/windows/x64/runner/Release/`

## البنية

```
lib/
├── main.dart                    # نقطة الدخول الرئيسية
├── database_service.dart        # خدمة قاعدة البيانات
├── screens/                     # شاشات التطبيق
│   ├── login_screen.dart       # شاشة تسجيل الدخول
│   ├── home_screen.dart        # الشاشة الرئيسية
│   ├── pos_screen.dart         # شاشة نقطة البيع
│   ├── sales_invoices_screen.dart  # شاشة الفواتير
│   ├── stock_management_screen.dart # شاشة المخزون
│   └── user_session_actions_screen.dart # سجل العمليات
└── theme/                      # الثيمات والتصميم
    └── app_theme.dart
```

## الإعدادات

قبل التشغيل، تأكد من:
1. إعداد اتصال قاعدة البيانات في `database_service.dart`
2. تكوين معلومات SQL Server
3. التأكد من وجود جداول قاعدة البيانات المطلوبة

## المساهمة

نرحب بالمساهمات! يرجى فتح Issue أو Pull Request.

## الترخيص

هذا المشروع خاص.

## المطور

نظام المتمكن - Almutamakin Sales System

## الروابط

- [GitHub Repository](https://github.com/Hadani0mar/almutamakin-sales-system)
