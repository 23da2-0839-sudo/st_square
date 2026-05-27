import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: AppColors.background.withAlpha(200),
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text('ST SQUARE', style: AppTextStyles.headline.copyWith(fontSize: 20, fontStyle: FontStyle.italic, color: const Color(0xFFE6C364), letterSpacing: 2.0)),
            centerTitle: true,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 100,
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: [Color(0xFFE6C364), Color(0xFFC9A84C)]),
                    ),
                    child: Center(
                      child: Text(
                        (user?.name.isNotEmpty == true) ? user!.name[0].toUpperCase() : 'G',
                        style: AppTextStyles.headline.copyWith(fontSize: 40, color: const Color(0xFF241A00)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(user?.name ?? 'Guest', style: AppTextStyles.headline.copyWith(fontSize: 24, color: AppColors.onSurface)),
                  const SizedBox(height: 4),
                  Text(user?.email ?? '', style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 40),

                  // Menu Items
                  _menuItem(context, Icons.person_outline, 'Edit Profile', () {}),
                  _menuItem(context, Icons.receipt_long_outlined, 'My Orders', () {}),
                  _menuItem(context, Icons.favorite_border, 'Wishlist', () {}),
                  _menuItem(context, Icons.location_on_outlined, 'Saved Addresses', () {}),
                  _menuItem(context, Icons.notifications_outlined, 'Notifications', () {}),
                  _menuItem(context, Icons.help_outline, 'Help & Contact', () {}),

                  const SizedBox(height: 24),
                  Divider(color: AppColors.outlineVariant.withAlpha(50)),
                  const SizedBox(height: 24),

                  // Logout
                  GestureDetector(
                    onTap: () async {
                      await context.read<AuthProvider>().logout();
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(context, '/login', (r) => false);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.error.withAlpha(100)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.logout, color: AppColors.error.withAlpha(200), size: 20),
                          const SizedBox(width: 8),
                          Text('LOGOUT', style: AppTextStyles.label.copyWith(fontSize: 13, color: AppColors.error.withAlpha(200), letterSpacing: 2)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _menuItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primaryContainer, size: 22),
            const SizedBox(width: 16),
            Expanded(child: Text(label, style: AppTextStyles.body.copyWith(color: AppColors.onSurface))),
            Icon(Icons.chevron_right, color: AppColors.onSurfaceVariant.withAlpha(128), size: 20),
          ],
        ),
      ),
    );
  }
}
