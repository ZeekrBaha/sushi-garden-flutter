/// Validation for the `Войти` and `Регистрация` screens.
///
/// Plain mutable controller (like [CartController] / [CheckoutController]); the
/// screens drive `setState` on field changes and read [canLogin] / [canRegister]
/// to gate their primary buttons.
class AuthController {
  String name = '';
  String email = '';
  String password = '';
  bool acceptedTerms = false;

  bool get canLogin => _isValidEmail(email) && password.isNotEmpty;

  bool get canRegister =>
      name.trim().isNotEmpty &&
      _isValidEmail(email) &&
      password.isNotEmpty &&
      acceptedTerms;

  bool _isValidEmail(String value) {
    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(value.trim());
  }
}
