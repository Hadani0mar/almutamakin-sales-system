# طريقة الفلترة والبحث وعرض الفواتير

## نظرة عامة

هذا المستند يشرح طريقة تنفيذ الفلترة والبحث وعرض الفواتير في التطبيق.

---

## 1. البنية الأساسية

### 1.1. الشاشة الرئيسية (`SalesInvoicesScreen`)

الشاشة تحتوي على المتغيرات التالية:

```dart
List<Map<String, dynamic>> _invoices = [];  // قائمة الفواتير
bool _isLoading = false;                    // حالة التحميل
String _searchQuery = '';                   // نص البحث
DateTime? _fromDate;                       // تاريخ البداية
DateTime? _toDate;                         // تاريخ النهاية
final TextEditingController _searchController = TextEditingController();
```

---

## 2. دالة تحميل الفواتير (`_loadInvoices`)

### 2.1. الوظيفة

```dart
Future<void> _loadInvoices() async {
  if (!mounted) return;
  setState(() => _isLoading = true);
  
  try {
    final result = await DatabaseService.getSales(
      page: 1,
      pageSize: 100,
      search: _searchQuery.isEmpty ? null : _searchQuery,
      fromDate: _fromDate,
      toDate: _toDate,
    );
    
    if (mounted) {
      setState(() {
        _invoices = List<Map<String, dynamic>>.from(result['data'] ?? []);
        _isLoading = false;
      });
    }
  } catch (e) {
    // معالجة الأخطاء
  }
}
```

### 2.2. المعاملات المرسلة

- **page**: رقم الصفحة (افتراضي: 1)
- **pageSize**: عدد العناصر في الصفحة (افتراضي: 100)
- **search**: نص البحث (null إذا كان فارغاً)
- **fromDate**: تاريخ البداية (null إذا لم يتم تحديده)
- **toDate**: تاريخ النهاية (null إذا لم يتم تحديده)

---

## 3. دالة قاعدة البيانات (`DatabaseService.getSales`)

### 3.1. تنسيق التاريخ

```dart
// تنسيق التاريخ لـ SQL Server مع التوقيت (YYYY-MM-DD HH:mm:ss)
if (fromDate != null) {
  // إضافة 00:00:00 لبداية اليوم لضمان شمول جميع الفواتير في اليوم المحدد
  fromDateStr = '${fromDate.year.toString().padLeft(4, '0')}-${fromDate.month.toString().padLeft(2, '0')}-${fromDate.day.toString().padLeft(2, '0')} 00:00:00';
}

if (toDate != null) {
  // إضافة 23:59:59 لنهاية اليوم لضمان شمول جميع الفواتير في اليوم المحدد
  toDateStr = '${toDate.year.toString().padLeft(4, '0')}-${toDate.month.toString().padLeft(2, '0')}-${toDate.day.toString().padLeft(2, '0')} 23:59:59';
}
```

**مثال**: 
- `fromDateStr`: `2024-01-15 00:00:00`
- `toDateStr`: `2024-01-15 23:59:59`

**ملاحظة مهمة**: استخدام التوقيت مباشرة بدلاً من `CAST` يحسن الأداء ويسمح لقاعدة البيانات باستخدام الفهارس (Indexes).

### 3.2. بناء شروط WHERE (موحدة لكلا الاستعلامين)

```dart
// بناء قائمة الشروط باستخدام Alias موحد (inv) لتجنب تكرار الكود
final List<String> whereConditions = ['1=1'];

// إضافة شرط البحث
if (search != null && search.isNotEmpty) {
  final escapedSearch = search.replaceAll("'", "''");
  whereConditions.add("(inv.InvoiceNumber LIKE N'%$escapedSearch%' OR inv.CashCustomerName LIKE N'%$escapedSearch%' OR inv.TransactionBarcode LIKE N'%$escapedSearch%')");
}

// إضافة شرط تاريخ البداية (بدون CAST لتحسين الأداء)
if (fromDateStr != null) {
  whereConditions.add("inv.SalesInvoiceDate >= '$fromDateStr'");
}

// إضافة شرط تاريخ النهاية (بدون CAST لتحسين الأداء)
if (toDateStr != null) {
  whereConditions.add("inv.SalesInvoiceDate <= '$toDateStr'");
}

final whereClause = 'WHERE ${whereConditions.join(' AND ')}';
```

**ملاحظة**: استخدام نفس `whereClause` لكلا الاستعلامين (COUNT و DATA) يضمن التناسق ويقلل من احتمالية الأخطاء.

### 3.3. استعلام COUNT

```sql
SELECT COUNT(*) as count
FROM BRD.Data_SalesInvoices inv
WHERE 1=1 
  AND (inv.InvoiceNumber LIKE N'%بحث%' OR inv.CashCustomerName LIKE N'%بحث%' OR inv.TransactionBarcode LIKE N'%بحث%')
  AND inv.SalesInvoiceDate >= '2024-01-01 00:00:00'
  AND inv.SalesInvoiceDate <= '2024-12-31 23:59:59'
```

**التحسينات**:
- استخدام Alias `inv` في جميع الشروط
- مقارنة التاريخ مباشرة بدون `CAST` لتحسين الأداء
- استخدام التوقيت (00:00:00 و 23:59:59) لضمان الدقة

### 3.4. استخدام نفس WHERE clause في استعلام DATA

```dart
// استخدام نفس whereClause الذي تم بناؤه سابقاً
// لا حاجة لبناء شروط منفصلة - هذا يضمن التناسق ويقلل الأخطاء
```

**ملاحظة**: تم توحيد استخدام `whereClause` في كلا الاستعلامين لضمان التناسق.

### 3.5. استعلام DATA

```sql
SELECT 
  inv.SalesInvoiceID_PK,
  inv.SalesInvoiceDate,
  inv.InvoiceNumber,
  inv.InvoiceSubTotal,
  inv.InvoiceDiscountTotal,
  inv.InvoiceNetTotal,
  inv.CustomerID_FK,
  inv.CashCustomerName,
  inv.SalePersonID_FK,
  inv.LocationID_FK,
  inv.CreatedByUserName,
  inv.Createddate,
  inv.PaymentCaption,
  inv.PaymentCount,
  inv.Cash,
  inv.[Change] as ChangeAmount,
  inv.TransactionBarcode,
  inv.Notes,
  inv.SalesInvoiceStateID_FK,
  inv.DocumentTypeID_FK
FROM BRD.Data_SalesInvoices inv
WHERE 1=1 
  AND (inv.InvoiceNumber LIKE N'%بحث%' OR inv.CashCustomerName LIKE N'%بحث%' OR inv.TransactionBarcode LIKE N'%بحث%')
  AND inv.SalesInvoiceDate >= '2024-01-01 00:00:00'
  AND inv.SalesInvoiceDate <= '2024-12-31 23:59:59'
ORDER BY inv.SalesInvoiceDate DESC
OFFSET 0 ROWS FETCH NEXT 100 ROWS ONLY
```

**التحسينات**:
- مقارنة التاريخ مباشرة بدون `CAST` لتحسين الأداء واستخدام الفهارس
- استخدام التوقيت (00:00:00 و 23:59:59) لضمان شمول جميع الفواتير في اليوم المحدد

---

## 4. واجهة المستخدم

### 4.1. حقل البحث

```dart
TextField(
  controller: _searchController,
  decoration: InputDecoration(
    hintText: 'ابحث برقم الفاتورة أو اسم العميل',
    prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
  ),
  onChanged: (value) {
    setState(() {
      _searchQuery = value;
    });
  },
  onSubmitted: (_) {
    if (_searchQuery.isNotEmpty || _fromDate != null || _toDate != null) {
      _loadInvoices();
    }
  },
)
```

### 4.2. زر تاريخ البداية

```dart
ElevatedButton.icon(
  onPressed: () async {
    final date = await showDatePicker(
      context: context,
      initialDate: _fromDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: _toDate ?? DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _fromDate = date;
      });
      _loadInvoices(); // تحميل الفواتير تلقائياً بعد اختيار التاريخ
    }
  },
  icon: const Icon(FontAwesomeIcons.calendar),
  label: Text(_fromDate == null 
      ? 'من تاريخ' 
      : '${_fromDate!.day}/${_fromDate!.month}/${_fromDate!.year}'),
)
```

### 4.3. زر تاريخ النهاية

```dart
ElevatedButton.icon(
  onPressed: () async {
    final date = await showDatePicker(
      context: context,
      initialDate: _toDate ?? (_fromDate ?? DateTime.now()),
      firstDate: _fromDate ?? DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      setState(() {
        _toDate = date;
      });
      _loadInvoices(); // تحميل الفواتير تلقائياً بعد اختيار التاريخ
    }
  },
  icon: const Icon(FontAwesomeIcons.calendar),
  label: Text(_toDate == null 
      ? 'إلى تاريخ' 
      : '${_toDate!.day}/${_toDate!.month}/${_toDate!.year}'),
)
```

### 4.4. زر إعادة التعيين

```dart
ElevatedButton.icon(
  onPressed: () {
    setState(() {
      _fromDate = null;
      _toDate = null;
      _searchQuery = '';
      _searchController.clear();
    });
    _loadInvoices();
  },
  icon: const Icon(FontAwesomeIcons.xmark),
  label: const Text('إعادة تعيين'),
)
```

---

## 5. معالجة الأخطاء

### 5.1. في دالة `_loadInvoices`

```dart
catch (e, stackTrace) {
  print('خطأ في تحميل الفواتير: $e');
  print('Stack trace: $stackTrace');
  if (mounted) {
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('خطأ في تحميل الفواتير: $e'),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 5),
        action: SnackBarAction(
          label: 'إعادة المحاولة',
          textColor: Colors.white,
          onPressed: () => _loadInvoices(),
        ),
      ),
    );
  }
}
```

### 5.2. في دالة `getSales`

```dart
catch (e, stackTrace) {
  print('خطأ في getSales: $e');
  print('Stack trace: $stackTrace');
  await service.close();
  rethrow;
}
```

---

## 6. رسائل التنبيه

### 6.1. رسالة النجاح

```dart
if (count > 0) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('تم تحميل $count من $totalCount فاتورة'),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ),
  );
}
```

### 6.2. رسالة عدم وجود نتائج

```dart
else {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('لا توجد فواتير تطابق معايير البحث'),
      backgroundColor: Colors.orange,
      duration: Duration(seconds: 2),
    ),
  );
}
```

---

## 7. ميزات الأمان

### 7.1. منع SQL Injection

```dart
// استبدال علامات الاقتباس في نص البحث
final escapedSearch = search.replaceAll("'", "''");
```

### 7.2. مقارنة التاريخ مباشرة (بدون CAST)

```dart
// مقارنة التاريخ مباشرة مع التوقيت لتحسين الأداء واستخدام الفهارس
inv.SalesInvoiceDate >= '2024-01-01 00:00:00'
inv.SalesInvoiceDate <= '2024-12-31 23:59:59'
```

**لماذا بدون CAST؟**
- `CAST` يمنع قاعدة البيانات من استخدام الفهارس (Indexes) مما يبطئ الاستعلام
- المقارنة المباشرة أسرع وأكثر كفاءة
- إضافة التوقيت (00:00:00 و 23:59:59) يضمن الدقة الكاملة

---

## 8. التصحيح (Debugging)

### 8.1. طباعة المعلومات

```dart
print('من تاريخ: $fromDateStr');
print('إلى تاريخ: $toDateStr');
print('بحث: $escapedSearch');
print('استعلام العد: $countQuery');
print('استعلام البيانات: $dataQuery');
print('عدد النتائج: $totalCount');
print('عدد الفواتير المسترجعة: ${data.length}');
```

---

## 9. الميزات الرئيسية

1. **البحث**: البحث في رقم الفاتورة، اسم العميل، أو باركود المعاملة
2. **الفلترة بالتاريخ**: فلترة الفواتير حسب تاريخ البداية والنهاية
3. **Pagination**: دعم التصفح عبر الصفحات (حالياً: 100 عنصر لكل صفحة)
4. **معالجة الأخطاء**: رسائل خطأ واضحة مع إمكانية إعادة المحاولة
5. **رسائل التنبيه**: إشعارات للمستخدم عند النجاح أو الفشل
6. **الأمان**: منع SQL Injection من خلال escape النصوص

---

## 10. مثال على الاستخدام

### 10.1. البحث بدون فلترة

```dart
await DatabaseService.getSales(
  page: 1,
  pageSize: 100,
  search: 'فاتورة 123',
  fromDate: null,
  toDate: null,
);
```

### 10.2. الفلترة بالتاريخ فقط

```dart
await DatabaseService.getSales(
  page: 1,
  pageSize: 100,
  search: null,
  fromDate: DateTime(2024, 1, 1),
  toDate: DateTime(2024, 12, 31),
);
```

### 10.3. البحث مع الفلترة بالتاريخ

```dart
await DatabaseService.getSales(
  page: 1,
  pageSize: 100,
  search: 'عميل',
  fromDate: DateTime(2024, 1, 1),
  toDate: DateTime(2024, 12, 31),
);
```

---

## 11. الجداول المستخدمة

- **BRD.Data_SalesInvoices**: الجدول الرئيسي للفواتير
- **الحقول المستخدمة في البحث**:
  - `InvoiceNumber`: رقم الفاتورة
  - `CashCustomerName`: اسم العميل النقدي
  - `TransactionBarcode`: باركود المعاملة
- **الحقل المستخدم في الفلترة**:
  - `SalesInvoiceDate`: تاريخ الفاتورة

---

## 12. ملاحظات مهمة

1. **استخدام Alias موحد**: يتم استخدام alias `inv` في كلا الاستعلامين (COUNT و DATA) لضمان التناسق
2. **تنسيق التاريخ مع التوقيت**: يجب أن يكون التاريخ بتنسيق `YYYY-MM-DD HH:mm:ss` مع إضافة:
   - `00:00:00` لبداية اليوم (fromDate)
   - `23:59:59` لنهاية اليوم (toDate)
3. **مقارنة التاريخ بدون CAST**: استخدام المقارنة المباشرة بدلاً من `CAST` يحسن الأداء ويسمح باستخدام الفهارس
4. **Escape النصوص**: يجب escape علامات الاقتباس في نص البحث لمنع SQL Injection
5. **التحقق من mounted**: يجب التحقق من `mounted` قبل استخدام `setState` لتجنب الأخطاء
6. **إغلاق الاتصال**: يجب إغلاق اتصال قاعدة البيانات في `finally` لضمان إغلاقه دائماً
7. **توحيد WHERE clause**: استخدام نفس `whereClause` في كلا الاستعلامين يقلل من احتمالية الأخطاء

---

## 13. التحسينات المنفذة

✅ **تم تنفيذها**:
1. ✅ استخدام Alias موحد في كلا الاستعلامين
2. ✅ إزالة CAST واستخدام مقارنة مباشرة للتاريخ
3. ✅ إضافة التوقيت (00:00:00 و 23:59:59) لضمان الدقة
4. ✅ توحيد WHERE clause لتقليل الأخطاء
5. ✅ تحسين الأداء من خلال استخدام الفهارس

## 14. التحسينات المستقبلية

1. إضافة فلترة حسب حالة الفاتورة
2. إضافة فلترة حسب نوع المستند
3. إضافة فلترة حسب الموقع
4. إضافة فلترة حسب البائع
5. إضافة تصدير النتائج إلى Excel أو PDF
6. إضافة حفظ معايير البحث المفضلة
7. إضافة فهارس إضافية على الحقول المستخدمة في البحث

---

**تاريخ الإنشاء**: 2024  
**آخر تحديث**: 2024

