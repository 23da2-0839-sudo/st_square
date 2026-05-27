class CartModel {
  final String productId;
  final String name;
  final double price;
  final String size;
  final int quantity;
  final String imageUrl;

  CartModel({
    required this.productId,
    required this.name,
    required this.price,
    required this.size,
    required this.quantity,
    required this.imageUrl,
  });

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      productId: map['productId'] ?? '',
      name: map['name'] ?? '',
      price: (map['price'] ?? 0.0).toDouble(),
      size: map['size'] ?? '',
      quantity: map['quantity'] ?? 1,
      imageUrl: map['imageUrl'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'name': name,
      'price': price,
      'size': size,
      'quantity': quantity,
      'imageUrl': imageUrl,
    };
  }

  CartModel copyWith({
    String? productId,
    String? name,
    double? price,
    String? size,
    int? quantity,
    String? imageUrl,
  }) {
    return CartModel(
      productId: productId ?? this.productId,
      name: name ?? this.name,
      price: price ?? this.price,
      size: size ?? this.size,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }
}
