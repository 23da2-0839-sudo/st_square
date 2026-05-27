import 'package:flutter/material.dart';

import '../screens/splash/splash_screen.dart';
import '../screens/onboarding/onboarding_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/product/product_listing_screen.dart';
import '../screens/product/product_detail_screen.dart';
import '../screens/checkout/checkout_screen.dart';
import '../screens/orders/order_success_screen.dart';

class AppRoutes {
  // Route name constants
  static const splash         = '/splash';
  static const onboarding     = '/onboarding';
  static const login          = '/login';
  static const register       = '/register';
  static const forgotPassword = '/forgot-password';
  static const home           = '/home';
  static const search         = '/search';
  static const productListing = '/product-listing';
  static const productDetail  = '/product-detail';
  static const cart           = '/cart';
  static const checkout       = '/checkout';
  static const orderSuccess   = '/order-success';
  static const orderHistory   = '/order-history';
  static const orderDetail    = '/order-detail';
  static const wishlist       = '/wishlist';
  static const profile        = '/profile';
  static const editProfile    = '/edit-profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return _route(const SplashScreen());
      case onboarding:
        return _route(const OnboardingScreen());
      case login:
        return _route(const LoginScreen());
      case register:
        return _route(const RegisterScreen());
      case home:
        return _route(const DashboardScreen());
      case productListing:
        return _route(const ProductListingScreen());
      case productDetail:
        final productId = settings.arguments as String?;
        return _route(ProductDetailScreen(productId: productId));
      case checkout:
        return _route(const CheckoutScreen());
      case orderSuccess:
        return _route(const OrderSuccessScreen());
      default:
        return _route(Scaffold(
          backgroundColor: const Color(0xFF131313),
          appBar: AppBar(
            backgroundColor: const Color(0xFF131313),
            title: const Text('ST SQUARE', style: TextStyle(color: Color(0xFFE6C364))),
            centerTitle: true,
          ),
          body: Center(
            child: Text('Route "${settings.name}" not found',
                style: const TextStyle(color: Colors.white54)),
          ),
        ));
    }
  }

  static MaterialPageRoute _route(Widget page) {
    return MaterialPageRoute(builder: (_) => page);
  }
}
