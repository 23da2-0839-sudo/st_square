import 'cart_model.dart';

class OrderModel {
  final String orderId;
  final String userId;
  final List<CartModel> items;
  final double total;
  final String status;
  final DateTime createdAt;
  final String deliveryAddress;

  OrderModel({
    required this.orderId,
    required this.userId,
    required this.items,
    required this.total,
    required this.status,
    required this.createdAt,
    required this.deliveryAddress,
  });

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      orderId: map['orderId'] ?? '',
      userId: map['userId'] ?? '',
      items: List<CartModel>.from(
        (map['items'] ?? []).map((x) => CartModel.fromMap(x)),
      ),
      total: (map['total'] ?? 0.0).toDouble(),
      status: map['status'] ?? 'pending',
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt'] ?? 0),
      deliveryAddress: map['deliveryAddress'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'items': items.map((x) => x.toMap()).toList(),
      'total': total,
      'status': status,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'deliveryAddress': deliveryAddress,
    };
  }

  OrderModel copyWith({
    String? orderId,
    String? userId,
    List<CartModel>? items,
    double? total,
    String? status,
    DateTime? createdAt,
    String? deliveryAddress,
  }) {
    return OrderModel(
      orderId: orderId ?? this.orderId,
      userId: userId ?? this.userId,
      items: items ?? this.items,
      total: total ?? this.total,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
    );
  }
}
