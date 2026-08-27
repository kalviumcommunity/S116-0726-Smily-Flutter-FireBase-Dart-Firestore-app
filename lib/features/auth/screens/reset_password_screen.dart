import 'package:flutter/material.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController =
      TextEditingController();

  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF030405),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final height = constraints.maxHeight;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.065,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: height,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: height * 0.025),

                    // BACK BUTTON
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C0D0F),
                          borderRadius: BorderRadius.circular(17),
                          border: Border.all(
                            color: const Color(0xFF303238),
                          ),
                        ),
                        child: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.06),

                    // LOGO
                    Center(
                      child: SizedBox(
                        width: width * 0.42,
                        height: height * 0.16,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.06),

                    // LOCK ICON
                    Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C0D0F),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF303238),
                          ),
                        ),
                        child: const Icon(
                          Icons.lock_outline_rounded,
                          color: Colors.white,
                          size: 38,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.04),

                    // TITLE
                    const Center(
                      child: Text(
                        'Reset password',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.8,
                        ),
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Center(
                      child: Text(
                        'Create a strong new password for your account.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFA7A7AE),
                          fontSize: 17,
                          height: 1.5,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.065),

                    // NEW PASSWORD LABEL
                    const Text(
                      'New password',
                      style: TextStyle(
                        color: Color(0xFFD7D7DB),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // NEW PASSWORD FIELD
                    TextField(
                      controller: _newPasswordController,
                      obscureText: _obscureNewPassword,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter new password',
                        hintStyle: const TextStyle(
                          color: Color(0xFF777980),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: Color(0xFFB6B6BD),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureNewPassword =
                                  !_obscureNewPassword;
                            });
                          },
                          icon: Icon(
                            _obscureNewPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFFB6B6BD),
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0C0D0F),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 21,
                          horizontal: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Color(0xFF303238),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.035),

                    // CONFIRM PASSWORD LABEL
                    const Text(
                      'Confirm password',
                      style: TextStyle(
                        color: Color(0xFFD7D7DB),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // CONFIRM PASSWORD FIELD
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Confirm new password',
                        hintStyle: const TextStyle(
                          color: Color(0xFF777980),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: Color(0xFFB6B6BD),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: const Color(0xFFB6B6BD),
                          ),
                        ),
                        filled: true,
                        fillColor: const Color(0xFF0C0D0F),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 21,
                          horizontal: 18,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Color(0xFF303238),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: const BorderSide(
                            color: Colors.white,
                            width: 1.2,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.055),

                    // RESET BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 66,
                      child: ElevatedButton(
                        onPressed: () {
                          // Password reset functionality later
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color(0xFFF1F1F3),
                          foregroundColor:
                              const Color(0xFF111214),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(18),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment:
                              MainAxisAlignment.center,
                          children: [
                            Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 14),
                            Icon(
                              Icons.arrow_forward_rounded,
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 30),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}