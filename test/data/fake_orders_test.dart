import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/data/fake_orders.dart';

void main() {
  test('fake promos match the Акции screen categories', () {
    expect(
      fakePromos.map((promo) => promo.title),
      orderedEquals(<String>['Постное меню', 'Сеты']),
    );
  });

  test('fake delivery matches the Заказы tracking copy', () {
    expect(fakeDelivery.courierName, 'Максим Винокур');
    expect(fakeDelivery.etaLabel, 'Курьер будет в 22:10');
  });

  test('fake profile matches the Профиль screen', () {
    expect(fakeProfile.name, 'Александр Новиков');
    expect(fakeProfile.email, 'anovikov@gmail.com');
    expect(fakeProfile.phone, '888333777');
  });

  test('fake order history is non-empty for the profile list', () {
    expect(fakeOrderHistory, isNotEmpty);
  });
}
