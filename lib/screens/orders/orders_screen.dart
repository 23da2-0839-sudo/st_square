import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../providers/order_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = context.watch<OrderProvider>().orders;

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
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Column(
                children: [
                  Text('My Orders', style: AppTextStyles.headline.copyWith(fontSize: 36, fontWeight: FontWeight.w300, color: AppColors.onSurface), textAlign: TextAlign.center),
                  const SizedBox(height: 12),
                  Container(width: 48, height: 1, color: AppColors.primary.withAlpha(128)),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
          if (orders.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.receipt_long_outlined, size: 64, color: AppColors.onSurfaceVariant.withAlpha(100)),
                    const SizedBox(height: 16),
                    Text('No orders yet', style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/product-listing'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(border: Border.all(color: AppColors.primary), borderRadius: BorderRadius.circular(8)),
                        child: Text('START SHOPPING', style: AppTextStyles.label.copyWith(fontSize: 11, color: AppColors.primary)),
                      ),
                    )
                  ],
                ),
              ),
            )
          else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final order = orders[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerLow,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(order.orderId, style: AppTextStyles.headline.copyWith(fontSize: 16, color: AppColors.onBackground)),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withAlpha(25),
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(color: AppColors.primary.withAlpha(76)),
                                ),
                                child: Text(order.status.toUpperCase(), style: AppTextStyles.label.copyWith(fontSize: 10, color: AppColors.primary, letterSpacing: 1.5)),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text('${order.items.length} item(s)', style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant)),
                          const SizedBox(height: 4),
                          Text(order.deliveryAddress, style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('${order.createdAt.day}/${order.createdAt.month}/${order.createdAt.year}', style: AppTextStyles.label.copyWith(fontSize: 11, color: AppColors.onSurfaceVariant.withAlpha(180), letterSpacing: 1)),
                              Text('\$${order.total.toStringAsFixed(2)}', style: AppTextStyles.label.copyWith(fontSize: 16, color: AppColors.primary, letterSpacing: 0, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: orders.length,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
