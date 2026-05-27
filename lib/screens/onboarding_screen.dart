import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuBrZlxIdl034sC3eq8_cHZSN4T7VXBJrcbvICEqLMgWaCibfY5AaMNhkQEA3A3jAcgKje4T8M7xJDchvV2cJbC_KWmqRFh_fl2WfgGbM3Hlp9druXvlj9yAg9uAuvF_k_TH1PhjBKxQ088uXwINHLc9g_Ez5sy95RXXWThniFk97UMkRKJfecxGh65UAuPqcZ7AV0jgYFLzIBtZNgDn9g9Opbe-nIyNNUWRqxePaa6dQgfO3d7CtfOYO_mJGDI1rxZYMNGZ0kJDRlQ',
              fit: BoxFit.cover,
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    const Color(0xFF131313).withOpacity(1.0),
                    const Color(0xFF131313).withOpacity(0.6),
                    const Color(0xFF131313).withOpacity(0.0),
                  ],
                  stops: const [0.0, 0.4, 1.0],
                ),
              ),
            ),
          ),
          // Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 48.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Brand Anchor
                  Text(
                    'ST SQUARE',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      letterSpacing: 4.0,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Headlines
                  Text(
                    'Refined Taste\nRedefined.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                  
                  SizedBox(
                    width: 280,
                    child: Text(
                      "YOUR PERSONAL GATEWAY TO THE WORLD'S MOST EXCLUSIVE ATELIERS.",
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        letterSpacing: 2.0,
                        color: Colors.white60,
                      ),
                    ),
                  ),
                  const SizedBox(height: 64),
                  
                  // Action Cluster
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colorScheme.inversePrimary,
                            colorScheme.primaryContainer,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 4),
                            blurRadius: 10.0,
                          ),
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'GET STARTED',
                          style: theme.textTheme.labelLarge?.copyWith(
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Secondary Link
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Column(
                      children: [
                        Text(
                          'Login',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          height: 1,
                          width: 32,
                          color: colorScheme.primaryContainer,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 48),
                  
                  // Page Indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 4,
                        width: 32,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 4,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        height: 4,
                        width: 8,
                        decoration: BoxDecoration(
                          color: Colors.white24,
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
