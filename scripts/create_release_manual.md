# كيفية إنشاء Release على GitHub

## الطريقة 1: يدوياً (الأسهل)

1. اذهب إلى: https://github.com/Hadani0mar/almutamakin-sales-system/releases/new

2. املأ المعلومات:
   - **Tag version**: `v1.0.0` (يجب أن يبدأ بـ v)
   - **Release title**: `الإصدار 1.0.0`
   - **Description**: 
     ```
     الإصدار الأولي من نظام المتمكن
     
     المميزات:
     - نظام نقطة البيع (POS)
     - إدارة الفواتير
     - إدارة المخزون
     - سجل العمليات
     - نظام التحديث التلقائي
     ```

3. ارفع ملف ZIP:
   - اضغط على "Attach binaries by dropping them here or selecting them"
   - اختر: `C:\Users\DELL\Desktop\Almutamakin_Sales_System\Almutamakin_Sales_System_v1.0.0.zip`

4. اضغط "Publish release"

## الطريقة 2: باستخدام PowerShell Script

### المتطلبات:
- GitHub Personal Access Token

### خطوات الحصول على Token:
1. اذهب إلى: https://github.com/settings/tokens
2. اضغط "Generate new token (classic)"
3. اختر scope: `repo`
4. اضغط "Generate token"
5. انسخ الرمز (سيظهر مرة واحدة فقط!)

### تشغيل السكريبت:
```powershell
.\scripts\create_release_api.ps1 `
  -Version "1.0.0" `
  -ZipPath "C:\Users\DELL\Desktop\Almutamakin_Sales_System\Almutamakin_Sales_System_v1.0.0.zip" `
  -ReleaseNotes "الإصدار الأولي من نظام المتمكن" `
  -GitHubToken "YOUR_TOKEN_HERE"
```

## الطريقة 3: تثبيت GitHub CLI

1. تثبيت GitHub CLI:
   - تحميل من: https://cli.github.com/
   - أو باستخدام winget: `winget install --id GitHub.cli`

2. تسجيل الدخول:
   ```powershell
   gh auth login
   ```

3. إنشاء Release:
   ```powershell
   gh release create v1.0.0 `
     "C:\Users\DELL\Desktop\Almutamakin_Sales_System\Almutamakin_Sales_System_v1.0.0.zip" `
     --title "الإصدار 1.0.0" `
     --notes "الإصدار الأولي" `
     --repo Hadani0mar/almutamakin-sales-system
   ```

## ملاحظات مهمة:

- رقم الإصدار في `pubspec.yaml` يجب أن يطابق رقم الإصدار في Release
- Tag يجب أن يبدأ بـ `v` (مثل: v1.0.0)
- ملف ZIP يجب أن يحتوي على جميع الملفات المطلوبة للتشغيل

