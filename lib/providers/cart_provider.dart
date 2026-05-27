import 'package:flutter/material.dart';
import '../models/cart_model.dart';
import '../services/firestore_service.dart';

class CartProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<CartModel> _cartItems = [];

  List<CartModel> get cartItems => _cartItems;

  double get cartTotal {
    return _cartItems.fold(0, (sum, item) => sum + (item.price * item.quantity));
  }

  int get cartCount {
    return _cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  CartProvider() {
    _initCart();
  }

  void _initCart() {
    _firestoreService.getCart().listen((items) {
      _cartItems = items;
      notifyListeners();
    });
  }

  Future<void> addToCart(CartModel item) async {
    await _firestoreService.addToCart(item);
  }

  Future<void> removeFromCart(String productId) async {
    await _firestoreService.removeFromCart(productId);
  }

  Future<void> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
    } else {
      await _firestoreService.updateCartQuantity(productId, quantity);
    }
  }

  Future<void> clearCart() async {
    await _firestoreService.clearCart();
  }
}
