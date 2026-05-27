import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../services/firestore_service.dart';

class OrderProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<OrderModel> _orders = [];
  bool _isLoading = false;

  List<OrderModel> get orders => _orders;
  bool get isLoading => _isLoading;

  OrderProvider() {
    _initOrders();
  }

  void _initOrders() {
    _firestoreService.getUserOrders().listen((orders) {
      _orders = orders;
      notifyListeners();
    });
  }

  Future<void> placeOrder(OrderModel order) async {
    _isLoading = true;
    notifyListeners();

    await _firestoreService.placeOrder(order);
    await _firestoreService.clearCart();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchOrders(String userId) async {
    _isLoading = true;
    notifyListeners();
    _isLoading = false;
    notifyListeners();
  }
}
