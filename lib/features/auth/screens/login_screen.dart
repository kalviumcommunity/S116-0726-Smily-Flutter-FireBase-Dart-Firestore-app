import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/constants/app_constants.dart';
import '../../../services/auth_service.dart';
import '../widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _authService = AuthService();

  // Form Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Screen State
  bool _isPasswordVisible = false;
  bool _rememberMe = true;
  bool _isLoading = false;
  String _selectedRoleView = AppConstants.rolePassenger;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userModel = await _authService.loginUser(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );

      if (!mounted) return;

      _showSnackBar(
        'Welcome back, ${userModel.fullName}!',
        isError: false,
      );

      // Route based on user role from Firestore
      final targetRoute = userModel.role == AppConstants.roleDriver
          ? AppRoutesNames.driverDashboard
          : AppRoutesNames.passengerHome;

      Navigator.of(context).pushReplacementNamed(targetRoute);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(e.toString(), isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _handleForgotPassword() async {
    final resetEmailController = TextEditingController(text: _emailController.text.trim());

    final bool? shouldReset = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppTheme.cardDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: const [
              Icon(Icons.lock_reset_rounded, color: AppTheme.primaryAmber),
              SizedBox(width: 10),
              Text(
                'Reset Password',
                style: TextStyle(
                  color: AppTheme.textPrimaryLight,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Enter your registered email address and we will send you instructions to reset your password.',
                style: TextStyle(color: AppTheme.textSecondaryLight, fontSize: 13),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Email Address',
                hintText: 'e.g. user@example.com',
                controller: resetEmailController,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogContext).pop(false),
              child: const Text('Cancel', style: TextStyle(color: AppTheme.textSecondaryLight)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(dialogContext).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryAmber,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text('Send Link', style: TextStyle(color: AppTheme.bgDark, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );

    if (shouldReset == true) {
      final email = resetEmailController.text.trim();
      if (email.isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email)) {
        _showSnackBar('Please enter a valid email address.', isError: true);
        return;
      }

      try {
        await _authService.sendPasswordResetEmail(email);
        if (!mounted) return;
        _showSnackBar('Password reset link sent to $email', isError: false);
      } catch (e) {
        if (!mounted) return;
        _showSnackBar(e.toString(), isError: true);
      }
    }
  }

  void _fillDemoCredentials(String role) {
    setState(() {
      _selectedRoleView = role;
      if (role == AppConstants.roleDriver) {
        _emailController.text = 'driver.demo@unionride.com';
        _passwordController.text = 'driver123';
      } else {
        _emailController.text = 'passenger.demo@unionride.com';
        _passwordController.text = 'passenger123';
      }
    });

    _showSnackBar('Demo credentials loaded for ${role.toUpperCase()}', isError: false);
  }

  void _showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              isError ? Icons.error_outline : Icons.check_circle_outline,
              color: Colors.white,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        backgroundColor: isError ? AppTheme.errorRed : AppTheme.accentGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bgDark,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                
                // Brand Hero Header
                _buildBrandHeader(),
                const SizedBox(height: 32),

                // Role Quick Tabs (Passenger / Driver Demo Toggle)
                _buildRoleTabs(),
                const SizedBox(height: 24),

                // Email Address Input
                CustomTextField(
                  label: 'Email Address',
                  hintText: 'Enter your registered email',
                  controller: _emailController,
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                    if (!emailRegex.hasMatch(val.trim())) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 18),

                // Password Input
                CustomTextField(
                  label: 'Password',
                  hintText: 'Enter your password',
                  controller: _passwordController,
                  prefixIcon: Icons.lock_outline_rounded,
                  isPassword: true,
                  isPasswordVisible: _isPasswordVisible,
                  onTogglePassword: () {
                    setState(() => _isPasswordVisible = !_isPasswordVisible);
                  },
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (val.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 12),

                // Options Row: Remember Me & Forgot Password
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 24,
                          width: 24,
                          child: Checkbox(
                            value: _rememberMe,
                            onChanged: (val) => setState(() => _rememberMe = val ?? true),
                            activeColor: AppTheme.primaryAmber,
                            checkColor: AppTheme.bgDark,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            side: const BorderSide(color: AppTheme.textSecondaryLight, width: 1.5),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () => setState(() => _rememberMe = !_rememberMe),
                          child: const Text(
                            'Remember Me',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppTheme.textSecondaryLight,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: _handleForgotPassword,
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppTheme.primaryAmber,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Log In Action Button
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: AppTheme.primaryAmber,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: AppTheme.bgDark,
                          ),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Sign In',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.bgDark,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.login_rounded,
                              color: AppTheme.bgDark,
                              size: 20,
                            ),
                          ],
                        ),
                ),
                const SizedBox(height: 28),

                // Quick Demo Auto-Fill Card
                _buildDemoQuickFillCard(),
                const SizedBox(height: 28),

                // Sign Up Footer Navigation
                _buildRegisterFooter(),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandHeader() {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: AppTheme.primaryAmber.withOpacity(0.15),
            shape: BoxShape.circle,
            border: Border.all(
              color: AppTheme.primaryAmber.withOpacity(0.4),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.primaryAmber.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.electric_rickshaw_rounded,
            size: 40,
            color: AppTheme.primaryAmber,
          ),
        ),
        const SizedBox(height: 16),
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Union',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryLight,
                  letterSpacing: -0.5,
                ),
              ),
              TextSpan(
                text: 'Ride',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryAmber,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Welcome back! Log in to dispatch or book rides',
          style: TextStyle(
            fontSize: 14,
            color: AppTheme.textSecondaryLight,
          ),
        ),
      ],
    );
  }

  Widget _buildRoleTabs() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.surfaceDark.withOpacity(0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildRoleTabItem(
              role: AppConstants.rolePassenger,
              label: 'Passenger',
              icon: Icons.person_outline_rounded,
            ),
          ),
          Expanded(
            child: _buildRoleTabItem(
              role: AppConstants.roleDriver,
              label: 'Driver / Operator',
              icon: Icons.drive_eta_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoleTabItem({
    required String role,
    required String label,
    required IconData icon,
  }) {
    final bool isSelected = _selectedRoleView == role;

    return GestureDetector(
      onTap: () => setState(() => _selectedRoleView = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.primaryAmber : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected ? AppTheme.bgDark : AppTheme.textSecondaryLight,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppTheme.bgDark : AppTheme.textSecondaryLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDemoQuickFillCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppTheme.surfaceDark.withOpacity(0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.bolt_rounded, color: AppTheme.primaryAmber, size: 18),
              SizedBox(width: 6),
              Text(
                'Quick Test Demo Logins',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryLight,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _fillDemoCredentials(AppConstants.rolePassenger),
                  icon: const Icon(Icons.person_rounded, size: 16, color: AppTheme.primaryAmber),
                  label: const Text(
                    'Passenger',
                    style: TextStyle(fontSize: 12, color: AppTheme.textPrimaryLight),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.surfaceDark),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _fillDemoCredentials(AppConstants.roleDriver),
                  icon: const Icon(Icons.local_taxi_rounded, size: 16, color: AppTheme.primaryAmber),
                  label: const Text(
                    'Driver',
                    style: TextStyle(fontSize: 12, color: AppTheme.textPrimaryLight),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.surfaceDark),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: AppTheme.textSecondaryLight, fontSize: 14),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed('/register');
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: AppTheme.primaryAmber,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

// Helper class for app route name references
class AppRoutesNames {
  static const String passengerHome = '/passenger-home';
  static const String driverDashboard = '/driver-dashboard';
}