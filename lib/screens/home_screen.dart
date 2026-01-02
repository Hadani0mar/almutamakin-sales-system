import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'pos_screen.dart';
import 'user_session_actions_screen.dart';
import 'sales_invoices_screen.dart';
import 'stock_management_screen.dart';
import 'login_screen.dart';
import 'update_check_screen.dart';
import '../services/update_service.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic>? currentUser;
  
  const HomeScreen({super.key, this.currentUser});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _selectedIndex;
  
  @override
  void initState() {
    super.initState();
    // التحقق من التحديثات تلقائياً بعد 3 ثواني من بدء التطبيق
    Future.delayed(const Duration(seconds: 3), () {
      _checkForUpdatesAutomatically();
    });
  }
  
  Future<void> _checkForUpdatesAutomatically() async {
    try {
      final updateInfo = await UpdateService.checkForUpdates();
      if (updateInfo != null && 
          updateInfo['hasUpdate'] == true && 
          mounted) {
        _showUpdateDialog(updateInfo);
      }
    } catch (e) {
      // لا نعرض خطأ للمستخدم، فقط نسجله
      print('خطأ في التحقق التلقائي من التحديثات: $e');
    }
  }
  
  void _showUpdateDialog(Map<String, dynamic> updateInfo) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(FontAwesomeIcons.circleExclamation, color: Colors.orange),
            const SizedBox(width: 10),
            const Text('تحديث متاح'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('الإصدار الحالي: ${updateInfo['currentVersion']}'),
            Text('الإصدار الجديد: ${updateInfo['latestVersion']}'),
            const SizedBox(height: 10),
            const Text('هل تريد التحديث الآن؟'),
            const SizedBox(height: 10),
            const Text(
              'سيتم تنزيل وتثبيت التحديث تلقائياً',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('لاحقاً'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UpdateCheckScreen(autoInstall: true, updateInfo: updateInfo),
                ),
              );
            },
            child: const Text('تحديث الآن'),
          ),
        ],
      ),
    );
  }

  final List<NavigationItem> _navigationItems = [
    NavigationItem(
      title: 'نقطة البيع',
      icon: FontAwesomeIcons.cashRegister,
      screenBuilder: (currentUser) => POSScreen(currentUser: currentUser),
    ),
    NavigationItem(
      title: 'الفواتير',
      icon: FontAwesomeIcons.receipt,
      screenBuilder: (currentUser) => SalesInvoicesScreen(currentUser: currentUser),
    ),
    NavigationItem(
      title: 'المخزون',
      icon: FontAwesomeIcons.boxesStacked,
      screenBuilder: (currentUser) => StockManagementScreen(currentUser: currentUser),
    ),
    NavigationItem(
      title: 'سجل العمليات',
      icon: FontAwesomeIcons.listCheck,
      screenBuilder: (currentUser) => UserSessionActionsScreen(currentUser: currentUser),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                left: BorderSide(
                  color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                  width: 1,
                ),
              ),
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.all(20),
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
                      Icon(
                        FontAwesomeIcons.store,
                        color: Theme.of(context).colorScheme.onPrimary,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'نظام المتمكن',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // User Info
                if (widget.currentUser != null)
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      border: Border(
                        bottom: BorderSide(
                          color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Theme.of(context).colorScheme.primary,
                          child: Icon(
                            FontAwesomeIcons.user,
                            color: Theme.of(context).colorScheme.onPrimary,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.currentUser!['FullName']?.toString() ?? 'مستخدم',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                widget.currentUser!['username']?.toString() ?? '',
                                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                // Navigation Items
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: _navigationItems.length,
                    itemBuilder: (context, index) {
                      final item = _navigationItems[index];
                      final isSelected = _selectedIndex == index;
                      
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Theme.of(context).colorScheme.primaryContainer
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Icon(
                            item.icon,
                            color: isSelected
                                ? Theme.of(context).colorScheme.onPrimaryContainer
                                : Theme.of(context).colorScheme.onSurfaceVariant,
                            size: 22,
                          ),
                          title: Text(
                            item.title,
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              color: isSelected
                                  ? Theme.of(context).colorScheme.onPrimaryContainer
                                  : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                          trailing: isSelected
                              ? Icon(
                                  FontAwesomeIcons.chevronLeft,
                                  size: 16,
                                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                                )
                              : null,
                          onTap: () {
                            setState(() {
                              _selectedIndex = index;
                            });
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Update Check Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.arrowsRotate,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    title: Text(
                      'التحقق من التحديثات',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const UpdateCheckScreen()),
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                // Logout Button
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Theme.of(context).colorScheme.outline.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(
                      FontAwesomeIcons.rightFromBracket,
                      color: Theme.of(context).colorScheme.error,
                      size: 20,
                    ),
                    title: Text(
                      'تسجيل الخروج',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                        (route) => false,
                      );
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: _selectedIndex != null
                ? _navigationItems[_selectedIndex!].screenBuilder(widget.currentUser)
                : Container(
                    color: Theme.of(context).colorScheme.surface,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesomeIcons.handPointer,
                            size: 64,
                            color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.3),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'اختر قسمًا من القائمة الجانبية',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final String title;
  final IconData icon;
  final Widget Function(Map<String, dynamic>? currentUser) screenBuilder;

  NavigationItem({
    required this.title,
    required this.icon,
    required this.screenBuilder,
  });
}
