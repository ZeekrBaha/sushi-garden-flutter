import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/data/fake_catalog.dart';
import 'package:sushi_garden_flutter/features/cart/cart_controller.dart';

void main() {
  test('cart adds, increments, decrements, and removes products', () {
    final cart = CartController();
    final hikari = fakeProducts.first;

    expect(cart.quantityFor(hikari.id), 0);

    cart.add(hikari);
    cart.add(hikari);

    expect(cart.quantityFor(hikari.id), 2);
    expect(cart.itemCount, 2);
    expect(cart.totalRubles, 1240);
    expect(cart.totalGrams, 510);

    cart.decrement(hikari.id);

    expect(cart.quantityFor(hikari.id), 1);

    cart.decrement(hikari.id);

    expect(cart.quantityFor(hikari.id), 0);
    expect(cart.lines, isEmpty);
  });
}
