import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/product_model.dart';
import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../models/user_model.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get _userId => _auth.currentUser?.uid;

  // Products
  Stream<List<ProductModel>> getProducts() {
    return _db.collection('products').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromMap(doc.data());
      }).toList();
    });
  }

  Future<void> addProduct(ProductModel product) async {
    await _db.collection('products').doc(product.id).set(product.toMap());
  }

  // Cart
  Stream<List<CartModel>> getCart() {
    final uid = _userId;
    if (uid == null) return Stream.value([]);
    return _db.collection('carts').doc(uid).collection('items').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CartModel.fromMap(doc.data())).toList();
    });
  }

  Future<void> addToCart(CartModel item) async {
    final uid = _userId;
    if (uid == null) return;
    final cartRef = _db.collection('carts').doc(uid).collection('items');
    final existing = await cartRef.where('productId', isEqualTo: item.productId).where('size', isEqualTo: item.size).get();
    if (existing.docs.isNotEmpty) {
      final doc = existing.docs.first;
      final currentQty = doc.data()['quantity'] ?? 0;
      await doc.reference.update({'quantity': (currentQty as int) + item.quantity});
    } else {
      await cartRef.add(item.toMap());
    }
  }

  Future<void> removeFromCart(String productId) async {
    final uid = _userId;
    if (uid == null) return;
    final cartRef = _db.collection('carts').doc(uid).collection('items');
    final existing = await cartRef.where('productId', isEqualTo: productId).get();
    for (var doc in existing.docs) {
      await doc.reference.delete();
    }
  }

  Future<void> updateCartQuantity(String productId, int quantity) async {
    final uid = _userId;
    if (uid == null) return;
    final cartRef = _db.collection('carts').doc(uid).collection('items');
    final existing = await cartRef.where('productId', isEqualTo: productId).get();
    for (var doc in existing.docs) {
      if (quantity <= 0) {
        await doc.reference.delete();
      } else {
        await doc.reference.update({'quantity': quantity});
      }
    }
  }

  Future<void> clearCart() async {
    final uid = _userId;
    if (uid == null) return;
    final items = await _db.collection('carts').doc(uid).collection('items').get();
    for (var doc in items.docs) {
      await doc.reference.delete();
    }
  }

  // Orders
  Future<void> placeOrder(OrderModel order) async {
    await _db.collection('orders').doc(order.orderId).set(order.toMap());
  }

  Stream<List<OrderModel>> getUserOrders() {
    final uid = _userId;
    if (uid == null) return Stream.value([]);
    return _db.collection('orders')
        .where('userId', isEqualTo: uid)
        .snapshots()
        .map((snapshot) {
      final orders = snapshot.docs
          .map((doc) => OrderModel.fromMap(doc.data()))
          .toList();
      orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      return orders;
    });
  }

  // Profile
  Future<void> saveUserData(UserModel user) async {
    await _db.collection('users').doc(user.id).set(user.toMap());
  }

  Stream<UserModel?> getUserData(String userId) {
    return _db.collection('users').doc(userId).snapshots().map((doc) {
      if (doc.exists) {
        return UserModel.fromMap(doc.data()!);
      }
      return null;
    });
  }
}
