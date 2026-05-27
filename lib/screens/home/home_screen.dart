import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/product_model.dart';
import '../../providers/product_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productProvider = context.watch<ProductProvider>();
    final featuredProducts = productProvider.products.where((p) => p.isFeatured).toList();

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
              icon: const Icon(Icons.menu, color: AppColors.primaryContainer),
              onPressed: () {},
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
                icon: const Icon(Icons.shopping_bag, color: AppColors.primaryContainer),
                onPressed: () => Navigator.pushNamed(context, '/product-listing'),
              ),
            ],
          ),

          // Hero Section
          SliverToBoxAdapter(
            child: Container(
              height: 480,
              margin: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: AppColors.surfaceContainerLow,
              ),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                children: [
                  if (featuredProducts.isNotEmpty && featuredProducts.first.images.isNotEmpty)
                    Image.network(
                      featuredProducts.first.images.first,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                      errorBuilder: (_, __, ___) => Container(color: AppColors.surfaceContainerLow),
                    )
                  else
                    Container(color: AppColors.surfaceContainerLow),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.black87],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'SS • XXIV',
                          style: AppTextStyles.label.copyWith(
                            color: AppColors.primary,
                            fontSize: 10,
                            letterSpacing: 5.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'The Midnight\nReverie',
                          style: AppTextStyles.headline.copyWith(
                            fontSize: 36,
                            height: 1.1,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/product-listing');
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.primary),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              'EXPLORE COLLECTION',
                              style: AppTextStyles.label.copyWith(
                                fontSize: 10,
                                color: AppColors.primary,
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

          // Search / Filter Chips
          SliverToBoxAdapter(
            child: SizedBox(
              height: 40,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                children: [
                  _buildChip('New Arrivals', true),
                  const SizedBox(width: 12),
                  _buildChip('Exclusives', false),
                  const SizedBox(width: 12),
                  _buildChip('Curated', false),
                  const SizedBox(width: 12),
                  _buildChip('Editorial', false),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 48)),

          // Trending Now Text + Grid
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trending Now',
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 24,
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.6,
                crossAxisSpacing: 16,
                mainAxisSpacing: 32,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final product = featuredProducts[index];
                  return _buildProductCard(context, product);
                },
                childCount: featuredProducts.length > 4 ? 4 : featuredProducts.length,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 120)),
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

  Widget _buildProductCard(BuildContext context, ProductModel product) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/product-detail', arguments: product.id);
      },
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
    );
  }
}
