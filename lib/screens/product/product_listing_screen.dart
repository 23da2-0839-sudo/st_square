import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/product_model.dart';
import '../../providers/product_provider.dart';

class ProductListingScreen extends StatelessWidget {
  const ProductListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Top App Bar
          SliverAppBar(
            backgroundColor: AppColors.background.withAlpha(200),
            floating: true,
            pinned: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: AppColors.onSurface.withAlpha(153)),
              onPressed: () => Navigator.pop(context),
            ),
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
            actions: [
              IconButton(
                icon: Icon(Icons.shopping_bag, color: AppColors.onSurface.withAlpha(153)),
                onPressed: () {},
              ),
            ],
          ),

          // Category Header
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Curated Essentials',
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 32,
                      color: AppColors.onSurface,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Refined selections for the modern atelier.',
                    style: AppTextStyles.body.copyWith(
                      fontSize: 14,
                      color: AppColors.onSurfaceVariant.withAlpha(153),
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Filter / Sort Bar
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildActionButton(Icons.tune, 'Filter'),
                      const SizedBox(width: 8),
                      _buildActionButton(Icons.expand_more, 'Sort', isTrailingIcon: true),
                    ],
                  ),
                  Text(
                    '${products.length} PRODUCTS',
                    style: AppTextStyles.label.copyWith(
                      fontSize: 10,
                      color: AppColors.onSurfaceVariant.withAlpha(100),
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 16)),

          // Product Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.55,
                crossAxisSpacing: 16,
                mainAxisSpacing: 32,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = products[index];
                  return _buildGridProduct(
                    context,
                    product,
                    (index % 3) * 16 - 16,
                  );
                },
                childCount: products.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label, {bool isTrailingIcon = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.outlineVariant.withAlpha(38)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isTrailingIcon) ...[
            Icon(icon, size: 16, color: AppColors.onSurface),
            const SizedBox(width: 8),
          ],
          Text(
            label.toUpperCase(),
            style: AppTextStyles.label.copyWith(
              fontSize: 10,
              color: AppColors.onSurface,
            ),
          ),
          if (isTrailingIcon) ...[
            const SizedBox(width: 8),
            Icon(icon, size: 16, color: AppColors.onSurface),
          ],
        ],
      ),
    );
  }

  Widget _buildGridProduct(BuildContext context, ProductModel product, double marginTop) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product-detail', arguments: product.id);
      },
      child: Padding(
        padding: EdgeInsets.only(top: marginTop > 0 ? marginTop : 0, bottom: marginTop < 0 ? -marginTop : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.surfaceContainerLow,
                    ),
                    child: product.images.isNotEmpty && product.images.first.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              product.images.first,
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (_, __, ___) => Container(color: AppColors.surfaceContainerLow),
                            ),
                          )
                        : Container(color: AppColors.surfaceContainerLow),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.background.withAlpha(100),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.favorite_border, size: 16, color: AppColors.onSurface),
                    ),
                  ),
                  if (product.isFeatured)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [AppColors.background.withAlpha(200), Colors.transparent],
                          ),
                          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
                        ),
                        child: Text(
                          'FEATURED',
                          style: AppTextStyles.label.copyWith(
                            fontSize: 10,
                            color: AppColors.primary,
                            letterSpacing: 2.0,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'ST SQUARE',
              style: AppTextStyles.label.copyWith(
                fontSize: 10,
                color: AppColors.onSurfaceVariant.withAlpha(128),
                letterSpacing: 2.0,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              product.name,
              style: AppTextStyles.headline.copyWith(
                fontSize: 18,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${product.price.toStringAsFixed(2)}',
              style: AppTextStyles.label.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 12,
                letterSpacing: 0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
