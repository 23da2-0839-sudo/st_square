class ProductModel {
  final String id;
  final String name;
  final String category;
  final double price;
  final List<String> images;
  final List<String> sizes;
  final List<String> colors;
  final String description;
  final bool isFeatured;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.images,
    required this.sizes,
    required this.colors,
    required this.description,
    this.isFeatured = false,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      category: map['category'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      images: List<String>.from(map['images'] ?? []),
      sizes: List<String>.from(map['sizes'] ?? []),
      colors: List<String>.from(map['colors'] ?? []),
      description: map['description'] ?? '',
      isFeatured: map['isFeatured'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'category': category,
      'price': price,
      'images': images,
      'sizes': sizes,
      'colors': colors,
      'description': description,
      'isFeatured': isFeatured,
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    String? category,
    double? price,
    List<String>? images,
    List<String>? sizes,
    List<String>? colors,
    String? description,
    bool? isFeatured,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      price: price ?? this.price,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      description: description ?? this.description,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}
