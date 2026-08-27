import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController =
      TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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

                    // =========================
                    // BACK BUTTON
                    // =========================
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
                          size: 25,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.06),

                    // =========================
                    // LOGO
                    // =========================
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

                    // =========================
                    // ICON
                    // =========================
                    Center(
                      child: Container(
                        width: 78,
                        height: 78,
                        decoration: BoxDecoration(
                          color: const Color(0xFF0C0D0F),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF303238),
                            width: 1.2,
                          ),
                        ),
                        child: const Icon(
                          Icons.lock_reset_rounded,
                          color: Colors.white,
                          size: 36,
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.04),

                    // =========================
                    // TITLE
                    // =========================
                    const Center(
                      child: Text(
                        'Forgot password?',
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Don't worry. Enter your email address and we'll send you a link to reset your password.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFA7A7AE),
                            fontSize: 17,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.065),

                    // =========================
                    // EMAIL LABEL
                    // =========================
                    const Text(
                      'Email address',
                      style: TextStyle(
                        color: Color(0xFFD7D7DB),
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // =========================
                    // EMAIL FIELD
                    // =========================
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        hintStyle: const TextStyle(
                          color: Color(0xFF777980),
                          fontSize: 17,
                        ),
                        prefixIcon: const Icon(
                          Icons.email_outlined,
                          color: Color(0xFFB6B6BD),
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

                    SizedBox(height: height * 0.045),

                    // =========================
                    // SEND RESET LINK BUTTON
                    // =========================
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
                              'Send Reset Link',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(width: 14),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 25,
                            ),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: height * 0.045),

                    // =========================
                    // BACK TO LOGIN
                    // =========================
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.arrow_back_rounded,
                              color: Color(0xFFA7A7AE),
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Back to Sign In',
                              style: TextStyle(
                                color: Color(0xFFD7D7DB),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
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