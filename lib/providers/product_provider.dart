import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../data/app_data.dart';
import '../services/firestore_service.dart';

class ProductProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  List<ProductModel> _products = [];
  String _selectedCategory = '';
  String _searchQuery = '';
  bool _isLoading = false;

  List<ProductModel> get products => _products;
  String get selectedCategory => _selectedCategory;
  bool get isLoading => _isLoading;

  ProductProvider() {
    _initProducts();
  }

  void _initProducts() {
    _firestoreService.getProducts().listen((products) {
      if (products.isNotEmpty) {
        _products = products;
      } else {
        _products = AppData.dummyProducts;
      }
      notifyListeners();
    });
  }

  Future<void> fetchProducts() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));
    if (_products.isEmpty) {
      _products = AppData.dummyProducts;
    }

    _isLoading = false;
    notifyListeners();
  }

  void filterByCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void searchProducts(String query) {
    _searchQuery = query;
    notifyListeners();
  }
}
