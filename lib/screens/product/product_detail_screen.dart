import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/product_model.dart';
import '../../models/cart_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/product_provider.dart';
import '../../widgets/common/custom_button.dart';

class ProductDetailScreen extends StatefulWidget {
  final String? productId;

  const ProductDetailScreen({super.key, this.productId});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedColorIndex = 0;
  int _selectedSizeIndex = 0;

  ProductModel? get _product {
    final products = context.read<ProductProvider>().products;
    if (widget.productId != null) {
      return products.cast<ProductModel?>().firstWhere(
        (p) => p!.id == widget.productId,
        orElse: () => products.isNotEmpty ? products.first : null,
      );
    }
    return products.isNotEmpty ? products.first : null;
  }

  List<Color> get _swatchColors {
    final product = _product;
    if (product == null || product.colors.isEmpty) {
      return [const Color(0xFFE6C364)];
    }
    return product.colors.map((c) {
      switch (c.toLowerCase()) {
        case 'black': return const Color(0xFF353534);
        case 'white': return const Color(0xFFF5F5F0);
        case 'gold': return const Color(0xFFE6C364);
        case 'silver': return const Color(0xFFC8C6C5);
        case 'rose gold': return const Color(0xFFB76E79);
        case 'ivory': return const Color(0xFFFFFFF0);
        case 'navy': return const Color(0xFF1B1B4B);
        case 'tan': return const Color(0xFFD2B48C);
        case 'brown': return const Color(0xFF8B4513);
        case 'burgundy': return const Color(0xFF800020);
        case 'emerald': return const Color(0xFF50C878);
        default: return const Color(0xFFE6C364);
      }
    }).toList();
  }

  List<String> get _sizes {
    final product = _product;
    return product?.sizes ?? ['One Size'];
  }

  @override
  Widget build(BuildContext context) {
    final product = _product;
    if (product == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: Text('Product not found', style: TextStyle(color: Colors.white54))),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Hero Product Image
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            pinned: true,
            backgroundColor: AppColors.background.withAlpha(200),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.primaryContainer),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.images.isNotEmpty ? product.images.first : '',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(color: AppColors.surfaceContainerLow),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.center,
                        colors: [AppColors.background, Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.shopping_bag, color: AppColors.primaryContainer),
                onPressed: () => Navigator.pushNamed(context, '/product-listing'),
              ),
            ],
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

          // Product Detailing
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              transform: Matrix4.translationValues(0, -32, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title & Price Block
                  Text(
                    product.category.toUpperCase(),
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.primary,
                      fontSize: 10,
                      letterSpacing: 3.0,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.name,
                    style: AppTextStyles.headline.copyWith(
                      fontSize: 36,
                      height: 1.1,
                      color: AppColors.onBackground,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '\$${product.price.toStringAsFixed(0)}',
                        style: AppTextStyles.body.copyWith(
                          fontSize: 28,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),

                  // Custom Selectors Bento Box
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Colors
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SELECT FINISH',
                              style: AppTextStyles.label.copyWith(
                                fontSize: 10,
                                color: AppColors.onSurfaceVariant,
                                letterSpacing: 2.0,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: List.generate(_swatchColors.length, (index) {
                                final isSelected = _selectedColorIndex == index;
                                return GestureDetector(
                                  onTap: () => setState(() => _selectedColorIndex = index),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 16),
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: _swatchColors[index],
                                      shape: BoxShape.circle,
                                      border: isSelected 
                                          ? Border.all(color: AppColors.primary, width: 2) 
                                          : Border.all(color: AppColors.outlineVariant.withAlpha(76)),
                                      boxShadow: isSelected
                                          ? [BoxShadow(color: AppColors.primary.withAlpha(100), blurRadius: 8)]
                                          : null,
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                      
                      // Sizes
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _sizes.length > 1 ? 'SIZE' : '',
                              style: AppTextStyles.label.copyWith(
                                fontSize: 10,
                                color: AppColors.onSurfaceVariant,
                                letterSpacing: 2.0,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: List.generate(_sizes.length, (index) {
                                final isSelected = _selectedSizeIndex == index;
                                return GestureDetector(
                                  onTap: () => setState(() => _selectedSizeIndex = index),
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                                    decoration: BoxDecoration(
                                      color: isSelected ? AppColors.surfaceContainerHigh : AppColors.surfaceContainerLow,
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: isSelected ? AppColors.primary : AppColors.outlineVariant.withAlpha(50),
                                      ),
                                    ),
                                    child: Text(
                                      _sizes[index],
                                      style: AppTextStyles.body.copyWith(
                                        color: isSelected ? AppColors.onBackground : AppColors.onSurfaceVariant,
                                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 48),

                  // Collapsible Details
                  Container(
                    decoration: BoxDecoration(
                      border: Border(top: BorderSide(color: AppColors.outlineVariant.withAlpha(25))),
                    ),
                    child: Theme(
                      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        tilePadding: EdgeInsets.zero,
                        iconColor: AppColors.primary,
                        collapsedIconColor: AppColors.primary,
                        title: Text(
                          'The Narrative',
                          style: AppTextStyles.headline.copyWith(
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                            color: AppColors.onBackground,
                          ),
                        ),
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 24.0, right: 16.0),
                            child: Text(
                              product.description,
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.onSurfaceVariant,
                                height: 1.6,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Action Buttons
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Add to Cart',
                          onPressed: () {
                            context.read<CartProvider>().addToCart(
                              CartModel(
                                productId: product.id,
                                name: product.name,
                                price: product.price,
                                size: _sizes.isNotEmpty ? _sizes[_selectedSizeIndex] : 'One Size',
                                quantity: 1,
                                imageUrl: product.images.isNotEmpty ? product.images.first : '',
                              ),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(Icons.check_circle, color: Color(0xFFE6C364), size: 20),
                                    const SizedBox(width: 12),
                                    Text("Added to cart", style: AppTextStyles.body.copyWith(color: Colors.white)),
                                  ],
                                ),
                                backgroundColor: AppColors.surfaceContainerLow,
                                behavior: SnackBarBehavior.floating,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                action: SnackBarAction(
                                  label: 'VIEW CART',
                                  textColor: const Color(0xFFE6C364),
                                  onPressed: () => Navigator.pushNamed(context, '/home'),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(color: AppColors.outlineVariant.withAlpha(76)),
                              color: Colors.transparent,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.favorite_border, color: AppColors.primary, size: 18),
                                const SizedBox(width: 8),
                                Text(
                                  'ADD TO WISHLIST',
                                  style: AppTextStyles.headline.copyWith(
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2.0,
                                    fontSize: 12,
                                    color: AppColors.onBackground,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 64),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }}
