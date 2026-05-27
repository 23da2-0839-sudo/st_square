import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    // Explicit colors based on the design
    const bgColor = Color(0xFF131313);
    const textColor = Color(0xFFE5E2E1);
    const inputBgColor = Color(0xFF1A1A1A);
    const mutedTextColor = Colors.white54;
    
    return Scaffold(
      backgroundColor: bgColor,
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Opacity(
              opacity: 0.2, // 20% opacity
              child: ColorFiltered(
                colorFilter: const ColorFilter.matrix([
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0.2126, 0.7152, 0.0722, 0, 0,
                  0,      0,      0,      1, 0,
                ]), // Grayscale filter
                child: Image.network(
                  'https://images.unsplash.com/photo-1549497538-301228c965dd?q=80&w=2000',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          // Gradient Overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    const Color(0xFF131313).withOpacity(0.4),
                    const Color(0xFF131313).withOpacity(0.95),
                  ],
                ),
              ),
            ),
          ),
          // Main Content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header
                    Text(
                      'ST SQUARE',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: colorScheme.primary,
                        fontStyle: FontStyle.italic,
                        letterSpacing: 4.0,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'PRIVATE ATELIER ACCESS',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: mutedTextColor,
                        letterSpacing: 4.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 64),
                    
                    // Email Field
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, bottom: 8.0),
                      child: Text(
                        'EMAIL ADDRESS',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: mutedTextColor,
                          letterSpacing: 2.0,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _emailController,
                      style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: 'atelier@stsquare.com',
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.white30),
                        filled: true,
                        fillColor: inputBgColor,
                        contentPadding: const EdgeInsets.all(16.0),
                        border: const UnderlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    
                    // Password Field
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SECURITY KEY',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: mutedTextColor,
                              letterSpacing: 2.0,
                              fontSize: 10,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              'FORGOT?',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: mutedTextColor,
                                letterSpacing: 2.0,
                                fontSize: 10,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextField(
                      controller: _passwordController,
                      style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '••••••••',
                        hintStyle: theme.textTheme.bodyMedium?.copyWith(color: Colors.white30),
                        filled: true,
                        fillColor: inputBgColor,
                        contentPadding: const EdgeInsets.all(16.0),
                        border: const UnderlineInputBorder(borderSide: BorderSide.none),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: colorScheme.primary),
                        ),
                      ),
                    ),
                    const SizedBox(height: 48),
                    
                    // Login Button
                    Container(
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            colorScheme.primaryContainer,
                            colorScheme.primary,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          )
                        ],
                      ),
                      child: MaterialButton(
                        onPressed: () {
                          // Bypass login for prototype
                          Navigator.pushReplacementNamed(context, '/home');
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'LOGIN',
                          style: theme.textTheme.labelLarge?.copyWith(
                            letterSpacing: 3.0,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    
                    // Register Link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account? ",
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: mutedTextColor,
                            letterSpacing: 1.0,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.white30),
                              ),
                            ),
                            child: Text(
                              'Register',
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: textColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 64),
                    
                    // Footer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(height: 1, width: 32, color: Colors.white24),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Icon(Icons.diamond_outlined, color: colorScheme.primary, size: 18),
                        ),
                        Container(height: 1, width: 32, color: Colors.white24),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'ESTABLISHED MMXXIV • GENEVA',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white24,
                        letterSpacing: 3.0,
                        fontSize: 9,
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
