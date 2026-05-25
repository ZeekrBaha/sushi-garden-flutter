/// Holds the checkout form state and validation for the `Корзина (1)` screen.
///
/// Plain mutable controller (like [CartController]); the screen drives
/// `setState` on field changes and reads [canConfirm] to gate the button.
class CheckoutController {
  CheckoutController({required this.subtotalRubles});

  /// Order sum carried over from the cart.
  final int subtotalRubles;

  String name = '';
  String phone = '';
  String email = '';
  String address = '';

  // Checkout fees added on top of the order sum (values from Figma 1:3471).
  static const int serviceFeeRubles = 76;
  static const int deliveryRubles = 0;

  int get totalRubles => subtotalRubles + serviceFeeRubles + deliveryRubles;

  bool get canConfirm =>
      name.trim().isNotEmpty &&
      _isValidPhone(phone) &&
      _isValidEmail(email) &&
      address.trim().isNotEmpty;

  bool _isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());
  }

  bool _isValidPhone(String value) {
    final digits = value.replaceAll(RegExp(r'\D'), '');
    return digits.length >= 6;
  }
}
