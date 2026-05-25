import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/features/checkout/checkout_controller.dart';

void main() {
  CheckoutController validController() => CheckoutController(subtotalRubles: 1820)
    ..name = 'Александр'
    ..phone = '888333777'
    ..email = 'anovikov@gmail.com'
    ..address = 'Воронеж, Мира 36';

  test('cannot confirm when fields are empty', () {
    final controller = CheckoutController(subtotalRubles: 1820);
    expect(controller.canConfirm, isFalse);
  });

  test('cannot confirm with an invalid email', () {
    final controller = validController()..email = 'not-an-email';
    expect(controller.canConfirm, isFalse);
  });

  test('cannot confirm with an empty phone', () {
    final controller = validController()..phone = '   ';
    expect(controller.canConfirm, isFalse);
  });

  test('cannot confirm with a blank name', () {
    final controller = validController()..name = '   ';
    expect(controller.canConfirm, isFalse);
  });

  test('cannot confirm with an empty address', () {
    final controller = validController()..address = '';
    expect(controller.canConfirm, isFalse);
  });

  test('can confirm when all required fields are valid', () {
    expect(validController().canConfirm, isTrue);
  });

  test('total is the order sum plus service fee and delivery', () {
    final controller = CheckoutController(subtotalRubles: 1820);
    expect(
      controller.totalRubles,
      controller.subtotalRubles +
          CheckoutController.serviceFeeRubles +
          CheckoutController.deliveryRubles,
    );
  });
}
