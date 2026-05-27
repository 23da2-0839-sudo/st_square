import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../providers/order_provider.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>();
    final latest = orders.orders.isNotEmpty ? orders.orders.last : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background.withAlpha(200),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text('ST SQUARE', style: AppTextStyles.headline.copyWith(fontSize: 20, fontStyle: FontStyle.italic, color: const Color(0xFFE6C364), letterSpacing: 2.0)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 32, 24, 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Success Icon
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary.withAlpha(30),
                  ),
                ),
                Container(
                  width: 96,
                  height: 96,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surfaceContainerLow,
                    border: Border.all(color: AppColors.primary.withAlpha(76)),
                  ),
                  child: const Icon(Icons.check_circle, color: AppColors.primary, size: 52),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Text('Order Placed!', style: AppTextStyles.headline.copyWith(fontSize: 40, color: AppColors.onBackground)),
            const SizedBox(height: 8),
            Text('THANK YOU FOR YOUR REFINED CHOICE', style: AppTextStyles.label.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant, letterSpacing: 2.0)),
            const SizedBox(height: 48),

            // Bento Details Grid
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Order Ref
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('REFERENCE', style: AppTextStyles.label.copyWith(fontSize: 10, color: AppColors.primary, letterSpacing: 2.0)),
                        const SizedBox(height: 8),
                        Text(latest?.orderId ?? '#ST-0000000', style: AppTextStyles.headline.copyWith(fontSize: 20, color: AppColors.onBackground)),
                        const SizedBox(height: 24),
                        Text('ESTIMATED ARRIVAL', style: AppTextStyles.label.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant, letterSpacing: 1.5)),
                        const SizedBox(height: 4),
                        Text('5 – 7 Business Days', style: AppTextStyles.body.copyWith(fontSize: 16, color: AppColors.onSurface)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Product teaser image
                Expanded(
                  child: Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.surfaceContainerLow,
                    ),
                    alignment: Alignment.bottomLeft,
                    padding: const EdgeInsets.all(16),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        if (latest != null && latest.items.isNotEmpty && latest.items.first.imageUrl.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              latest.items.first.imageUrl,
                              fit: BoxFit.cover,
                              opacity: const AlwaysStoppedAnimation(0.6),
                              errorBuilder: (_, __, ___) => Container(),
                            ),
                          ),
                        Positioned(
                          left: 16,
                          bottom: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('YOUR SELECTION', style: AppTextStyles.label.copyWith(fontSize: 9, color: Colors.white70, letterSpacing: 2.0)),
                              Text(latest?.items.first.name ?? 'Your Selection', style: AppTextStyles.headline.copyWith(fontSize: 13, color: Colors.white, fontStyle: FontStyle.italic)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Shipping row
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('DESTINATION', style: AppTextStyles.label.copyWith(fontSize: 10, color: AppColors.primary, letterSpacing: 2.0)),
                      const SizedBox(height: 8),
                      Text(latest?.deliveryAddress ?? '—', style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant, height: 1.5)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('TOTAL CHARGED', style: AppTextStyles.label.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant, letterSpacing: 1.5)),
                      Text('\$${latest?.total.toStringAsFixed(2) ?? '0.00'}', style: AppTextStyles.headline.copyWith(fontSize: 28, color: AppColors.primary)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Action buttons
            GestureDetector(
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFFE6C364), Color(0xFFC9A84C)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text('CONTINUE SHOPPING', textAlign: TextAlign.center,
                    style: AppTextStyles.label.copyWith(color: const Color(0xFF241A00), fontSize: 13, letterSpacing: 2, fontWeight: FontWeight.w800)),
              ),
            ),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: () => Navigator.pushNamedAndRemoveUntil(context, '/home', (r) => false),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 18),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.outlineVariant.withAlpha(76)),
                ),
                child: Text('VIEW ALL ORDERS', textAlign: TextAlign.center,
                    style: AppTextStyles.label.copyWith(color: AppColors.onBackground, fontSize: 13, letterSpacing: 2, fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
