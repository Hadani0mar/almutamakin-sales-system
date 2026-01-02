// Example usage of DatabaseService with ODBC
// This file demonstrates how to use the DatabaseService in your Flutter app

import 'package:flutter/material.dart';
import 'database_service_odbc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize database connection
  final dbService = DatabaseService();
  final connected = await dbService.connect();
  
  if (!connected) {
    print('فشل الاتصال بقاعدة البيانات');
    return;
  }
  
  runApp(MyApp(dbService: dbService));
}

class MyApp extends StatelessWidget {
  final DatabaseService dbService;
  
  const MyApp({super.key, required this.dbService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQL Server Example',
      home: DatabaseExampleScreen(dbService: dbService),
    );
  }
}

class DatabaseExampleScreen extends StatefulWidget {
  final DatabaseService dbService;
  
  const DatabaseExampleScreen({super.key, required this.dbService});

  @override
  State<DatabaseExampleScreen> createState() => _DatabaseExampleScreenState();
}

class _DatabaseExampleScreenState extends State<DatabaseExampleScreen> {
  List<Map<String, dynamic>> _products = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      // Example 1: Simple SELECT query
      final products = await widget.dbService.query('''
        SELECT TOP 50 
          ProductID_PK,
          ProductCode,
          ProductName,
          StockOnHand,
          IsInActive
        FROM Inventory.Data_Products
        ORDER BY ProductID_PK DESC
      ''');
      
      setState(() {
        _products = products;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _testConnection() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final isConnected = await widget.dbService.testConnection();
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(isConnected ? 'الاتصال ناجح' : 'فشل الاتصال'),
            backgroundColor: isConnected ? Colors.green : Colors.red,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    // Close connection when screen is disposed
    widget.dbService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('مثال على استخدام قاعدة البيانات'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadProducts,
          ),
          IconButton(
            icon: const Icon(Icons.check_circle),
            onPressed: _testConnection,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error != null
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, color: Colors.red, size: 64),
                      const SizedBox(height: 16),
                      Text('خطأ: $_error'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadProducts,
                        child: const Text('إعادة المحاولة'),
                      ),
                    ],
                  ),
                )
              : _products.isEmpty
                  ? const Center(child: Text('لا توجد بيانات'))
                  : ListView.builder(
                      itemCount: _products.length,
                      itemBuilder: (context, index) {
                        final product = _products[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            title: Text(
                              product['ProductName']?.toString() ?? 'غير محدد',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('الكود: ${product['ProductCode'] ?? 'N/A'}'),
                                Text('المخزون: ${product['StockOnHand'] ?? '0'}'),
                                Text(
                                  'الحالة: ${product['IsInActive'] == false || product['IsInActive'] == 0 ? 'نشط' : 'غير نشط'}',
                                  style: TextStyle(
                                    color: product['IsInActive'] == false ||
                                            product['IsInActive'] == 0
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ],
                            ),
                            leading: CircleAvatar(
                              backgroundColor: Colors.blue.shade100,
                              child: Text(
                                product['ProductCode']?.toString().substring(0, 1).toUpperCase() ?? 'P',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
    );
  }
}


