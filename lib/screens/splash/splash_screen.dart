import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../providers/auth_provider.dart' as app;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuth();
  }

  void _checkAuth() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final auth = context.read<app.AuthProvider>();
      auth.setUser(auth.authService.currentUser);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfaceDarker,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background Texture Subtle Layer (simulated via radial gradient)
          Opacity(
            opacity: 0.1,
            child: Container(
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  colors: [
                    Color(0xFF2A2A2A),
                    Colors.transparent,
                  ],
                  radius: 0.7,
                ),
              ),
            ),
          ),
          
          // Decorative Elements
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 384,
              height: 384,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(12),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withAlpha(12), blurRadius: 120),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: -100,
            left: -100,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                color: AppColors.primary.withAlpha(12),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(color: AppColors.primary.withAlpha(12), blurRadius: 100),
                ],
              ),
            ),
          ),

          // Central Branding Cluster
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Abstract Logo Mark
                SizedBox(
                  width: 96,
                  height: 96,
                  child: Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // Inner Glow
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primary.withAlpha(12),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: AppColors.primary.withAlpha(12), blurRadius: 30),
                          ],
                        ),
                      ),
                      // ST Square Main Visual Anchor
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          color: AppColors.onPrimary,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.outlineVariant.withAlpha(76), width: 0.5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black26, 
                              blurRadius: 24, 
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'ST',
                          style: AppTextStyles.display.copyWith(
                            fontSize: 48,
                            color: AppColors.primary,
                            fontStyle: FontStyle.italic,
                            letterSpacing: -2,
                            height: 1,
                          ),
                        ),
                      ),
                      // Small golden square shadow anchor
                      Positioned(
                        bottom: -4,
                        right: -4,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFE6C364).withAlpha(100),
                                blurRadius: 15,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),
                // Typography Brand Name
                Text(
                  'ST SQUARE',
                  style: AppTextStyles.display.copyWith(
                    fontSize: 36,
                    color: AppColors.primary,
                    fontStyle: FontStyle.italic,
                    letterSpacing: 6.0,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Style. Tailored for You.',
                  style: AppTextStyles.headline.copyWith(
                    fontSize: 18,
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 2.0,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),

          // Loading/Interaction Hint
          Positioned(
            left: 0,
            right: 0,
            bottom: 96,
            child: Column(
              children: [
                // Luxury Gold Line Indicator
                Container(
                  width: 192,
                  height: 1,
                  color: AppColors.outlineVariant.withAlpha(50),
                  child: Stack(
                    children: [
                      Container(
                        width: 64,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.transparent, AppColors.primary, Colors.transparent],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Minimalist Button
                GestureDetector(
                  onTap: () {
                    final user = FirebaseAuth.instance.currentUser;
                    if (user != null) {
                      Navigator.pushReplacementNamed(context, '/home');
                    } else {
                      Navigator.pushNamed(context, '/onboarding');
                    }
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: AppColors.primary.withAlpha(76))),
                        ),
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(
                          'ENTER ATELIER',
                          style: AppTextStyles.label.copyWith(
                            fontSize: 10,
                            letterSpacing: 4.0,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.arrow_forward, size: 14, color: AppColors.primary),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Footer
          Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            child: Text(
              'EST. MMXXIV • PRIVATE ACCESS',
              textAlign: TextAlign.center,
              style: AppTextStyles.label.copyWith(
                fontSize: 10,
                color: AppColors.onSurfaceVariant.withAlpha(76),
                letterSpacing: 5.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
