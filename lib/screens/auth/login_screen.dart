import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../providers/auth_provider.dart';
import '../../widgets/common/custom_button.dart';
import '../../widgets/common/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  @override
  void dispose() {
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final auth = context.read<AuthProvider>();
    final error = await auth.login(
      _emailCtrl.text.trim(),
      _passwordCtrl.text,
    );
    if (!mounted) return;
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.red.shade800,
        behavior: SnackBarBehavior.floating,
      ));
    } else {
      Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface, // Extracted from #131313
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Atmospheric Element
          ColorFiltered(
            colorFilter: const ColorFilter.matrix([
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0.2126, 0.7152, 0.0722, 0, 0,
              0,      0,      0,      0.2, 0, // opacity 20%
            ]),
            child: Image.network(
              'https://images.unsplash.com/photo-1618244972963-dbee1a7edc95?q=80&w=2000',
              fit: BoxFit.cover,
            ),
          ),
          
          // Editorial Overlay (Gradient from black to black transparent)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0x66131313), // 0.4
                  Color(0xF2131313), // 0.95
                ],
              ),
            ),
          ),

          // Glassmorphic Global Context
          Positioned(
            top: 48,
            left: 32,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow.withAlpha(100),
                border: Border.all(color: AppColors.outlineVariant.withAlpha(25)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.lock_open, color: AppColors.primary, size: 14),
                  const SizedBox(width: 12),
                  Text(
                    'SECURE ENTRY',
                    style: AppTextStyles.label.copyWith(
                      fontSize: 10,
                      color: AppColors.onSurfaceVariant,
                      letterSpacing: 0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Text(
                      'ST SQUARE',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.headline.copyWith(
                        fontSize: 36,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 8.0, // 0.25em tracking
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'PRIVATE ATELIER ACCESS',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.label.copyWith(
                        fontSize: 12,
                        letterSpacing: 4.0,
                        color: AppColors.onSurfaceVariant.withAlpha(153),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Form Section
                    CustomTextField(
                      label: 'Email Address',
                      placeholder: 'atelier@stsquare.com',
                      controller: _emailCtrl,
                    ),
                    const SizedBox(height: 24),
                    CustomTextField(
                      label: 'Security Key',
                      placeholder: '••••••••',
                      isPassword: true,
                      controller: _passwordCtrl,
                      trailing: GestureDetector(
                        onTap: () {},
                        child: Text(
                          'FORGOT?',
                          style: AppTextStyles.label.copyWith(
                            fontSize: 10,
                            letterSpacing: 2.0,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),

                    // Actions
                    CustomButton(
                      text: 'Login',
                      onPressed: _handleLogin,
                    ),

                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: AppTextStyles.label.copyWith(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant.withAlpha(153),
                            letterSpacing: 1.0,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(bottom: BorderSide(color: AppColors.outlineVariant.withAlpha(76))),
                            ),
                            child: Text(
                              'Register',
                              style: AppTextStyles.label.copyWith(
                                fontSize: 12,
                                color: AppColors.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 96),

                    // Decorative Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: 32, height: 1, color: AppColors.outlineVariant.withAlpha(50)),
                        const SizedBox(width: 16),
                        const Icon(Icons.diamond, color: AppColors.primary, size: 18),
                        const SizedBox(width: 16),
                        Container(width: 32, height: 1, color: AppColors.outlineVariant.withAlpha(50)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'ESTABLISHED MMXXIV • GENEVA',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.label.copyWith(
                        fontSize: 9,
                        letterSpacing: 3.0,
                        color: AppColors.onSurfaceVariant.withAlpha(100),
                      ),
                    ),
                    const SizedBox(height: 24),
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
