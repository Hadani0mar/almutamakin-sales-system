import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../database_service.dart';
import 'login_screen.dart';
import 'users_screen.dart';

class POSScreen extends StatefulWidget {
  final Map<String, dynamic>? currentUser;
  
  const POSScreen({super.key, this.currentUser});

  @override
  State<POSScreen> createState() => _POSScreenState();
}

class _POSScreenState extends State<POSScreen> {
  // Cart items
  final List<Map<String, dynamic>> _cartItems = [];
  
  // Product search
  final TextEditingController _productSearchController = TextEditingController();
  List<Map<String, dynamic>> _products = [];
  List<Map<String, dynamic>> _productGroups = [];
  int? _selectedGroupId;
  bool _isLoadingProducts = false;
  bool _isLoadingGroups = false;
  
  // Customer info
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerSearchController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  Map<String, dynamic>? _selectedCustomer;
  List<Map<String, dynamic>> _customers = [];
  bool _isLoadingCustomers = false;
  bool _showCustomerSearch = false;
  
  // Payment methods
  List<Map<String, dynamic>> _paymentMethods = [];
  List<Map<String, dynamic>> _selectedPayments = []; // [{paymentMethodId, amount, currencyRate, locCurrencyAmount}]
  bool _isLoadingPaymentMethods = false;
  
  // Totals
  double _subTotal = 0.0;
  double _discount = 0.0;
  double _netTotal = 0.0;
  double _totalPaid = 0.0;
  double _change = 0.0;
  
  // Activity Log
  List<Map<String, dynamic>> _activityLogs = [];
  bool _showActivityLog = false;
  
  // Sidebar collapse
  bool _isSidebarCollapsed = false;
  
  // Invoice counter
  int _invoiceCounter = 1;

  // Check if current user is admin
  bool _isAdminUser() {
    final adminCode = widget.currentUser?['AdminPermissionCode']?.toString();
    final username = widget.currentUser?['username']?.toString() ?? '';
    // Check if user has admin permission code or is username '1' (system admin)
    return adminCode != null && adminCode.isNotEmpty && adminCode != '0' || username == '1';
  }

  // Helper function to convert dynamic to int
  int _convertToInt(dynamic value) {
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 1;
    return 1;
  }

  @override
  void initState() {
    super.initState();
    _loadProductGroups();
    _loadActivityLogs();
    _loadPaymentMethods();
  }

  @override
  void dispose() {
    _productSearchController.dispose();
    _customerNameController.dispose();
    _customerSearchController.dispose();
    _discountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  Future<void> _loadProductGroups() async {
    if (!mounted) return;
    setState(() => _isLoadingGroups = true);
    try {
      final groups = await DatabaseService.getProductGroups();
      if (mounted) {
        setState(() {
          _productGroups = groups;
          _isLoadingGroups = false;
          // Select first group by default
          if (_productGroups.isNotEmpty && _selectedGroupId == null) {
            final groupIdValue = _productGroups.first['ProductGroupID_PK'];
            _selectedGroupId = groupIdValue is int 
                ? groupIdValue 
                : int.tryParse(groupIdValue?.toString() ?? '');
            if (_selectedGroupId != null) {
              _loadProducts();
            }
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingGroups = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل الفئات: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _loadProducts({String? search}) async {
    if (!mounted) return;
    setState(() => _isLoadingProducts = true);
    try {
      final result = await DatabaseService.getProducts(
        page: 1,
        pageSize: 200,
        search: search,
        productGroupId: _selectedGroupId,
      );
      if (mounted) {
        setState(() {
          _products = List<Map<String, dynamic>>.from(result['data'] ?? []);
          _isLoadingProducts = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingProducts = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل المنتجات: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _loadPaymentMethods() async {
    if (!mounted) return;
    setState(() => _isLoadingPaymentMethods = true);
    try {
      print('بدء تحميل طرق الدفع...');
      final methods = await DatabaseService.getPaymentMethods(forSales: true);
      print('تم جلب ${methods.length} طريقة دفع');
      if (methods.isNotEmpty) {
        print('طرق الدفع المتاحة:');
        for (var method in methods) {
          print('  - ${method['PaymentMethodCaption']} (ID: ${method['PaymentMethodID_PK']})');
        }
      }
      if (mounted) {
        setState(() {
          _paymentMethods = methods;
          _isLoadingPaymentMethods = false;
        });
      }
    } catch (e) {
      print('خطأ في تحميل طرق الدفع: $e');
      if (mounted) {
        setState(() => _isLoadingPaymentMethods = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل طرق الدفع: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  Future<void> _loadCustomers({String? search}) async {
    if (!mounted) return;
    setState(() => _isLoadingCustomers = true);
    try {
      final customers = await DatabaseService.getCustomers(search: search, limit: 50);
      if (mounted) {
        setState(() {
          _customers = customers;
          _isLoadingCustomers = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingCustomers = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل العملاء: $e'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 3),
          ),
        );
      }
    }
  }

  void _selectCustomer(Map<String, dynamic> customer) {
    setState(() {
      _selectedCustomer = customer;
      _customerNameController.text = customer['CustomerName']?.toString() ?? '';
      _showCustomerSearch = false;
    });
  }

  void _clearCustomer() {
    setState(() {
      _selectedCustomer = null;
      _customerNameController.clear();
    });
  }

  void _addPaymentMethod(Map<String, dynamic> paymentMethod, double amount) {
    final currencyRate = (paymentMethod['CurrencyRate'] ?? 1.0) is double
        ? paymentMethod['CurrencyRate']
        : double.tryParse(paymentMethod['CurrencyRate']?.toString() ?? '1.0') ?? 1.0;
    final locCurrencyAmount = amount * currencyRate;
    
    setState(() {
      _selectedPayments.add({
        'paymentMethodId': paymentMethod['PaymentMethodID_PK'],
        'paymentMethodCaption': paymentMethod['PaymentMethodCaption'],
        'amount': amount,
        'currencyRate': currencyRate,
        'locCurrencyAmount': locCurrencyAmount,
      });
      _calculateTotals();
    });
  }

  void _removePayment(int index) {
    setState(() {
      _selectedPayments.removeAt(index);
      _calculateTotals();
    });
  }

  Future<void> _loadActivityLogs() async {
    try {
      final logs = await DatabaseService.getActivityLogs(limit: 50);
      if (mounted) {
        setState(() {
          _activityLogs = logs;
        });
      }
    } catch (e) {
      // Ignore log errors - table might not exist yet
      print('خطأ في تحميل سجل العمليات: $e');
      if (mounted) {
        setState(() {
          _activityLogs = [];
        });
      }
    }
  }

  void _addToCart(Map<String, dynamic> product) {
    // Get price - use UnitPrice from query or default to 0
    final unitPrice = (product['UnitPrice'] ?? 0.0) is double 
        ? product['UnitPrice'] 
        : double.tryParse(product['UnitPrice']?.toString() ?? '0') ?? 0.0;
    final unitCost = (product['UnitCost'] ?? 0.0) is double 
        ? product['UnitCost'] 
        : double.tryParse(product['UnitCost']?.toString() ?? '0') ?? 0.0;
    
    final existingIndex = _cartItems.indexWhere(
      (item) => item['ProductID_PK'] == product['ProductID_PK'],
    );

    if (existingIndex >= 0) {
      setState(() {
        _cartItems[existingIndex]['quantity'] = (_cartItems[existingIndex]['quantity'] ?? 1) + 1;
        _calculateTotals();
      });
    } else {
      setState(() {
        _cartItems.add({
          'ProductID_PK': product['ProductID_PK'],
          'ProductName': product['ProductName'],
          'ProductCode': product['ProductCode'],
          'quantity': 1,
          'unitPrice': unitPrice,
          'unitCost': unitCost,
        });
        _calculateTotals();
      });
    }
    
    // Log activity
    DatabaseService.logActivity(
      userId: widget.currentUser?['UserID_PK'] ?? 0,
      userName: widget.currentUser?['FullName']?.toString() ?? 'مستخدم',
      action: 'إضافة منتج',
      details: 'تم إضافة ${product['ProductName']} إلى السلة',
    );
  }

  void _removeFromCart(int index) {
    final item = _cartItems[index];
    setState(() {
      _cartItems.removeAt(index);
      _calculateTotals();
    });
    
    // Log activity (don't wait, fire and forget)
    DatabaseService.logActivity(
      userId: widget.currentUser?['UserID_PK'] ?? 0,
      userName: widget.currentUser?['FullName']?.toString() ?? 'مستخدم',
      action: 'حذف منتج',
      details: 'تم حذف ${item['ProductName']} من السلة',
    ).catchError((e) {
      // Ignore log errors
      print('خطأ في تسجيل النشاط: $e');
    });
  }

  void _updateQuantity(int index, int quantity) {
    if (quantity <= 0) {
      _removeFromCart(index);
      return;
    }
    setState(() {
      _cartItems[index]['quantity'] = quantity;
      _calculateTotals();
    });
  }

  void _calculateTotals() {
    _subTotal = _cartItems.fold(0.0, (sum, item) {
      final qty = (item['quantity'] ?? 1).toDouble();
      final price = (item['unitPrice'] ?? 0.0).toDouble();
      return sum + (qty * price);
    });
    
    _discount = double.tryParse(_discountController.text) ?? 0.0;
    _netTotal = _subTotal - _discount;
    
    // Calculate total paid from payment methods
    _totalPaid = _selectedPayments.fold(0.0, (sum, payment) {
      return sum + (payment['locCurrencyAmount'] ?? 0.0);
    });
    
    _change = _totalPaid - _netTotal;
    
    setState(() {});
  }


  void _updateDiscount(String value) {
    setState(() {
      _calculateTotals();
    });
  }

  Future<void> _processSale() async {
    if (_cartItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('السلة فارغة'), backgroundColor: Colors.orange),
      );
      return;
    }

    if (_selectedPayments.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار طريقة دفع'), backgroundColor: Colors.orange),
      );
      return;
    }

    if (_totalPaid < _netTotal) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('المبلغ المدفوع غير كافي'), backgroundColor: Colors.red),
      );
      return;
    }

    try {
      // Prepare invoice items
      final items = _cartItems.map((item) {
        final qty = (item['quantity'] ?? 1).toDouble();
        final price = (item['unitPrice'] ?? 0.0).toDouble();
        final subTotal = qty * price;
        
        return {
          'ProductID_PK': item['ProductID_PK'],
          'quantity': qty,
          'unitCost': item['unitCost'] ?? 0.0,
          'unitPrice': price,
          'subTotal': subTotal,
          'discountPercentage': 0.0,
          'discountAmount': 0.0,
        };
      }).toList();

      // Generate invoice number (max 20 chars)
      final invoiceNumber = 'INV-${DateTime.now().year}${DateTime.now().month.toString().padLeft(2, '0')}${_invoiceCounter.toString().padLeft(4, '0')}';
      // Transaction barcode max 15 chars
      final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final transactionBarcode = timestamp.length > 15 
          ? timestamp.substring(timestamp.length - 15) 
          : timestamp.padLeft(15, '0');

      // Prepare payment caption
      final paymentCaptions = _selectedPayments.map((p) => p['paymentMethodCaption']?.toString() ?? '').join(', ');
      final paymentCaption = paymentCaptions.length > 150 
          ? paymentCaptions.substring(0, 150) 
          : paymentCaptions;

      // Get customer ID
      final customerId = _selectedCustomer != null 
          ? (_selectedCustomer!['CustomerID_PK'] is int 
              ? _selectedCustomer!['CustomerID_PK'] 
              : int.tryParse(_selectedCustomer!['CustomerID_PK']?.toString() ?? '0') ?? 0)
          : 0;
      
      final customerPriceTypeId = _selectedCustomer != null
          ? (_selectedCustomer!['CustomerPriceTypeID_FK'] is int
              ? _selectedCustomer!['CustomerPriceTypeID_FK']
              : int.tryParse(_selectedCustomer!['CustomerPriceTypeID_FK']?.toString() ?? '1') ?? 1)
          : 1;

      // Create invoice
      final invoiceId = await DatabaseService.createSalesInvoice(
        branchId: 1,
        wsId: 1,
        customerId: customerId,
        cashCustomerName: _selectedCustomer == null 
            ? (_customerNameController.text.isEmpty ? 'عميل نقدي' : _customerNameController.text)
            : '',
        salePersonId: _convertToInt(widget.currentUser?['UserID_PK']),
        documentTypeId: 15, // Sales Invoice Document Type
        salesInvoiceStateId: 200, // Completed state
        invoiceNumber: invoiceNumber,
        invoiceSubTotal: _subTotal,
        invoiceDiscountTotal: _discount,
        invoiceNetTotal: _netTotal,
        notes: _notesController.text,
        paymentCount: _selectedPayments.length,
        paymentCaption: paymentCaption.isEmpty ? 'نقد' : paymentCaption,
        cash: _totalPaid,
        change: _change,
        transactionBarcode: transactionBarcode,
        createdByUserId: _convertToInt(widget.currentUser?['UserID_PK']),
        createdByUserName: widget.currentUser?['FullName']?.toString() ?? 'مستخدم',
        customerPriceTypeId: customerPriceTypeId,
        customerDiscountDefaultValue: _discount,
        customerDiscountUsedAsPercentage: false,
        locationId: 1,
        items: items,
      );

      // Add payments
      for (var payment in _selectedPayments) {
        // Convert paymentMethodId to int
        final paymentMethodId = payment['paymentMethodId'] is int
            ? payment['paymentMethodId']
            : int.tryParse(payment['paymentMethodId']?.toString() ?? '0') ?? 0;
        
        // Convert amounts to double
        final paymentAmount = payment['amount'] is double
            ? payment['amount']
            : double.tryParse(payment['amount']?.toString() ?? '0') ?? 0.0;
        final currencyRate = payment['currencyRate'] is double
            ? payment['currencyRate']
            : double.tryParse(payment['currencyRate']?.toString() ?? '1.0') ?? 1.0;
        final locCurrencyAmount = payment['locCurrencyAmount'] is double
            ? payment['locCurrencyAmount']
            : double.tryParse(payment['locCurrencyAmount']?.toString() ?? '0') ?? 0.0;
        
        await DatabaseService.addInvoicePayment(
          invoiceId: invoiceId,
          paymentMethodId: paymentMethodId,
          paymentAmount: paymentAmount,
          currencyRate: currencyRate,
          locCurrencyAmount: locCurrencyAmount,
          paymentNote: null,
          createdByUserId: _convertToInt(widget.currentUser?['UserID_PK']),
          createdByUserName: widget.currentUser?['FullName']?.toString() ?? 'مستخدم',
        );
      }

      // Log activity
      await DatabaseService.logActivity(
        userId: widget.currentUser?['UserID_PK'] ?? 0,
        userName: widget.currentUser?['FullName']?.toString() ?? 'مستخدم',
        action: 'إتمام بيع',
        details: 'تم إنشاء فاتورة رقم $invoiceNumber بمبلغ ${_netTotal.toStringAsFixed(2)}',
      );

      // Reload activity logs
      _loadActivityLogs();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('تمت العملية بنجاح! رقم الفاتورة: $invoiceNumber'),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 3),
          ),
        );
      }

      // Clear cart
      setState(() {
        _cartItems.clear();
        _selectedCustomer = null;
        _customerNameController.clear();
        _customerSearchController.clear();
        _discountController.clear();
        _notesController.clear();
        _selectedPayments.clear();
        _totalPaid = 0.0;
        _invoiceCounter++;
        _calculateTotals();
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في حفظ الفاتورة: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _clearCart() {
    setState(() {
      _cartItems.clear();
      _selectedCustomer = null;
      _customerNameController.clear();
      _customerSearchController.clear();
      _discountController.clear();
      _notesController.clear();
      _selectedPayments.clear();
      _totalPaid = 0.0;
      _calculateTotals();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Row(
        children: [
          // Left Sidebar - Product Categories (Professional Design)
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: _isSidebarCollapsed ? 0 : 280,
            child: _isSidebarCollapsed
                ? const SizedBox.shrink()
                : Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(2, 0),
                        ),
                      ],
                    ),
                    child: Column(
              children: [
                // Categories Header - Professional
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context).colorScheme.primary,
                        Theme.of(context).colorScheme.primary.withOpacity(0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(FontAwesomeIcons.layerGroup, color: Colors.white, size: 18),
                      ),
                      const SizedBox(width: 8),
                      const Flexible(
                        child: Text(
                          'الفئات',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.chevronLeft, color: Colors.white, size: 16),
                        padding: const EdgeInsets.all(4),
                        constraints: const BoxConstraints(),
                        tooltip: 'إخفاء القائمة',
                        onPressed: () {
                          setState(() {
                            _isSidebarCollapsed = true;
                          });
                        },
                      ),
                      if (_isAdminUser())
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            icon: const Icon(FontAwesomeIcons.users, color: Colors.white, size: 16),
                            padding: const EdgeInsets.all(4),
                            constraints: const BoxConstraints(),
                            tooltip: 'المستخدمين',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const UsersScreen()),
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
                // Categories List
                Expanded(
                  child: _isLoadingGroups
                      ? const Center(child: CircularProgressIndicator())
                      : _productGroups.isEmpty
                          ? const Center(child: Text('لا توجد فئات'))
                          : ListView.builder(
                              itemCount: _productGroups.length,
                              itemBuilder: (context, index) {
                                final group = _productGroups[index];
                                final groupIdValue = group['ProductGroupID_PK'];
                                final groupId = groupIdValue is int 
                                    ? groupIdValue 
                                    : int.tryParse(groupIdValue?.toString() ?? '0');
                                final isSelected = _selectedGroupId == groupId;
                                
                                return Container(
                                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _selectedGroupId = groupId;
                                        });
                                        _loadProducts();
                                      },
                                      borderRadius: BorderRadius.circular(12),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 14,
                                        ),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Theme.of(context).colorScheme.primaryContainer
                                              : Colors.transparent,
                                          borderRadius: BorderRadius.circular(12),
                                          border: Border.all(
                                            color: isSelected
                                                ? Theme.of(context).colorScheme.primary
                                                : Colors.transparent,
                                            width: 1.5,
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.all(6),
                                              decoration: BoxDecoration(
                                                color: isSelected
                                                    ? Theme.of(context).colorScheme.primary
                                                    : Theme.of(context).colorScheme.surfaceVariant,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Icon(
                                                FontAwesomeIcons.folder,
                                                size: 14,
                                                color: isSelected
                                                    ? Colors.white
                                                    : Theme.of(context).colorScheme.onSurfaceVariant,
                                              ),
                                            ),
                                            const SizedBox(width: 12),
                                            Expanded(
                                              child: Text(
                                                group['ProductGroupDescription']?.toString() ?? 'فئة',
                                                style: TextStyle(
                                                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                                                  fontSize: 14,
                                                  color: isSelected
                                                      ? Theme.of(context).colorScheme.onPrimaryContainer
                                                      : Theme.of(context).colorScheme.onSurface,
                                                ),
                                              ),
                                            ),
                                            if (isSelected)
                                              Icon(
                                                Icons.check_circle,
                                                size: 18,
                                                color: Theme.of(context).colorScheme.primary,
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ),
              ],
                    ),
                  ),
          ),
          // Toggle Button when sidebar is collapsed
          if (_isSidebarCollapsed)
            Container(
              width: 40,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primary.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(FontAwesomeIcons.chevronRight, color: Colors.white, size: 18),
                      tooltip: 'إظهار القائمة',
                      onPressed: () {
                        setState(() {
                          _isSidebarCollapsed = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          // Middle Panel - Products
          Expanded(
            flex: _showActivityLog ? 1 : 2,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              child: Column(
                children: [
                  // Search Bar - Professional
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: _productSearchController,
                        style: const TextStyle(fontSize: 16),
                        decoration: InputDecoration(
                          hintText: 'ابحث عن منتج بالاسم أو الكود...',
                          hintStyle: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.6),
                          ),
                          prefixIcon: Container(
                            margin: const EdgeInsets.all(8),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              FontAwesomeIcons.magnifyingGlass,
                              color: Theme.of(context).colorScheme.primary,
                              size: 18,
                            ),
                          ),
                          suffixIcon: _productSearchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                                  ),
                                  onPressed: () {
                                    _productSearchController.clear();
                                    _loadProducts();
                                  },
                                )
                              : null,
                          filled: true,
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        ),
                        onChanged: (value) {
                          if (value.length >= 2 || value.isEmpty) {
                            _loadProducts(search: value.isEmpty ? null : value);
                          }
                        },
                      ),
                    ),
                  ),
                  // Products List or Activity Log
                  Expanded(
                    child: _showActivityLog
                        ? _buildActivityLog()
                        : _buildProductsList(),
                  ),
                ],
              ),
            ),
          ),
          // Right Panel - Cart & Checkout
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                border: Border(
                  left: BorderSide(
                    color: Theme.of(context).colorScheme.outline,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Cart Header - Professional
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).colorScheme.primary,
                          Theme.of(context).colorScheme.primary.withOpacity(0.8),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.cartShopping,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            'سلة المشتريات',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        if (_cartItems.isNotEmpty) ...[
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${_cartItems.length}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.clear, color: Colors.white, size: 20),
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(),
                              onPressed: _clearCart,
                              tooltip: 'مسح السلة',
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Customer Selection - Compact
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            const Icon(FontAwesomeIcons.user, size: 14),
                            const SizedBox(width: 6),
                            const Expanded(
                              child: Text(
                                'العميل',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              ),
                            ),
                            if (_selectedCustomer != null)
                              IconButton(
                                icon: const Icon(Icons.close, size: 16),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: _clearCustomer,
                                tooltip: 'إلغاء اختيار العميل',
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        if (_selectedCustomer == null) ...[
                          TextField(
                            controller: _customerSearchController,
                            style: const TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              hintText: 'ابحث...',
                              hintStyle: const TextStyle(fontSize: 12),
                              prefixIcon: const Icon(FontAwesomeIcons.magnifyingGlass, size: 16),
                              suffixIcon: _customerSearchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear, size: 16),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        _customerSearchController.clear();
                                        _loadCustomers();
                                      },
                                    )
                                  : null,
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              isDense: true,
                            ),
                            onChanged: (value) {
                              if (value.length >= 2 || value.isEmpty) {
                                _loadCustomers(search: value.isEmpty ? null : value);
                                setState(() => _showCustomerSearch = true);
                              }
                            },
                            onTap: () {
                              if (_customers.isEmpty) {
                                _loadCustomers();
                              }
                              setState(() => _showCustomerSearch = true);
                            },
                          ),
                          if (_showCustomerSearch && _customers.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Container(
                              constraints: const BoxConstraints(maxHeight: 120),
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.surface,
                                border: Border.all(
                                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                                ),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: _customers.length,
                                itemBuilder: (context, index) {
                                  final customer = _customers[index];
                                  return ListTile(
                                    dense: true,
                                    contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                    title: Text(
                                      customer['CustomerName']?.toString() ?? '',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    subtitle: customer['CustomerPhone'] != null
                                        ? Text(
                                            customer['CustomerPhone']?.toString() ?? '',
                                            style: const TextStyle(fontSize: 10),
                                          )
                                        : null,
                                    onTap: () => _selectCustomer(customer),
                                  );
                                },
                              ),
                            ),
                          ],
                          const SizedBox(height: 6),
                          TextField(
                            controller: _customerNameController,
                            style: const TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              hintText: 'أو اسم عميل نقدي',
                              hintStyle: const TextStyle(fontSize: 12),
                              prefixIcon: const Icon(FontAwesomeIcons.userPlus, size: 16),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              isDense: true,
                            ),
                          ),
                        ] else ...[
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        _selectedCustomer!['CustomerName']?.toString() ?? '',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      if (_selectedCustomer!['CustomerPhone'] != null)
                                        Text(
                                          _selectedCustomer!['CustomerPhone']?.toString() ?? '',
                                          style: TextStyle(
                                            fontSize: 10,
                                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Cart Items
                  Expanded(
                    child: _cartItems.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  FontAwesomeIcons.cartShopping,
                                  size: 48,
                                  color: Colors.grey.shade300,
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  'السلة فارغة',
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            itemCount: _cartItems.length,
                            itemBuilder: (context, index) {
                              final item = _cartItems[index];
                              final qty = item['quantity'] ?? 1;
                              final price = (item['unitPrice'] ?? 0.0).toDouble();
                              final total = qty * price;
                              
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: Theme.of(context).colorScheme.surface,
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.05),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: ListTile(
                                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  title: Text(
                                    item['ProductName']?.toString() ?? 'منتج',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.primaryContainer,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            '${price.toStringAsFixed(2)} د.ل',
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                              color: Theme.of(context).colorScheme.onPrimaryContainer,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(
                                            'الإجمالي: ${total.toStringAsFixed(2)} د.ل',
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).colorScheme.surfaceContainerHighest,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            IconButton(
                                              icon: const Icon(Icons.remove, size: 18),
                                              onPressed: () => _updateQuantity(index, qty - 1),
                                              padding: const EdgeInsets.all(4),
                                              constraints: const BoxConstraints(),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Text(
                                                '$qty',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Theme.of(context).colorScheme.primary,
                                                ),
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.add, size: 18),
                                              onPressed: () => _updateQuantity(index, qty + 1),
                                              padding: const EdgeInsets.all(4),
                                              constraints: const BoxConstraints(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.red.shade50,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: IconButton(
                                          icon: Icon(Icons.delete_outline, color: Colors.red.shade700, size: 20),
                                          onPressed: () => _removeFromCart(index),
                                          padding: const EdgeInsets.all(8),
                                          constraints: const BoxConstraints(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  // Totals & Checkout - Compact
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        _buildTotalRow('المجموع الفرعي', _subTotal, compact: true),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: TextField(
                            controller: _discountController,
                            style: const TextStyle(fontSize: 12),
                            decoration: InputDecoration(
                              labelText: 'الخصم',
                              labelStyle: const TextStyle(fontSize: 12),
                              prefixIcon: const Icon(FontAwesomeIcons.percent, size: 16),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              isDense: true,
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: _updateDiscount,
                          ),
                        ),
                        _buildTotalRow('الخصم', _discount, compact: true),
                        const Divider(height: 1),
                        _buildTotalRow('الصافي', _netTotal, isTotal: true, compact: true),
                        const SizedBox(height: 8),
                        // Payment Methods Section - Compact
                        Container(
                          constraints: const BoxConstraints(maxHeight: 180),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.surface,
                            border: Border.all(
                              color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Row(
                                children: [
                                  const Icon(FontAwesomeIcons.creditCard, size: 14),
                                  const SizedBox(width: 6),
                                  const Expanded(
                                    child: Text(
                                      'طرق الدفع',
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.add, size: 16),
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: _isLoadingPaymentMethods 
                                        ? null 
                                        : () => _showPaymentMethodDialog(),
                                    tooltip: 'إضافة طريقة دفع',
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              if (_isLoadingPaymentMethods)
                                const Center(
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(strokeWidth: 2),
                                  ),
                                )
                              else if (_paymentMethods.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'لا توجد طرق دفع متاحة',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                )
                              else if (_selectedPayments.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8.0),
                                  child: Text(
                                    'لا توجد طرق دفع',
                                    style: TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                )
                              else
                                ConstrainedBox(
                                  constraints: const BoxConstraints(maxHeight: 150),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: _selectedPayments.asMap().entries.map((entry) {
                                        final index = entry.key;
                                        final payment = entry.value;
                                        return Container(
                                          margin: const EdgeInsets.only(bottom: 4),
                                          padding: const EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            color: Theme.of(context).colorScheme.secondaryContainer,
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: Row(
                                            children: [
                                              Flexible(
                                                flex: 1,
                                                child: Text(
                                                  '${payment['paymentMethodCaption']}: ${payment['locCurrencyAmount'].toStringAsFixed(2)}',
                                                  style: const TextStyle(fontSize: 12),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              const SizedBox(width: 4),
                                              IconButton(
                                                icon: const Icon(Icons.close, size: 16),
                                                padding: EdgeInsets.zero,
                                                constraints: const BoxConstraints(),
                                                onPressed: () => _removePayment(index),
                                                tooltip: 'حذف',
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 6),
                              _buildTotalRow('إجمالي المدفوع', _totalPaid, compact: true),
                            ],
                          ),
                        ),
                        if (_change > 0) ...[
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.green.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.green.shade200),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'الباقي',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  _change.toStringAsFixed(2),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.green.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ] else if (_change < 0) ...[
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.red.shade50,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.red.shade200),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'المبلغ المطلوب',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                                Text(
                                  (-_change).toStringAsFixed(2),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                    color: Colors.red.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        const SizedBox(height: 8),
                        // Notes - Compact
                        TextField(
                          controller: _notesController,
                          style: const TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            labelText: 'ملاحظات',
                            labelStyle: const TextStyle(fontSize: 12),
                            prefixIcon: const Icon(FontAwesomeIcons.noteSticky, size: 16),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                            isDense: true,
                          ),
                          maxLines: 2,
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          height: 52,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Theme.of(context).colorScheme.primary,
                                Theme.of(context).colorScheme.primary.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ElevatedButton.icon(
                            onPressed: _processSale,
                            icon: const Icon(FontAwesomeIcons.check, size: 20),
                            label: const Text(
                              'إتمام البيع',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 0.5,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.white,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductsList() {
    return _isLoadingProducts
        ? const Center(child: CircularProgressIndicator())
        : _products.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      FontAwesomeIcons.box,
                      size: 48,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'لا توجد منتجات',
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.75,
                ),
                itemCount: _products.length,
                itemBuilder: (context, index) {
                  final product = _products[index];
                  final productName = product['ProductName']?.toString() ?? 'منتج';
                  final productCode = product['ProductCode']?.toString() ?? '';
                  final stockOnHand = (product['StockOnHand'] ?? 0.0) is double 
                      ? product['StockOnHand'] 
                      : double.tryParse(product['StockOnHand']?.toString() ?? '0') ?? 0.0;
                  final unitPrice = (product['UnitPrice'] ?? 0.0) is double 
                      ? product['UnitPrice'] 
                      : double.tryParse(product['UnitPrice']?.toString() ?? '0') ?? 0.0;
                  final minStockLevel = (product['MinStockLevel'] ?? 0.0) is double 
                      ? product['MinStockLevel'] 
                      : double.tryParse(product['MinStockLevel']?.toString() ?? '0') ?? 0.0;
                  final uomName = product['UOMName']?.toString() ?? '';
                  final isLowStock = stockOnHand <= minStockLevel;
                  
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => _addToCart(product),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Product Image/Icon Section
                          Container(
                            height: 120,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  Theme.of(context).colorScheme.secondary.withOpacity(0.05),
                                ],
                              ),
                            ),
                            child: Stack(
                              children: [
                                Center(
                                  child: Icon(
                                    FontAwesomeIcons.box,
                                    size: 56,
                                    color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
                                  ),
                                ),
                                // Stock Badge
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: isLowStock 
                                          ? Theme.of(context).colorScheme.error.withOpacity(0.9)
                                          : Theme.of(context).colorScheme.primary.withOpacity(0.9),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      stockOnHand.toStringAsFixed(0),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Product Info Section
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Product Name
                                  Flexible(
                                    child: Text(
                                      productName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color: Theme.of(context).colorScheme.onSurface,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  // Product Code
                                  if (productCode.isNotEmpty)
                                    Flexible(
                                      child: Text(
                                        'كود: $productCode',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  const Spacer(),
                                  // Price Section
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            '${unitPrice.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: Theme.of(context).colorScheme.primary,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        if (uomName.isNotEmpty)
                                          Flexible(
                                            child: Text(
                                              ' / $uomName',
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
  }

  Widget _buildActivityLog() {
    return _activityLogs.isEmpty
        ? const Center(child: Text('لا توجد سجلات'))
        : ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _activityLogs.length,
            itemBuilder: (context, index) {
              final log = _activityLogs[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: Icon(
                    FontAwesomeIcons.clock,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: Text(
                    log['Action']?.toString() ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(log['Details']?.toString() ?? ''),
                      const SizedBox(height: 4),
                      Text(
                        'المستخدم: ${log['UserName']?.toString() ?? ''}',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                      Text(
                        'التاريخ: ${log['LogDate']?.toString() ?? ''}',
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }

  Widget _buildTotalRow(String label, double value, {bool isTotal = false, bool compact = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: compact ? 2 : 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: compact ? (isTotal ? 14 : 12) : (isTotal ? 18 : 16),
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value.toStringAsFixed(2),
            style: TextStyle(
              fontSize: compact ? (isTotal ? 14 : 12) : (isTotal ? 20 : 16),
              fontWeight: FontWeight.bold,
              color: isTotal ? Theme.of(context).colorScheme.primary : null,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showPaymentMethodDialog() async {
    if (_paymentMethods.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا توجد طرق دفع متاحة'), backgroundColor: Colors.orange),
      );
      return;
    }

    final TextEditingController amountController = TextEditingController();
    Map<String, dynamic>? selectedMethod;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: const Text('اختر طريقة الدفع'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<Map<String, dynamic>>(
                decoration: const InputDecoration(
                  labelText: 'طريقة الدفع',
                  border: OutlineInputBorder(),
                ),
                items: _paymentMethods.map((method) {
                  return DropdownMenuItem<Map<String, dynamic>>(
                    value: method,
                    child: Text(method['PaymentMethodCaption']?.toString() ?? ''),
                  );
                }).toList(),
                onChanged: (value) {
                  setDialogState(() {
                    selectedMethod = value;
                  });
                },
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                decoration: const InputDecoration(
                  labelText: 'المبلغ',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                if (selectedMethod == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('يرجى اختيار طريقة دفع'), backgroundColor: Colors.red),
                  );
                  return;
                }
                final amount = double.tryParse(amountController.text) ?? 0.0;
                if (amount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('يرجى إدخال مبلغ صحيح'), backgroundColor: Colors.red),
                  );
                  return;
                }
                _addPaymentMethod(selectedMethod!, amount);
                Navigator.pop(context);
              },
              child: const Text('إضافة'),
            ),
          ],
        ),
      ),
    );
  }
}

