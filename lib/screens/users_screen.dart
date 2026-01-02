import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:data_table_2/data_table_2.dart';
import '../database_service.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    setState(() => _isLoading = true);
    try {
      final users = await DatabaseService.getAllUsers();
      setState(() {
        _users = users;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('خطأ: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(FontAwesomeIcons.users, color: Colors.white, size: 28),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'إدارة المستخدمين',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(FontAwesomeIcons.arrowRotateRight, color: Colors.white),
                      onPressed: _loadUsers,
                    ),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _users.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(FontAwesomeIcons.users, size: 64, color: Colors.grey.shade300),
                                const SizedBox(height: 16),
                                Text('لا يوجد مستخدمين', style: TextStyle(color: Colors.grey.shade600, fontSize: 18)),
                              ],
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(16),
                            child: DataTable2(
                              columnSpacing: 12,
                              horizontalMargin: 12,
                              minWidth: 1000,
                              columns: const [
                                DataColumn2(label: Text('ID'), size: ColumnSize.S),
                                DataColumn2(label: Text('الاسم الكامل'), size: ColumnSize.L),
                                DataColumn2(label: Text('اسم المستخدم'), size: ColumnSize.M),
                                DataColumn2(label: Text('كلمة السر'), size: ColumnSize.M),
                                DataColumn2(label: Text('البريد الإلكتروني'), size: ColumnSize.L),
                                DataColumn2(label: Text('الهاتف'), size: ColumnSize.M),
                                DataColumn2(label: Text('مفعل'), size: ColumnSize.S),
                              ],
                              rows: _users.map((user) {
                                return DataRow2(
                                  cells: [
                                    DataCell(Text(user['UserID_PK']?.toString() ?? '')),
                                    DataCell(Text(user['FullName']?.toString() ?? '')),
                                    DataCell(Text(user['username']?.toString() ?? '')),
                                    DataCell(Text(user['Password']?.toString() ?? '')),
                                    DataCell(Text(user['Email']?.toString() ?? '')),
                                    DataCell(Text(user['Phone']?.toString() ?? '')),
                                    DataCell(
                                      Icon(
                                        (user['IsAproved'] == true || user['IsAproved'] == 1)
                                            ? Icons.check_circle
                                            : Icons.cancel,
                                        color: (user['IsAproved'] == true || user['IsAproved'] == 1)
                                            ? Colors.green
                                            : Colors.red,
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

