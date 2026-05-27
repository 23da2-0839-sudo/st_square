import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/product_model.dart';
import '../../providers/product_provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final products = context.watch<ProductProvider>().products;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Content
          CustomScrollView(
            slivers: [
              // Spacing for Top App Bar
              const SliverToBoxAdapter(child: SizedBox(height: 80)),
              
              // Search Section
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                sliver: SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
                      border: Border(bottom: BorderSide(color: AppColors.primary.withAlpha(76), width: 2)),
                    ),
                    child: TextField(
                      style: AppTextStyles.body.copyWith(color: AppColors.onSurface, letterSpacing: 1.0),
                      decoration: InputDecoration(
                        hintText: 'Search our collection...',
                        hintStyle: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant.withAlpha(100)),
                        prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                  ),
                ),
              ),

              // Filter Chips
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 40,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    children: [
                      _buildChip('All Pieces', true),
                      const SizedBox(width: 12),
                      _buildChip('New Arrivals', false),
                      const SizedBox(width: 12),
                      _buildChip('Atelier Selection', false),
                      const SizedBox(width: 12),
                      _buildChip('Bespoke', false),
                      const SizedBox(width: 12),
                      _buildChip('Limited', false),
                    ],
                  ),
                ),
              ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),

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

          // Top App Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.background.withAlpha(179),
              ),
              child: SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.menu, color: AppColors.primaryContainer),
                      Text(
                        'ST SQUARE',
                        style: AppTextStyles.headline.copyWith(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                          color: const Color(0xFFE6C364),
                          letterSpacing: 2.0,
                        ),
                      ),
                      const Icon(Icons.shopping_bag, color: AppColors.primaryContainer),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(24),
        border: isSelected ? null : Border.all(color: AppColors.outlineVariant.withAlpha(25)),
        boxShadow: isSelected
            ? [
                BoxShadow(
                  color: AppColors.primaryContainer.withAlpha(50),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ]
            : null,
      ),
      child: Text(
        label.toUpperCase(),
        style: AppTextStyles.label.copyWith(
          fontSize: 10,
          fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
          color: isSelected ? AppColors.onPrimary : AppColors.onSurfaceVariant,
          letterSpacing: 2.0,
        ),
      ),
    );
  }

  Widget _buildGridProduct(BuildContext context, ProductModel product, double marginTop) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, '/product-detail', arguments: product.id),
      child: Padding(
        padding: EdgeInsets.only(top: marginTop > 0 ? marginTop : 0, bottom: marginTop < 0 ? -marginTop : 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
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
                  : Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.surfaceContainerLow,
                      ),
                    ),
            ),
            const SizedBox(height: 12),
            Text(
              product.name,
              style: AppTextStyles.headline.copyWith(
                fontSize: 16,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '\$${product.price.toStringAsFixed(0)}',
              style: AppTextStyles.body.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 14,
                letterSpacing: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
