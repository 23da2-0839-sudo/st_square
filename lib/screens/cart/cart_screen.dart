import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/cart_model.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            floating: true,
            pinned: true,
            backgroundColor: AppColors.background.withAlpha(200),
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              'ST SQUARE',
              style: AppTextStyles.headline.copyWith(
                fontSize: 20,
                fontStyle: FontStyle.italic,
                color: const Color(0xFFE6C364),
                letterSpacing: 2.0,
              ),
            ),
            centerTitle: true,
          ),

          // Title
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Column(
                children: [
                  Text(
                    'My Cart',
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.w300,
                      color: AppColors.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Container(width: 48, height: 1, color: AppColors.primary.withAlpha(128)),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          // Empty state
          if (cart.cartItems.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.shopping_bag_outlined, size: 64, color: AppColors.onSurfaceVariant.withAlpha(100)),
                    const SizedBox(height: 16),
                    Text('Your cart is empty', style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/product-listing'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text('EXPLORE COLLECTION', style: AppTextStyles.label.copyWith(fontSize: 11, color: AppColors.primary)),
                      ),
                    )
                  ],
                ),
              ),
            )
          else ...[
            // Cart Items
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) => _buildCartItem(context, cart.cartItems[index], cart),
                childCount: cart.cartItems.length,
              ),
            ),

            // Summary
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 8),
                child: Column(
                  children: [
                    Divider(color: AppColors.outlineVariant.withAlpha(50)),
                    const SizedBox(height: 24),
                    _summaryRow('Subtotal', '\$${cart.cartTotal.toStringAsFixed(2)}'),
                    const SizedBox(height: 12),
                    _summaryRow('Delivery', 'Free'),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Total', style: AppTextStyles.headline.copyWith(fontSize: 24, color: AppColors.onSurface)),
                        Text(
                          '\$${cart.cartTotal.toStringAsFixed(2)}',
                          style: AppTextStyles.label.copyWith(fontSize: 28, color: AppColors.primary, fontWeight: FontWeight.bold, letterSpacing: 0),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Checkout Button
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, '/checkout'),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFE6C364), Color(0xFFC9A84C)],
                          ),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [BoxShadow(color: AppColors.primary.withAlpha(38), blurRadius: 30, offset: const Offset(0, 8))],
                        ),
                        child: Text(
                          'PROCEED TO CHECKOUT',
                          textAlign: TextAlign.center,
                          style: AppTextStyles.label.copyWith(
                            color: const Color(0xFF241A00),
                            fontSize: 13,
                            letterSpacing: 2.0,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'SECURE CHECKOUT POWERED BY ST SQUARE',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.label.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant.withAlpha(128)),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, CartModel item, CartProvider cart) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 96,
              height: 128,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(color: AppColors.surfaceContainerLow),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(item.name, style: AppTextStyles.headline.copyWith(fontSize: 17, height: 1.2)),
                    ),
                    Text(
                      '\$${(item.price * item.quantity).toStringAsFixed(2)}',
                      style: AppTextStyles.label.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold, letterSpacing: 0),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Size: ${item.size}', style: AppTextStyles.label.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant.withAlpha(180), letterSpacing: 1.5)),
                const SizedBox(height: 20),
                Row(
                  children: [
                    // Quantity control
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: AppColors.outlineVariant.withAlpha(25)),
                      ),
                      child: Row(children: [
                        _qtyBtn(Icons.remove, () => cart.updateQuantity(item.productId, item.quantity - 1)),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('${item.quantity}', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600)),
                        ),
                        _qtyBtn(Icons.add, () => cart.updateQuantity(item.productId, item.quantity + 1)),
                      ]),
                    ),
                    const SizedBox(width: 16),
                    GestureDetector(
                      onTap: () => cart.removeFromCart(item.productId),
                      child: Icon(Icons.delete_outline, color: AppColors.onSurfaceVariant.withAlpha(100), size: 22),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _qtyBtn(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(padding: const EdgeInsets.all(8), child: Icon(icon, size: 16, color: AppColors.primary)),
    );
  }

  Widget _summaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label.toUpperCase(), style: AppTextStyles.label.copyWith(fontSize: 12, color: AppColors.onSurfaceVariant, letterSpacing: 2.0)),
        Text(value, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
