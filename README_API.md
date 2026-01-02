# إعداد API Server للاتصال بقاعدة البيانات

## المتطلبات
- .NET SDK 8.0 أو أحدث
- SQL Server يعمل على localhost
- قاعدة البيانات: InfinityRetailDB

## خطوات التشغيل

### 1. تشغيل API Server

**الطريقة 1 - استخدام ملف الباتش:**
```bash
start_api.bat
```

**الطريقة 2 - يدوياً:**
```bash
cd ApiServer
dotnet run
```

### 2. التحقق من عمل API Server

افتح المتصفح على: `http://localhost:5000/api/test`

يجب أن ترى:
```json
{"connected":true,"message":"متصل بنجاح"}
```

### 3. تشغيل تطبيق Flutter

بعد أن يعمل API Server، شغّل تطبيق Flutter:
```bash
flutter run -d windows
```

## معلومات الاتصال
- **السيرفر:** localhost
- **قاعدة البيانات:** InfinityRetailDB
- **المستخدم:** sa
- **كلمة السر:** 123
- **المنفذ:** 5000

## API Endpoints

- `GET /api/test` - اختبار الاتصال
- `GET /api/tables` - الحصول على جميع الجداول
- `GET /api/columns/{schema}/{table}` - الحصول على أعمدة جدول
- `GET /api/data/{schema}/{table}?limit=100` - الحصول على بيانات جدول
- `GET /api/count/{schema}/{table}` - الحصول على عدد الصفوف
- `GET /api/sales?limit=100` - الحصول على المبيعات
- `GET /api/movements?limit=100` - الحصول على حركات المخزون
- `GET /api/products?limit=100` - الحصول على المنتجات
- `POST /api/query` - تنفيذ استعلام SQL مخصص

## ملاحظات
- تأكد من أن SQL Server يعمل
- تأكد من أن المنفذ 5000 متاح
- تأكد من تفعيل SQL Server Authentication


