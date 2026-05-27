import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../models/order_model.dart';
import '../../providers/cart_provider.dart';
import '../../providers/order_provider.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _cityCtrl = TextEditingController();
  final _zipCtrl = TextEditingController();
  bool _isPlacing = false;

  @override
  void dispose() {
    _nameCtrl.dispose();
    _addressCtrl.dispose();
    _cityCtrl.dispose();
    _zipCtrl.dispose();
    super.dispose();
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isPlacing = true);

    final cart = context.read<CartProvider>();
    final orders = context.read<OrderProvider>();

    final order = OrderModel(
      orderId: 'ST-${DateTime.now().millisecondsSinceEpoch}',
      userId: 'guest',
      items: List.from(cart.cartItems),
      total: cart.cartTotal,
      status: 'confirmed',
      createdAt: DateTime.now(),
      deliveryAddress: '${_nameCtrl.text}, ${_addressCtrl.text}, ${_cityCtrl.text} ${_zipCtrl.text}',
    );

    await orders.placeOrder(order);

    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, '/order-success', (route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background.withAlpha(220),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.primaryContainer),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('ST SQUARE', style: AppTextStyles.headline.copyWith(fontSize: 20, fontStyle: FontStyle.italic, color: const Color(0xFFE6C364), letterSpacing: 2.0)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Checkout', style: AppTextStyles.headline.copyWith(fontSize: 32, color: AppColors.onSurface)),
              const SizedBox(height: 8),
              Text('Delivery Details', style: AppTextStyles.label.copyWith(fontSize: 10, color: AppColors.primary, letterSpacing: 3)),
              const SizedBox(height: 32),

              _field(_nameCtrl, 'Full Name', Icons.person_outline),
              const SizedBox(height: 16),
              _field(_addressCtrl, 'Street Address', Icons.home_outlined),
              const SizedBox(height: 16),
              _field(_cityCtrl, 'City', Icons.location_city_outlined),
              const SizedBox(height: 16),
              _field(_zipCtrl, 'ZIP / Postal Code', Icons.mail_outline),

              const SizedBox(height: 40),
              Divider(color: AppColors.outlineVariant.withAlpha(50)),
              const SizedBox(height: 24),

              // Order Summary
              Text('ORDER SUMMARY', style: AppTextStyles.label.copyWith(fontSize: 10, color: AppColors.onSurfaceVariant, letterSpacing: 3)),
              const SizedBox(height: 16),
              ...cart.cartItems.map((item) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text('${item.name} × ${item.quantity}', style: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant))),
                    Text('\$${(item.price * item.quantity).toStringAsFixed(2)}', style: AppTextStyles.body.copyWith(color: AppColors.onSurface)),
                  ],
                ),
              )),
              const SizedBox(height: 8),
              Divider(color: AppColors.outlineVariant.withAlpha(50)),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('TOTAL', style: AppTextStyles.label.copyWith(fontSize: 13, color: AppColors.onSurface, letterSpacing: 2)),
                  Text('\$${cart.cartTotal.toStringAsFixed(2)}', style: AppTextStyles.label.copyWith(fontSize: 20, color: AppColors.primary, letterSpacing: 0, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 40),

              // Place Order Button
              GestureDetector(
                onTap: _isPlacing ? null : _placeOrder,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFFE6C364), Color(0xFFC9A84C)]),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [BoxShadow(color: AppColors.primary.withAlpha(50), blurRadius: 30, offset: const Offset(0, 8))],
                  ),
                  child: _isPlacing
                      ? const Center(child: SizedBox(width: 24, height: 24, child: CircularProgressIndicator(color: Color(0xFF241A00), strokeWidth: 2)))
                      : Text('PLACE ORDER', textAlign: TextAlign.center, style: AppTextStyles.label.copyWith(color: const Color(0xFF241A00), fontSize: 13, letterSpacing: 2.0, fontWeight: FontWeight.w800)),
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController ctrl, String hint, IconData icon) {
    return TextFormField(
      controller: ctrl,
      style: AppTextStyles.body.copyWith(color: AppColors.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.body.copyWith(color: AppColors.onSurfaceVariant.withAlpha(128)),
        prefixIcon: Icon(icon, color: AppColors.onSurfaceVariant.withAlpha(128), size: 20),
        filled: true,
        fillColor: AppColors.surfaceContainer,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary)),
      ),
      validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
    );
  }
}
