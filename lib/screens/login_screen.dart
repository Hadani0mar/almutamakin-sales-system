import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../database_service.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isLoadingUsers = false;
  String? _errorMessage;
  List<Map<String, dynamic>> _users = [];
  Map<String, dynamic>? _selectedUser;
  
  late AnimationController _animationController;
  late AnimationController _backgroundAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    
    // Animation controller for main content
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    // Background animation controller
    _backgroundAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat();
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );
    
    _rotationAnimation = Tween<double>(begin: 0.0, end: 0.1).animate(
      CurvedAnimation(
        parent: _backgroundAnimationController,
        curve: Curves.easeInOut,
      ),
    );
    
    _animationController.forward();
    _loadUsers();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _animationController.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  Future<void> _loadUsers() async {
    if (!mounted) return;
    setState(() {
      _isLoadingUsers = true;
      _errorMessage = null;
    });
    
    try {
      final users = await DatabaseService.getAllUsers();
      
      // Filter only approved users (check for 1, true, or non-null)
      final approvedUsers = users.where((user) {
        final isApproved = user['IsAproved'];
        return isApproved == true || 
               isApproved == 1 || 
               (isApproved != null && isApproved != false && isApproved != 0);
      }).toList();
      
      if (mounted) {
        setState(() {
          _users = approvedUsers;
          _isLoadingUsers = false;
          if (_users.isEmpty) {
            _errorMessage = 'لا يوجد مستخدمين مفعلين في النظام';
          }
        });
      }
    } catch (e) {
      print('خطأ في تحميل المستخدمين: $e');
      if (mounted) {
        setState(() {
          _isLoadingUsers = false;
          _errorMessage = 'خطأ في تحميل المستخدمين: $e';
        });
      }
    }
  }

  Future<void> _handleLogin() async {
    if (_selectedUser == null) {
      setState(() {
        _errorMessage = 'الرجاء اختيار مستخدم';
      });
      return;
    }

    final password = _passwordController.text.trim();

    if (password.isEmpty) {
      setState(() {
        _errorMessage = 'الرجاء إدخال كلمة السر';
      });
      return;
    }

    if (!mounted) return;
    
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final username = _selectedUser!['username']?.toString() ?? '';
      final storedPassword = _selectedUser!['Password']?.toString() ?? '';
      
      // Compare passwords directly since they're stored in plain text
      if (password == storedPassword) {
        // Log login activity
        await DatabaseService.logActivity(
          userId: int.tryParse(_selectedUser!['UserID_PK']?.toString() ?? '0') ?? 0,
          userName: _selectedUser!['FullName']?.toString() ?? username,
          action: 'تسجيل الدخول',
          details: 'تم تسجيل الدخول بنجاح',
        ).catchError((e) {
          print('خطأ في تسجيل النشاط: $e');
        });

        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(currentUser: _selectedUser),
            ),
          );
        }
      } else {
        if (mounted) {
          setState(() {
            _errorMessage = 'كلمة السر غير صحيحة';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      print('خطأ في تسجيل الدخول: $e');
      if (mounted) {
        setState(() {
          _errorMessage = 'خطأ في الاتصال بقاعدة البيانات: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  Theme.of(context).colorScheme.primary.withOpacity(0.5),
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: Stack(
              children: [
                // Animated background circles
                Positioned(
                  top: -100,
                  right: -100,
                  child: Transform.rotate(
                    angle: _rotationAnimation.value,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: -150,
                  left: -150,
                  child: Transform.rotate(
                    angle: -_rotationAnimation.value,
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 200,
                  left: 50,
                  child: Transform.rotate(
                    angle: _rotationAnimation.value * 0.5,
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.05),
                      ),
                    ),
                  ),
                ),
                // Main content
                SafeArea(
                  child: Center(
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: ScaleTransition(
                          scale: _scaleAnimation,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.all(32.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                      // Animated Icon with pulse effect
                      TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0.0, end: 1.0),
                        duration: const Duration(milliseconds: 1200),
                        curve: Curves.elasticOut,
                        builder: (context, value, child) {
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              // Pulse circles
                              ...List.generate(3, (index) {
                                return TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.0, end: 1.0),
                                  duration: Duration(milliseconds: 2000 + (index * 500)),
                                  builder: (context, pulseValue, child) {
                                    return Container(
                                      width: 140 + (pulseValue * 40 * (index + 1)),
                                      height: 140 + (pulseValue * 40 * (index + 1)),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white.withOpacity(
                                          (1 - pulseValue) * 0.2,
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }),
                              // Main icon container
                              Transform.scale(
                                scale: value,
                                child: Container(
                                  width: 140,
                                  height: 140,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.3),
                                        blurRadius: 30,
                                        offset: const Offset(0, 15),
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    FontAwesomeIcons.lock,
                                    size: 70,
                                    color: Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                      const SizedBox(height: 50),
                      const Text(
                        'مرحباً! 👋',
                        style: TextStyle(
                          fontSize: 42,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'تسجيل الدخول',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white.withValues(alpha: 0.9),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 50),
                      // User Selection Dropdown
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: _isLoadingUsers
                            ? Padding(
                                padding: const EdgeInsets.all(24.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 24,
                                      height: 24,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(
                                          Theme.of(context).colorScheme.primary,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    Text(
                                      'جاري تحميل المستخدمين...',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<Map<String, dynamic>>(
                                    value: _selectedUser,
                                    hint: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 8),
                                      child: Row(
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.user,
                                            color: Colors.grey.shade400,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            'اختر المستخدم',
                                            style: TextStyle(
                                              color: Colors.grey.shade400,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    isExpanded: true,
                                    icon: Icon(
                                      FontAwesomeIcons.chevronDown,
                                      color: Theme.of(context).colorScheme.primary,
                                    ),
                                    items: _users.map((user) {
                                      return DropdownMenuItem<Map<String, dynamic>>(
                                        value: user,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(vertical: 4),
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.user,
                                                color: Theme.of(context).colorScheme.primary,
                                                size: 16,
                                              ),
                                              const SizedBox(width: 8),
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize: MainAxisSize.min,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      user['FullName']?.toString() ?? 'مستخدم',
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                    ),
                                                    if (user['username'] != null)
                                                      Text(
                                                        '${user['username']}',
                                                        style: TextStyle(
                                                          fontSize: 10,
                                                          color: Colors.grey.shade600,
                                                          height: 1.2,
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
                                      );
                                    }).toList(),
                                    onChanged: (user) {
                                      setState(() {
                                        _selectedUser = user;
                                        _errorMessage = null;
                                        _passwordController.clear();
                                      });
                                    },
                                  ),
                                ),
                              ),
                      ),
                      const SizedBox(height: 20),
                      // Password field
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.15),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          textAlign: TextAlign.center,
                          enabled: _selectedUser != null,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                          decoration: InputDecoration(
                            hintText: _selectedUser == null 
                                ? 'اختر مستخدم أولاً'
                                : 'كلمة السر',
                            hintStyle: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 18,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 24,
                            ),
                            prefixIcon: Icon(
                              FontAwesomeIcons.key,
                              color: _selectedUser == null
                                  ? Colors.grey.shade300
                                  : Theme.of(context).colorScheme.primary,
                              size: 20,
                            ),
                            suffixIcon: _selectedUser != null
                                ? IconButton(
                                    icon: Icon(
                                      _obscurePassword
                                          ? FontAwesomeIcons.eyeSlash
                                          : FontAwesomeIcons.eye,
                                      color: Colors.grey,
                                      size: 20,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscurePassword = !_obscurePassword;
                                      });
                                    },
                                  )
                                : null,
                          ),
                          onSubmitted: (_) {
                            if (_selectedUser != null) {
                              _handleLogin();
                            }
                          },
                        ),
                      ),
                      // Error message
                      if (_errorMessage != null) ...[
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red.shade50,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.red.shade300,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.triangleExclamation,
                                color: Colors.red.shade700,
                                size: 18,
                              ),
                              const SizedBox(width: 12),
                              Flexible(
                                child: Text(
                                  _errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red.shade700,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      const SizedBox(height: 40),
                      // Login button
                      SizedBox(
                        width: double.infinity,
                        height: 60,
                        child: ElevatedButton(
                          onPressed: (_isLoading || _selectedUser == null) ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Theme.of(context).colorScheme.primary,
                            elevation: 8,
                            shadowColor: Colors.black.withValues(alpha: 0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            disabledBackgroundColor: Colors.grey.shade300,
                          ),
                          child: _isLoading
                              ? SizedBox(
                                  width: 28,
                                  height: 28,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Theme.of(context).colorScheme.primary,
                                    ),
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.rightToBracket,
                                      size: 20,
                                      color: _selectedUser == null
                                          ? Colors.grey
                                          : Theme.of(context).colorScheme.primary,
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      'دخول',
                                      style: TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1,
                                        color: _selectedUser == null
                                            ? Colors.grey
                                            : Theme.of(context).colorScheme.primary,
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
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
