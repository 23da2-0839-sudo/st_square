import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Hero Background Image
          Image.network(
            'https://images.unsplash.com/photo-1618244972963-dbee1a7edc95?q=80&w=2000',
            fit: BoxFit.cover,
          ),
          
          // Editorial Overlay Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black45,
                  Color(0xFF131313),
                ],
                stops: [0.0, 0.4, 1.0],
              ),
            ),
          ),

          // Decorative Floating Elements
          Positioned(
            top: MediaQuery.of(context).size.height * 0.3,
            left: -128,
            child: Container(
              width: 320,
              height: 320,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withAlpha(12), width: 0.5),
              ),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.5,
            right: -96,
            child: Container(
              width: 256,
              height: 256,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withAlpha(25), width: 0.5),
              ),
            ),
          ),

          // Content Box
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Brand Anchor
                  Text(
                    'ST SQUARE',
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      letterSpacing: 3.0,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Headlines
                  Text(
                    'Refined Taste',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 40,
                      color: AppColors.onSurface,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    'Redefined.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 40,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: AppColors.onSurface,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'YOUR PERSONAL GATEWAY TO THE WORLD\'S MOST EXCLUSIVE ATELIERS.',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14,
                      letterSpacing: 2.0,
                      color: AppColors.onSurface.withAlpha(153),
                    ),
                  ),
                  const SizedBox(height: 64),

                  // Actions
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE6C364), AppColors.primaryContainer],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black45,
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'GET STARTED',
                        style: AppTextStyles.label.copyWith(
                          fontSize: 14,
                          color: AppColors.onPrimary,
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Login Link
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Column(
                      children: [
                        Text(
                          'Login',
                          style: AppTextStyles.headline.copyWith(
                            fontSize: 18,
                            fontStyle: FontStyle.italic,
                            color: AppColors.onSurface.withAlpha(200),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          width: 32,
                          height: 1,
                          color: AppColors.primaryContainer,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),

                  // Semantic Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 4,
                        width: 8,
                        decoration: BoxDecoration(
                          color: AppColors.onSurface.withAlpha(50),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 4,
                        width: 8,
                        decoration: BoxDecoration(
                          color: AppColors.onSurface.withAlpha(50),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
