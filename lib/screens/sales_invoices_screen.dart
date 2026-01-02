import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../database_service.dart';
import 'home_screen.dart';

class SalesInvoicesScreen extends StatefulWidget {
  final Map<String, dynamic>? currentUser;
  
  const SalesInvoicesScreen({super.key, this.currentUser});

  @override
  State<SalesInvoicesScreen> createState() => _SalesInvoicesScreenState();
}

class _SalesInvoicesScreenState extends State<SalesInvoicesScreen> {
  List<Map<String, dynamic>> _invoices = [];
  bool _isLoading = false;
  String _searchQuery = '';
  DateTime? _fromDate;
  DateTime? _toDate;
  final TextEditingController _searchController = TextEditingController();
  
  // Statistics
  Map<String, dynamic>? _statistics;
  bool _isLoadingStats = false;
  
  // Dropdown values for date selection
  int? _fromDay;
  int? _fromMonth;
  int? _fromYear;
  int? _toDay;
  int? _toMonth;
  int? _toYear;
  
  // Generate lists for dropdowns
  List<int> get _days => List.generate(31, (i) => i + 1);
  List<int> get _months => List.generate(12, (i) => i + 1);
  List<int> get _years => List.generate(101, (i) => 2000 + i); // 2000 to 2100

  @override
  void initState() {
    super.initState();
    _loadInvoices();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  
  // Update date from dropdowns
  void _updateFromDate() {
    if (_fromDay != null && _fromMonth != null && _fromYear != null) {
      try {
        final date = DateTime(_fromYear!, _fromMonth!, _fromDay!);
        setState(() {
          _fromDate = date;
        });
        print('تم تحديث _fromDate إلى: $_fromDate');
      } catch (e) {
        print('خطأ في تحليل التاريخ من: $e');
        setState(() {
          _fromDate = null;
        });
      }
    } else {
      setState(() {
        _fromDate = null;
      });
    }
  }
  
  void _updateToDate() {
    if (_toDay != null && _toMonth != null && _toYear != null) {
      try {
        final date = DateTime(_toYear!, _toMonth!, _toDay!);
        setState(() {
          _toDate = date;
        });
        print('تم تحديث _toDate إلى: $_toDate');
      } catch (e) {
        print('خطأ في تحليل التاريخ إلى: $e');
        setState(() {
          _toDate = null;
        });
      }
    } else {
      setState(() {
        _toDate = null;
      });
    }
  }

  Future<void> _loadStatistics() async {
    if (!mounted) return;
    
    setState(() {
      _isLoadingStats = true;
    });
    
    try {
      final stats = await DatabaseService.getSalesStatistics(
        fromDate: _fromDate,
        toDate: _toDate,
      );
      
      if (mounted) {
        setState(() {
          _statistics = stats;
          _isLoadingStats = false;
        });
      }
    } catch (e) {
      print('خطأ في تحميل الإحصائيات: $e');
      if (mounted) {
        setState(() {
          _isLoadingStats = false;
        });
      }
    }
  }

  Future<void> _loadInvoices() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    
    try {
      print('=== بدء تحميل الفواتير ===');
      print('من تاريخ: $_fromDate');
      print('إلى تاريخ: $_toDate');
      print('بحث: $_searchQuery');
      print('من يوم: $_fromDay, شهر: $_fromMonth, سنة: $_fromYear');
      print('إلى يوم: $_toDay, شهر: $_toMonth, سنة: $_toYear');
      
      // التأكد من تحديث التواريخ من Dropdowns قبل الاستعلام
      if (_fromDay != null && _fromMonth != null && _fromYear != null) {
        _updateFromDate();
        print('تم تحديث _fromDate إلى: $_fromDate');
      }
      if (_toDay != null && _toMonth != null && _toYear != null) {
        _updateToDate();
        print('تم تحديث _toDate إلى: $_toDate');
      }
      
      // التحقق من صحة التواريخ
      if (_fromDate != null && _toDate != null) {
        if (_fromDate!.isAfter(_toDate!)) {
          print('تحذير: تاريخ البداية بعد تاريخ النهاية!');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('خطأ: تاريخ البداية يجب أن يكون قبل تاريخ النهاية'),
                backgroundColor: Colors.red,
                duration: Duration(seconds: 3),
              ),
            );
            setState(() => _isLoading = false);
            return;
          }
        }
      }
      
      print('قبل استدعاء getSales:');
      print('  fromDate: $_fromDate');
      print('  toDate: $_toDate');
      
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
        
        // تحميل الإحصائيات بعد تحميل الفواتير
        _loadStatistics();
        
        // Show success message with count
        final count = _invoices.length;
        final totalCount = result['totalCount'] ?? 0;
        if (count > 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('تم تحميل $count من $totalCount فاتورة'),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لا توجد فواتير تطابق معايير البحث'),
              backgroundColor: Colors.orange,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e, stackTrace) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Header with refresh button
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                const Text(
                  'الفواتير',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.arrowRotateRight, color: Colors.white),
                  tooltip: 'تحديث',
                  onPressed: () => _loadInvoices(),
                ),
              ],
            ),
          ),
          // Statistics Cards
          if (_statistics != null && !_isLoadingStats)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الإحصائيات',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'إجمالي المبيعات',
                          '${(_statistics!['totalSales'] ?? 0.0).toStringAsFixed(2)}',
                          FontAwesomeIcons.moneyBillWave,
                          Colors.green,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'عدد الفواتير',
                          '${_statistics!['totalInvoices'] ?? 0}',
                          FontAwesomeIcons.receipt,
                          Colors.blue,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'متوسط الفاتورة',
                          '${(_statistics!['averageInvoice'] ?? 0.0).toStringAsFixed(2)}',
                          FontAwesomeIcons.chartLine,
                          Colors.orange,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildStatCard(
                          context,
                          'إجمالي الخصومات',
                          '${(_statistics!['totalDiscounts'] ?? 0.0).toStringAsFixed(2)}',
                          FontAwesomeIcons.tag,
                          Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          // Search and filters
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).colorScheme.outline,
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'ابحث برقم الفاتورة أو اسم العميل',
                    prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(FontAwesomeIcons.xmark),
                            onPressed: () {
                              _searchController.clear();
                              _searchQuery = '';
                              _loadInvoices();
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  onSubmitted: (_) {
                    // عند الضغط على Enter، تطبق الفلترة
                    if (_searchQuery.isNotEmpty || _fromDate != null || _toDate != null) {
                      _loadInvoices();
                    }
                  },
                ),
                const SizedBox(height: 12),
                // Date dropdowns - From Date
                Row(
                  children: [
                    const Text('من تاريخ:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _fromDay,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'يوم',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        items: _days.map((day) => DropdownMenuItem(
                          value: day,
                          child: Text('$day'),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _fromDay = value;
                          });
                          _updateFromDate();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _fromMonth,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'شهر',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        items: _months.map((month) => DropdownMenuItem(
                          value: month,
                          child: Text('$month'),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _fromMonth = value;
                          });
                          _updateFromDate();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _fromYear,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'سنة',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        items: _years.map((year) => DropdownMenuItem(
                          value: year,
                          child: Text('$year'),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _fromYear = value;
                          });
                          _updateFromDate();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Date dropdowns - To Date
                Row(
                  children: [
                    const Text('إلى تاريخ:', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _toDay,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'يوم',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        items: _days.map((day) => DropdownMenuItem(
                          value: day,
                          child: Text('$day'),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _toDay = value;
                          });
                          _updateToDate();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _toMonth,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'شهر',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        items: _months.map((month) => DropdownMenuItem(
                          value: month,
                          child: Text('$month'),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _toMonth = value;
                          });
                          _updateToDate();
                        },
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        value: _toYear,
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'سنة',
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        items: _years.map((year) => DropdownMenuItem(
                          value: year,
                          child: Text('$year'),
                        )).toList(),
                        onChanged: (value) {
                          setState(() {
                            _toYear = value;
                          });
                          _updateToDate();
                        },
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton.icon(
                      onPressed: () {
                        setState(() {
                          _fromDate = null;
                          _toDate = null;
                          _searchQuery = '';
                          _searchController.clear();
                          _fromDay = null;
                          _fromMonth = null;
                          _fromYear = null;
                          _toDay = null;
                          _toMonth = null;
                          _toYear = null;
                        });
                        _loadInvoices();
                      },
                      icon: const Icon(FontAwesomeIcons.xmark),
                      label: const Text('إعادة تعيين'),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // أزرار الفلترة
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: _isLoading ? null : () {
                          print('=== زر تطبيق الفلترة تم الضغط عليه ===');
                          print('قبل التحديث:');
                          print('  _fromDate: $_fromDate');
                          print('  _toDate: $_toDate');
                          print('  من يوم: $_fromDay, شهر: $_fromMonth, سنة: $_fromYear');
                          print('  إلى يوم: $_toDay, شهر: $_toMonth, سنة: $_toYear');
                          
                          // تحديث التواريخ من Dropdowns قبل التحميل
                          _updateFromDate();
                          _updateToDate();
                          
                          print('بعد التحديث:');
                          print('  _fromDate: $_fromDate');
                          print('  _toDate: $_toDate');
                          
                          _loadInvoices();
                        },
                        icon: _isLoading 
                            ? const SizedBox(
                                width: 16,
                                height: 16,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Icon(FontAwesomeIcons.filter),
                        label: Text(_isLoading ? 'جاري البحث...' : 'تطبيق الفلترة'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _isLoading ? null : () {
                          setState(() {
                            _fromDate = null;
                            _toDate = null;
                            _searchQuery = '';
                            _searchController.clear();
                            _fromDay = null;
                            _fromMonth = null;
                            _fromYear = null;
                            _toDay = null;
                            _toMonth = null;
                            _toYear = null;
                          });
                          _loadInvoices();
                        },
                        icon: const Icon(FontAwesomeIcons.list),
                        label: const Text('عرض الكل'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Invoices List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _invoices.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.receipt,
                              size: 64,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'لا توجد فواتير في النطاق المحدد',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'جميع الفواتير الموجودة بتاريخ: 2026-01-01',
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 16),
                            OutlinedButton.icon(
                              onPressed: () {
                                setState(() {
                                  _fromDate = null;
                                  _toDate = null;
                                  _searchQuery = '';
                                  _searchController.clear();
                                  _fromDay = null;
                                  _fromMonth = null;
                                  _fromYear = null;
                                  _toDay = null;
                                  _toMonth = null;
                                  _toYear = null;
                                });
                                _loadInvoices();
                              },
                              icon: const Icon(FontAwesomeIcons.list),
                              label: const Text('عرض جميع الفواتير'),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _invoices.length,
                        itemBuilder: (context, index) {
                          final invoice = _invoices[index];
                          final invoiceIdValue = invoice['SalesInvoiceID_PK'];
                          final invoiceId = invoiceIdValue is int 
                              ? invoiceIdValue 
                              : int.tryParse(invoiceIdValue?.toString() ?? '0') ?? 0;
                          final invoiceDate = invoice['SalesInvoiceDate'];
                          final invoiceNumber = invoice['InvoiceNumber']?.toString() ?? '';
                          final customerName = invoice['CashCustomerName']?.toString() ?? 'عميل نقدي';
                          final createdBy = invoice['CreatedByUserName']?.toString() ?? '';
                          final paymentCaption = invoice['PaymentCaption']?.toString() ?? '';
                          final itemsCount = invoice['ItemsCount'] ?? 0;
                          final netTotal = (invoice['InvoiceNetTotal'] ?? 0.0) is double
                              ? invoice['InvoiceNetTotal']
                              : double.tryParse(invoice['InvoiceNetTotal']?.toString() ?? '0') ?? 0.0;
                          final discountTotal = (invoice['InvoiceDiscountTotal'] ?? 0.0) is double
                              ? invoice['InvoiceDiscountTotal']
                              : double.tryParse(invoice['InvoiceDiscountTotal']?.toString() ?? '0') ?? 0.0;
                          
                          // تحديد لون الحالة
                          final stateId = invoice['SalesInvoiceStateID_FK'] ?? 1;
                          Color stateColor = Colors.blue;
                          IconData stateIcon = FontAwesomeIcons.receipt;
                          
                          if (stateId == 1) {
                            stateColor = Colors.green; // مكتملة
                            stateIcon = FontAwesomeIcons.checkCircle;
                          } else if (stateId == 2) {
                            stateColor = Colors.orange; // معلقة
                            stateIcon = FontAwesomeIcons.pauseCircle;
                          } else if (stateId == 3) {
                            stateColor = Colors.red; // ملغاة
                            stateIcon = FontAwesomeIcons.timesCircle;
                          }
                          
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(
                                color: stateColor.withOpacity(0.3),
                                width: 1,
                              ),
                            ),
                            child: InkWell(
                              onTap: () => _showInvoiceDetails(invoiceId),
                              borderRadius: BorderRadius.circular(12),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: stateColor.withOpacity(0.1),
                                  child: Icon(
                                    stateIcon,
                                    color: stateColor,
                                  ),
                                ),
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  'فاتورة #$invoiceNumber',
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: stateColor.withOpacity(0.1),
                                                  borderRadius: BorderRadius.circular(12),
                                                ),
                                                child: Text(
                                                  paymentCaption.isEmpty ? 'نقد' : paymentCaption,
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: stateColor,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            customerName,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.grey.shade700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(FontAwesomeIcons.copy, size: 16),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        Clipboard.setData(ClipboardData(text: invoiceNumber));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('تم نسخ رقم الفاتورة: $invoiceNumber'),
                                            duration: const Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                      tooltip: 'نسخ رقم الفاتورة',
                                    ),
                                  ],
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text('العميل: $customerName'),
                                    Text('التاريخ: ${_formatDate(invoiceDate)}'),
                                    Text('المبلغ: ${netTotal.toStringAsFixed(2)}'),
                                    if (discountTotal > 0)
                                      Text('الخصم: ${discountTotal.toStringAsFixed(2)}', 
                                        style: TextStyle(color: Colors.green.shade700)),
                                    if (createdBy.isNotEmpty)
                                      Text('أنشأها: $createdBy', 
                                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                    if (itemsCount > 0)
                                      Text('عدد الأصناف: $itemsCount', 
                                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                                  ],
                                ),
                                trailing: Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Colors.grey.shade400,
                                ),
                                isThreeLine: true,
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Future<void> _showInvoiceDetails(int invoiceId) async {
    try {
      final details = await DatabaseService.getInvoiceDetails(invoiceId);
      final invoice = details['invoice'];
      final items = details['items'] as List<Map<String, dynamic>>;
      final payments = details['payments'] as List<Map<String, dynamic>>;
      
      if (!mounted) return;
      
      showDialog(
        context: context,
        builder: (context) => Dialog(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'تفاصيل الفاتورة #${invoice['InvoiceNumber']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(FontAwesomeIcons.copy, size: 18),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            onPressed: () {
                              final invoiceNum = invoice['InvoiceNumber']?.toString() ?? '';
                              Clipboard.setData(ClipboardData(text: invoiceNum));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('تم نسخ رقم الفاتورة: $invoiceNum'),
                                  duration: const Duration(seconds: 2),
                                ),
                              );
                            },
                            tooltip: 'نسخ رقم الفاتورة',
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.xmark),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailRow('رقم الفاتورة', invoice['InvoiceNumber']?.toString() ?? ''),
                        _buildDetailRow('معرف الفاتورة', invoice['SalesInvoiceID_PK']?.toString() ?? ''),
                        _buildDetailRow('العميل', invoice['CashCustomerName']?.toString() ?? 'عميل نقدي'),
                        _buildDetailRow('التاريخ', _formatDate(invoice['SalesInvoiceDate'])),
                        _buildDetailRow('تاريخ الإنشاء', _formatDate(invoice['Createddate'])),
                        _buildDetailRow('أنشأها', invoice['CreatedByUserName']?.toString() ?? ''),
                        _buildDetailRow('المبلغ الإجمالي', '${_toDouble(invoice['InvoiceSubTotal']).toStringAsFixed(2)}'),
                        _buildDetailRow('الخصم', '${_toDouble(invoice['InvoiceDiscountTotal']).toStringAsFixed(2)}'),
                        _buildDetailRow('المبلغ الصافي', '${_toDouble(invoice['InvoiceNetTotal']).toStringAsFixed(2)}'),
                        _buildDetailRow('طريقة الدفع', invoice['PaymentCaption']?.toString() ?? ''),
                        _buildDetailRow('عدد طرق الدفع', invoice['PaymentCount']?.toString() ?? '0'),
                        if (_toDouble(invoice['Cash']) > 0)
                          _buildDetailRow('النقد', '${_toDouble(invoice['Cash']).toStringAsFixed(2)}'),
                        if (_toDouble(invoice['ChangeAmount']) > 0)
                          _buildDetailRow('الباقي', '${_toDouble(invoice['ChangeAmount']).toStringAsFixed(2)}'),
                        if (invoice['TransactionBarcode']?.toString().isNotEmpty ?? false)
                          _buildDetailRow('باركود المعاملة', invoice['TransactionBarcode']?.toString() ?? ''),
                        if (invoice['Notes']?.toString().isNotEmpty ?? false)
                          _buildDetailRow('ملاحظات', invoice['Notes']?.toString() ?? ''),
                        const SizedBox(height: 16),
                        const Text(
                          'الأصناف',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        ...items.map((item) {
                          final productCode = item['ProductCode']?.toString() ?? '';
                          return Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(item['ProductName']?.toString() ?? ''),
                              subtitle: Row(
                                children: [
                                  Text('الكود: $productCode'),
                                  const SizedBox(width: 8),
                                  IconButton(
                                    icon: const Icon(FontAwesomeIcons.copy, size: 14),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () {
                                      Clipboard.setData(ClipboardData(text: productCode));
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text('تم نسخ كود المنتج: $productCode'),
                                          duration: const Duration(seconds: 2),
                                        ),
                                      );
                                    },
                                    tooltip: 'نسخ كود المنتج',
                                  ),
                                ],
                              ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text('الكمية: ${_toDouble(item['QYT']).toStringAsFixed(2)} ${item['UOMName']?.toString() ?? ''}'),
                                Text('السعر: ${_toDouble(item['UnitPrice']).toStringAsFixed(2)}'),
                                Text('الإجمالي: ${_toDouble(item['SubTotal']).toStringAsFixed(2)}'),
                              ],
                            ),
                              isThreeLine: true,
                            ),
                          );
                        }),
                        if (payments.isNotEmpty) ...[
                          const SizedBox(height: 16),
                          const Text(
                            'المدفوعات',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          ...payments.map((payment) => Card(
                            margin: const EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              title: Text(payment['PaymentMethodCaption']?.toString() ?? 'طريقة الدفع'),
                              trailing: Text('${_toDouble(payment['LocCurrencyPaymentAmount']).toStringAsFixed(2)}'),
                            ),
                          )),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل التفاصيل: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper function to safely convert dynamic to double
  double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) {
      return double.tryParse(value.replaceAll(',', '')) ?? 0.0;
    }
    return 0.0;
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'غير محدد';
    try {
      if (date is DateTime) {
        return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
      }
      final dateStr = date.toString();
      if (dateStr.contains('T')) {
        final dt = DateTime.parse(dateStr);
        return '${dt.day}/${dt.month}/${dt.year} ${dt.hour}:${dt.minute}';
      }
      return dateStr;
    } catch (e) {
      return date.toString();
    }
  }
}


