import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../database_service.dart';
import 'home_screen.dart';

class StockManagementScreen extends StatefulWidget {
  final Map<String, dynamic>? currentUser;
  
  const StockManagementScreen({super.key, this.currentUser});

  @override
  State<StockManagementScreen> createState() => _StockManagementScreenState();
}

class _StockManagementScreenState extends State<StockManagementScreen> {
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _productGroups = [];
  bool _isLoading = false;
  String _searchQuery = '';
  int? _selectedGroupId;
  bool _showLowStockOnly = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProductGroups();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadProductGroups() async {
    try {
      final groups = await DatabaseService.getProductGroups();
      if (mounted) {
        setState(() {
          _productGroups = groups;
          if (_productGroups.isNotEmpty && _selectedGroupId == null) {
            final groupIdValue = _productGroups.first['ProductGroupID_PK'];
            _selectedGroupId = groupIdValue is int 
                ? groupIdValue 
                : int.tryParse(groupIdValue?.toString() ?? '');
          }
          _loadProducts();
        });
      }
    } catch (e) {
      print('خطأ في تحميل الفئات: $e');
    }
  }

  Future<void> _loadProducts() async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    
    try {
      final result = await DatabaseService.getProducts(
        page: 1,
        pageSize: 200,
        search: _searchQuery.isEmpty ? null : _searchQuery,
        productGroupId: _selectedGroupId,
      );
      
      if (mounted) {
        List<Map<String, dynamic>> products = List<Map<String, dynamic>>.from(result['data'] ?? []);
        
        // Filter low stock if needed
        if (_showLowStockOnly) {
          products = products.where((product) {
            final stockOnHand = (product['StockOnHand'] ?? 0.0) is double
                ? product['StockOnHand']
                : double.tryParse(product['StockOnHand']?.toString() ?? '0') ?? 0.0;
            final minStockLevel = (product['MinStockLevel'] ?? 0.0) is double
                ? product['MinStockLevel']
                : double.tryParse(product['MinStockLevel']?.toString() ?? '0') ?? 0.0;
            return stockOnHand <= minStockLevel;
          }).toList();
        }
        
        setState(() {
          _products = products;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل المنتجات: $e'),
            backgroundColor: Colors.red,
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
                  'إدارة المخزون',
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
                  onPressed: () => _loadProducts(),
                ),
              ],
            ),
          ),
          // Filters
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
                    hintText: 'ابحث عن منتج',
                    prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(FontAwesomeIcons.xmark),
                            onPressed: () {
                              _searchController.clear();
                              _searchQuery = '';
                              _loadProducts();
                            },
                          )
                        : null,
                  ),
                  onChanged: (value) {
                    setState(() => _searchQuery = value);
                  },
                  onSubmitted: (_) => _loadProducts(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int?>(
                        value: _selectedGroupId,
                        decoration: const InputDecoration(
                          labelText: 'الفئة',
                          border: OutlineInputBorder(),
                        ),
                        items: [
                          const DropdownMenuItem<int?>(
                            value: null,
                            child: Text('جميع الفئات'),
                          ),
                          ..._productGroups.map((group) {
                            final groupIdValue = group['ProductGroupID_PK'];
                            final groupId = groupIdValue is int 
                                ? groupIdValue 
                                : int.tryParse(groupIdValue?.toString() ?? '');
                            return DropdownMenuItem<int?>(
                              value: groupId,
                              child: Text(group['ProductGroupDescription']?.toString() ?? ''),
                            );
                          }),
                        ],
                        onChanged: (value) {
                          setState(() => _selectedGroupId = value);
                          _loadProducts();
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilterChip(
                      label: const Text('منخفض المخزون فقط'),
                      selected: _showLowStockOnly,
                      onSelected: (selected) {
                        setState(() => _showLowStockOnly = selected);
                        _loadProducts();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Products List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _products.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.boxesStacked,
                              size: 64,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'لا توجد منتجات',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _products.length,
                        itemBuilder: (context, index) {
                          final product = _products[index];
                          final productName = product['ProductName']?.toString() ?? 'منتج';
                          final productCode = product['ProductCode']?.toString() ?? '';
                          final stockOnHand = (product['StockOnHand'] ?? 0.0) is double
                              ? product['StockOnHand']
                              : double.tryParse(product['StockOnHand']?.toString() ?? '0') ?? 0.0;
                          final minStockLevel = (product['MinStockLevel'] ?? 0.0) is double
                              ? product['MinStockLevel']
                              : double.tryParse(product['MinStockLevel']?.toString() ?? '0') ?? 0.0;
                          final isLowStock = stockOnHand <= minStockLevel;
                          
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: InkWell(
                              onTap: () => _showProductDetails(product),
                              borderRadius: BorderRadius.circular(12),
                              child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: isLowStock
                                    ? Colors.red.withOpacity(0.1)
                                    : Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                child: Icon(
                                  FontAwesomeIcons.box,
                                  color: isLowStock
                                      ? Colors.red
                                      : Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              title: Text(
                                productName,
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 4),
                                  Text('الكود: $productCode'),
                                  Text(
                                    'المخزون: ${stockOnHand.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: isLowStock ? Colors.red : null,
                                      fontWeight: isLowStock ? FontWeight.bold : null,
                                    ),
                                  ),
                                  if (isLowStock)
                                    Text(
                                      'الحد الأدنى: ${minStockLevel.toStringAsFixed(2)}',
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                ],
                              ),
                              trailing: isLowStock
                                  ? const Icon(
                                      FontAwesomeIcons.triangleExclamation,
                                      color: Colors.red,
                                    )
                                  : Icon(
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

  Future<void> _showProductDetails(Map<String, dynamic> product) async {
    final productIdValue = product['ProductID_PK'];
    final productId = productIdValue is int 
        ? productIdValue 
        : int.tryParse(productIdValue?.toString() ?? '0') ?? 0;
    
    if (productId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('خطأ: معرف المنتج غير صحيح'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    
    try {
      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
      );
      
      final details = await DatabaseService.getProductDetails(productId);
      
      if (!mounted) return;
      
      // Close loading dialog
      Navigator.pop(context);
      
      if (details == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('لم يتم العثور على تفاصيل المنتج'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      
      if (!mounted) return;
      
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        FontAwesomeIcons.box,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          details['ProductName']?.toString() ?? 'تفاصيل المنتج',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.xmark, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildDetailSection(
                          'المعلومات الأساسية',
                          [
                            _buildDetailRow('معرف المنتج', details['ProductID_PK']?.toString() ?? ''),
                            _buildDetailRow('كود المنتج', details['ProductCode']?.toString() ?? ''),
                            _buildDetailRow('اسم المنتج', details['ProductName']?.toString() ?? ''),
                            _buildDetailRow('الاسم المختصر', details['ProductShortName']?.toString() ?? ''),
                            _buildDetailRow('كود التصنيع', details['manfuctureCode']?.toString() ?? 'غير محدد'),
                            _buildDetailRow('الوصف للبيع', details['SalesDecription']?.toString() ?? ''),
                            _buildDetailRow('الوصف للشراء', details['PurchaseDescription']?.toString() ?? ''),
                            _buildDetailRow('مواقع المنتج', details['ProductLocations']?.toString() ?? 'غير محدد'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDetailSection(
                          'المخزون',
                          [
                            _buildDetailRow('المخزون المتاح', '${_toDouble(details['StockOnHand']).toStringAsFixed(2)}'),
                            _buildDetailRow('المخزون المحجوز', '${_toDouble(details['StockOnHold']).toStringAsFixed(2)}'),
                            _buildDetailRow('الحد الأدنى', '${_toDouble(details['MinStockLevel']).toStringAsFixed(2)}'),
                            _buildDetailRow('الحد الأقصى', '${_toDouble(details['MaxStockLevel']).toStringAsFixed(2)}'),
                            _buildDetailRow('إجمالي المستلم', '${_toDouble(details['TotalReceivedQYT']).toStringAsFixed(2)}'),
                            _buildDetailRow('إجمالي المباع', '${_toDouble(details['TotalSoldQYT']).toStringAsFixed(2)}'),
                            if (details['TotalInventoryStock'] != null)
                              _buildDetailRow('إجمالي مخزون الفروع', '${_toDouble(details['TotalInventoryStock']).toStringAsFixed(2)}'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDetailSection(
                          'وحدات القياس',
                          [
                            _buildDetailRow('وحدة البيع الافتراضية', details['SellUOMName']?.toString() ?? 'غير محدد'),
                            _buildDetailRow('وحدة الطلب الافتراضية', details['OrderUOMName']?.toString() ?? 'غير محدد'),
                            _buildDetailRow('وحدة المخزون الافتراضية', details['InventoryUOMName']?.toString() ?? 'غير محدد'),
                            _buildDetailRow('عدد وحدات القياس', details['UOMCount']?.toString() ?? '0'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDetailSection(
                          'التصنيف',
                          [
                            _buildDetailRow('المجموعة', details['ProductGroupName']?.toString() ?? 'غير محدد'),
                            _buildDetailRow('النوع', details['ProductTypeName']?.toString() ?? 'غير محدد'),
                            _buildDetailRow('المورد الرئيسي', details['SupplierName']?.toString() ?? 'غير محدد'),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDetailSection(
                          'آخر المعاملات',
                          [
                            if (details['LastSalesTransactionDate'] != null)
                              _buildDetailRow('آخر عملية بيع', _formatDate(details['LastSalesTransactionDate'])),
                            if (details['LastReceiveTransactionDate'] != null)
                              _buildDetailRow('آخر عملية استلام', _formatDate(details['LastReceiveTransactionDate'])),
                            if (details['LastOrderTransactionDate'] != null)
                              _buildDetailRow('آخر عملية طلب', _formatDate(details['LastOrderTransactionDate'])),
                            if (details['LastStockAdjTransactionDate'] != null)
                              _buildDetailRow('آخر تعديل مخزون', _formatDate(details['LastStockAdjTransactionDate'])),
                            if (details['LastRefundTransactionDate'] != null)
                              _buildDetailRow('آخر عملية استرجاع', _formatDate(details['LastRefundTransactionDate'])),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildDetailSection(
                          'الإعدادات',
                          [
                            _buildDetailRow('الحالة', (details['IsInActive'] == true || details['IsInActive'] == 1) ? 'غير نشط' : 'نشط'),
                            _buildDetailRow('منتج متوقف', (details['IsDiscontinuousItem'] == true || details['IsDiscontinuousItem'] == 1) ? 'نعم' : 'لا'),
                            _buildDetailRow('غير قابل للخصم', (details['IsNonDiscountableItem'] == true || details['IsNonDiscountableItem'] == 1) ? 'نعم' : 'لا'),
                            _buildDetailRow('سعر مفتوح', (details['IsHasOpenPrice'] == true || details['IsHasOpenPrice'] == 1) ? 'نعم' : 'لا'),
                            _buildDetailRow('غير قابل للاسترجاع', (details['IsNonRefundableItem'] == true || details['IsNonRefundableItem'] == 1) ? 'نعم' : 'لا'),
                            _buildDetailRow('منتج إنتاج', (details['IsProductionProduct'] == true || details['IsProductionProduct'] == 1) ? 'نعم' : 'لا'),
                            _buildDetailRow('له رقم تسلسلي', (details['IsHasSerialNO'] == true || details['IsHasSerialNO'] == 1) ? 'نعم' : 'لا'),
                            _buildDetailRow('تكلفة مخفية', (details['ISCostHidden'] == true || details['ISCostHidden'] == 1) ? 'نعم' : 'لا'),
                            _buildDetailRow('نقاط المبيعات', details['SalesPoints']?.toString() ?? '0'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } catch (e, stackTrace) {
      print('خطأ في _showProductDetails: $e');
      print('Stack trace: $stackTrace');
      
      if (mounted) {
        // Close loading dialog if still open
        try {
          Navigator.pop(context);
        } catch (_) {}
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل التفاصيل: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
      }
    }
  }

  Widget _buildDetailSection(String title, List<Widget> children) {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 140,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value.isEmpty ? 'غير محدد' : value,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _toDouble(dynamic value) {
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'غير محدد';
    try {
      if (date is DateTime) {
        return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
      }
      if (date is String) {
        final dt = DateTime.tryParse(date);
        if (dt != null) {
          return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
        }
      }
      return date.toString();
    } catch (e) {
      return date.toString();
    }
  }
}

