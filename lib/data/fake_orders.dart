import 'package:sushi_garden_flutter/features/catalog/catalog_models.dart';

/// Promo categories shown on the `Акции` screen.
const fakePromos = <Promo>[
  Promo(
    id: 'lean-menu',
    title: 'Постное меню',
    imageAsset: 'assets/images/promos/banner_promo_2.png',
  ),
  Promo(
    id: 'sets',
    title: 'Сеты',
    imageAsset: 'assets/images/promos/banner_promo_1.png',
  ),
];

/// Product ids shown as cart lines on the `Корзина` screen, in Figma order.
const fakeCartProductIds = <String>['los-angeles', 'hikari', 'osaka-maki'];

/// Fixed summary values from the Figma `Корзина` mock. These are design
/// figures (they intentionally do not equal the line-item sums), so they are
/// rendered verbatim rather than computed.
const cartSummaryLabel = '3 позиции / 630 г';
const cartTotalRubles = 1820;

/// Active delivery tracked on the `Заказы` screen.
const fakeDelivery = Delivery(
  courierName: 'Максим Винокур',
  etaLabel: 'Курьер будет в 22:10',
  statusLabel: 'Курьер уже в пути',
);

/// Signed-in user shown on the `Профиль` screen.
const fakeProfile = UserProfile(
  name: 'Александр Новиков',
  email: 'anovikov@gmail.com',
  phone: '888333777',
);

/// Past orders listed under the profile.
const fakeOrderHistory = <Order>[
  Order(id: 'order-1024', title: 'Заказ №1024', totalRubles: 1820),
  Order(id: 'order-0987', title: 'Заказ №987', totalRubles: 1340),
];
