import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../database_service.dart';
import 'login_screen.dart';

class UserSessionActionsScreen extends StatefulWidget {
  final Map<String, dynamic>? currentUser;
  
  const UserSessionActionsScreen({super.key, this.currentUser});

  @override
  State<UserSessionActionsScreen> createState() => _UserSessionActionsScreenState();
}

class _UserSessionActionsScreenState extends State<UserSessionActionsScreen> {
  List<Map<String, dynamic>> _actions = [];
  bool _isLoading = false;
  DateTime? _selectedDate;
  int? _selectedUserId;

  @override
  void initState() {
    super.initState();
    _loadActions();
  }

  Future<void> _loadActions({DateTime? date, int? userId}) async {
    if (!mounted) return;
    setState(() => _isLoading = true);
    
    try {
      final actions = await DatabaseService.getUserSessionActions(
        date: date ?? _selectedDate,
        userId: userId ?? _selectedUserId,
      );
      
      if (mounted) {
        setState(() {
          _actions = actions;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في تحميل العمليات: $e'),
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
                  'سجل جميع العمليات',
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
                  onPressed: () => _loadActions(),
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
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime.now(),
                      );
                      if (date != null) {
                        setState(() => _selectedDate = date);
                        _loadActions(date: date);
                      }
                    },
                    icon: const Icon(FontAwesomeIcons.calendar),
                    label: Text(_selectedDate == null 
                        ? 'اختر التاريخ' 
                        : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _selectedDate = null;
                      _selectedUserId = null;
                    });
                    _loadActions();
                  },
                  icon: const Icon(FontAwesomeIcons.xmark),
                  label: const Text('إعادة تعيين'),
                ),
              ],
            ),
          ),
          // Actions List
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _actions.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.listCheck,
                              size: 64,
                              color: Colors.grey.shade300,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'لا توجد عمليات',
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
                        itemCount: _actions.length,
                        itemBuilder: (context, index) {
                          final action = _actions[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: InkWell(
                              onTap: () => _showActionDetails(action),
                              borderRadius: BorderRadius.circular(12),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                                  child: Icon(
                                    FontAwesomeIcons.user,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                title: Text(
                                  action['ActionDescription']?.toString() ?? 'عملية',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(height: 4),
                                    Text('المستخدم: ${action['UserName'] ?? 'غير محدد'}'),
                                    Text('التاريخ: ${_formatDate(action['UserSessionActionDate'])}'),
                                    if (action['ActionProductName'] != null)
                                      Text('المنتج: ${action['ActionProductName']}'),
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

  Future<void> _showActionDetails(Map<String, dynamic> action) async {
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
                      FontAwesomeIcons.listCheck,
                      color: Colors.white,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'تفاصيل العملية',
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
                        'معلومات العملية',
                        [
                          _buildDetailRow('الوصف', action['ActionDescription']?.toString() ?? 'غير محدد'),
                          _buildDetailRow('تاريخ العملية', _formatDate(action['UserSessionActionDate'])),
                          _buildDetailRow('معرف العملية', action['UserSessionActionID_PK']?.toString() ?? 'غير محدد'),
                          _buildDetailRow('نوع العملية', action['SubActionType']?.toString() ?? 'غير محدد'),
                          _buildDetailRow('معرف العملية الفرعية', action['SubActionID_FK']?.toString() ?? 'غير محدد'),
                        ],
                      ),
                      const SizedBox(height: 16),
                      _buildDetailSection(
                        'معلومات المستخدم',
                        [
                          _buildDetailRow('اسم المستخدم', action['UserName']?.toString() ?? 'غير محدد'),
                          _buildDetailRow('معرف المستخدم', action['UserID_FK']?.toString() ?? 'غير محدد'),
                          _buildDetailRow('معرف الجلسة', action['SessionID_FK']?.toString() ?? 'غير محدد'),
                          if (action['LoginPC'] != null)
                            _buildDetailRow('جهاز الكمبيوتر', action['LoginPC']?.toString() ?? 'غير محدد'),
                          if (action['SessionLoginTime'] != null)
                            _buildDetailRow('وقت تسجيل الدخول', _formatDate(action['SessionLoginTime'])),
                          if (action['SessionLogOutTime'] != null)
                            _buildDetailRow('وقت تسجيل الخروج', _formatDate(action['SessionLogOutTime'])),
                        ],
                      ),
                      if (action['ActionProductName'] != null || action['ActionProductID_FK'] != null)
                        const SizedBox(height: 16),
                      if (action['ActionProductName'] != null || action['ActionProductID_FK'] != null)
                        _buildDetailSection(
                          'معلومات المنتج',
                          [
                            if (action['ActionProductName'] != null)
                              _buildDetailRow('اسم المنتج', action['ActionProductName']?.toString() ?? 'غير محدد'),
                            if (action['ActionProductID_FK'] != null)
                              _buildDetailRow('معرف المنتج', action['ActionProductID_FK']?.toString() ?? 'غير محدد'),
                          ],
                        ),
                      if (action['ActionOldValue'] != null || action['ActionNewValue'] != null)
                        const SizedBox(height: 16),
                      if (action['ActionOldValue'] != null || action['ActionNewValue'] != null)
                        _buildDetailSection(
                          'قيم العملية',
                          [
                            if (action['ActionOldValue'] != null)
                              _buildDetailRow('القيمة القديمة', _formatValue(action['ActionOldValue'], action['ActionValueType'])),
                            if (action['ActionNewValue'] != null)
                              _buildDetailRow('القيمة الجديدة', _formatValue(action['ActionNewValue'], action['ActionValueType'])),
                            if (action['ActionValueType'] != null)
                              _buildDetailRow('نوع القيمة', _getValueTypeName(action['ActionValueType'])),
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

  String _formatValue(dynamic value, dynamic valueType) {
    if (value == null) return 'غير محدد';
    
    try {
      if (value is num) {
        // Format based on value type
        if (valueType == 1) {
          // Decimal/Money
          return value.toStringAsFixed(2);
        } else if (valueType == 2) {
          // Integer
          return value.toInt().toString();
        } else {
          return value.toString();
        }
      }
      return value.toString();
    } catch (e) {
      return value.toString();
    }
  }

  String _getValueTypeName(dynamic valueType) {
    if (valueType == null) return 'غير محدد';
    
    switch (valueType) {
      case 1:
        return 'قيمة عشرية / مالية';
      case 2:
        return 'عدد صحيح';
      case 3:
        return 'نسبة مئوية';
      default:
        return 'نوع غير محدد ($valueType)';
    }
  }

  String _formatDate(dynamic date) {
    if (date == null) return 'غير محدد';
    try {
      if (date is DateTime) {
        return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';
      }
      final dateStr = date.toString();
      if (dateStr.contains('T')) {
        final dt = DateTime.parse(dateStr);
        return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
      }
      // Try to parse as SQL Server datetime format
      try {
        final dt = DateTime.parse(dateStr);
        return '${dt.year}-${dt.month.toString().padLeft(2, '0')}-${dt.day.toString().padLeft(2, '0')} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}:${dt.second.toString().padLeft(2, '0')}';
      } catch (_) {
        return dateStr;
      }
    } catch (e) {
      return date.toString();
    }
  }
}

