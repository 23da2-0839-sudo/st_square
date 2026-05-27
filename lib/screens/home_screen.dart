import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    const bgColor = Color(0xFF131313);
    const textColor = Color(0xFFF5F5F0);

    return Scaffold(
      backgroundColor: bgColor,
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: bgColor.withOpacity(0.7),
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: bgColor.withOpacity(0.7),
          ),
          // Blur effect omitted for simplicity, can use BackdropFilter if needed
        ),
        title: Row(
          children: [
            Icon(Icons.menu, color: colorScheme.primaryContainer),
            const SizedBox(width: 16),
            Text(
              'ST SQUARE',
              style: theme.textTheme.titleLarge?.copyWith(
                fontStyle: FontStyle.italic,
                letterSpacing: 4.0,
                color: colorScheme.inversePrimary,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search, color: textColor.withOpacity(0.6)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.shopping_bag_outlined, color: textColor.withOpacity(0.6)),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 100), // Top padding for AppBar
            
            // Welcome Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'WELCOME BACK',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary.withOpacity(0.8),
                      letterSpacing: 2.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Hello, User',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            // Hero Banner
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: AspectRatio(
                aspectRatio: 4 / 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            Colors.grey.withOpacity(0.2), // Grayscale effect
                            BlendMode.saturation,
                          ),
                          child: Image.network(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuDdB36zRCTYlmV91gJHK57e4_iDR1uO8KbJpNnWYZ7YQZnh5wjF1X8llocAegPO8w792EXUhedt4zbVMvymnS3OaUPWMIxy8m19a_Fy_-OIePAxe7GXGkJ43hG-djtc3X6xWGdjnnSAmsFTnRFPber9Me9Ypj8eZkOUJiW4sxZxWCpyL3Nu_d7HRbI0ngHIN17xlvTB8F9iVPONvTq95RENyOOr6b8KtjVIuj_gEBfJYFPFk9pP1znQsYNOXEjZFDkAV6BXBTQwwZE',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                Colors.white.withOpacity(0.8),
                                Colors.transparent,
                                Colors.transparent,
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 32,
                        left: 32,
                        right: 32,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'The Winter',
                              style: theme.textTheme.displayMedium?.copyWith(
                                color: colorScheme.onSurface,
                                height: 1.0,
                              ),
                            ),
                            Text(
                              'Atelier',
                              style: theme.textTheme.displayMedium?.copyWith(
                                color: colorScheme.primary,
                                fontStyle: FontStyle.italic,
                                height: 1.0,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Curated pieces from the Midnight Collection, designed for the quiet moments of elegance.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Container(
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                gradient: LinearGradient(
                                  colors: [
                                    colorScheme.primary,
                                    colorScheme.primaryContainer,
                                  ],
                                ),
                              ),
                              child: MaterialButton(
                                onPressed: () {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  'EXPLORE NOW',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 48),
            
            // Category Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  _buildChip('All', true, colorScheme),
                  const SizedBox(width: 12),
                  _buildChip('Men', false, colorScheme),
                  const SizedBox(width: 12),
                  _buildChip('Women', false, colorScheme),
                  const SizedBox(width: 12),
                  _buildChip('Accessories', false, colorScheme),
                  const SizedBox(width: 12),
                  _buildChip('Limited', false, colorScheme),
                ],
              ),
            ),
            const SizedBox(height: 48),
            
            // New Arrivals
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Arrivals',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontStyle: FontStyle.italic,
                          color: textColor,
                        ),
                      ),
                      Container(
                        width: 48,
                        height: 1,
                        color: colorScheme.primary,
                        margin: const EdgeInsets.only(top: 8.0),
                      ),
                    ],
                  ),
                  Text(
                    'VIEW ALL',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: colorScheme.primary,
                      letterSpacing: 2.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                children: [
                  _buildProductCard(
                    theme, colorScheme, textColor,
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuDmlv22CIQIECXrs21ZGjYTivnXT77Kl5qpPvcJA09c-RExDYwm76Zqig3X58ggqJUzkrzc2BosXeGOI9zwZ4E3mcFFEFpTL2yj8HBRD3fQTLHEwu35SvxQ76jgvbnoCD1c5se_CRlLqQuvFPEzH713psqot6SkkAV-Oa_Dob0LvAWTVQBIqBxFrPi8ecsrkUi5UOsfdctKu2_3D6uUP4ntVEy_zdJVatkxNjvK80kciEgsPJN3dWFBiV2n4fwELQaFF-7mRQzhiWY',
                    'Sculpted Wool Coat',
                    'Midnight Black',
                    '\$890',
                  ),
                  const SizedBox(width: 24),
                  _buildProductCard(
                    theme, colorScheme, textColor,
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAETNTOtfQGiLx6bwkX-K-J1pUVpR93hmpccbPrV5zmuNwanCqLU1hfGh_Q6AF78ULXZrcotud0oHmculCsK96WHgBRGoy8kGg1r6V-Am1qr_UhGmPQ-oz10qYlMIh3iYVUFau1QM3gx8meQEvhbv52dKFtnbD_RMDO8AOBPHsgJSs2bfOy1d1brtVZjZepoUw1kqNBse_W--_959PqYnoM5NszgbROcFIQCZ0H3YkvJnAetgF12df8KiP_QrM9pTC0K6JUBrqrIco',
                    'Tapered Leather Boot',
                    'Calfskin Edition',
                    '\$1,250',
                  ),
                  const SizedBox(width: 24),
                  _buildProductCard(
                    theme, colorScheme, textColor,
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuCAftFLF-kXFu_d4xH1l0lihHsmoEvKB6msa6rbknhq-vNQ-HeEC8omag9TVGXGmU1WIuHEGeAjAhCiJxxQ6wxZtAGqOTjJTi3HeJEVpfLW_vgnoRcS5LcHYAm7nnmZ0A0bGRHz56wsjLLai8tULg2Lw9g6oxTjZjjntsOweqlWUt4Jy3tXixbKMgfEExILOjfsPqiZsgVryVFGWM0hq4z89GSRGVwkdpCPDqyOuwcjxPjMI6cskwZ0SaTMOHrK0VmmWJoKaIQ7deg',
                    'Emerald Silk Slip',
                    'Pure Mulberry Silk',
                    '\$640',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 120), // Bottom padding for nav bar
          ],
        ),
      ),
      bottomNavigationBar: Container(
        color: bgColor.withOpacity(0.9),
        padding: const EdgeInsets.only(bottom: 24, top: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(Icons.home, 'Home', true, theme, colorScheme),
            _buildNavItem(Icons.search, 'Search', false, theme, colorScheme),
            _buildNavItem(Icons.shopping_cart_outlined, 'Cart', false, theme, colorScheme),
            _buildNavItem(Icons.receipt_long, 'Orders', false, theme, colorScheme),
            _buildNavItem(Icons.person_outline, 'Profile', false, theme, colorScheme),
          ],
        ),
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected, ColorScheme colorScheme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: isSelected ? colorScheme.primary : const Color(0xFFEBE7E7).withOpacity(0.1),
        borderRadius: BorderRadius.circular(24.0),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          color: isSelected ? colorScheme.onPrimary : Colors.white54,
          fontSize: 12,
          letterSpacing: 1.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildProductCard(
    ThemeData theme, ColorScheme colorScheme, Color textColor,
    String imageUrl, String title, String subtitle, String price) {
    
    return SizedBox(
      width: 280,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withOpacity(0.4),
                      child: const Icon(Icons.favorite_border, color: Colors.white, size: 20),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: textColor,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            price,
            style: theme.textTheme.titleMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, ThemeData theme, ColorScheme colorScheme) {
    final color = isSelected ? colorScheme.inversePrimary : Colors.white24;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: theme.textTheme.labelSmall?.copyWith(
            color: color,
            fontSize: 10,
            letterSpacing: 1.0,
          ),
        ),
      ],
    );
  }
}
