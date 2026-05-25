import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sushi_garden_flutter/app/app.dart';

/// Drives the app through every screen and captures a screenshot of each, for
/// the README. Run with:
///   flutter drive --driver=test_driver/integration_test.dart \
///     --target=integration_test/screenshots_test.dart -d <device>
void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('capture README screenshots', (tester) async {
    await tester.pumpWidget(const SushiGardenApp());
    await tester.pumpAndSettle(const Duration(seconds: 1));
    await binding.convertFlutterSurfaceToImage();

    Future<void> shot(String name) async {
      await tester.pumpAndSettle();
      await binding.takeScreenshot(name);
    }

    // Catalog (entry).
    await shot('01_catalog');

    // Product detail.
    await tester.tap(find.text('Хикари'));
    await tester.pumpAndSettle();
    await shot('02_product_detail');

    // Cart (seeded with the Figma items).
    await tester.tap(find.widgetWithText(FilledButton, 'В корзину'));
    await tester.pumpAndSettle();
    await shot('03_cart');

    // Checkout, with the form filled.
    await tester.tap(find.widgetWithText(FilledButton, 'Оформить заказ'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).at(0), 'Александр');
    await tester.enterText(find.byType(TextField).at(1), '888333777');
    await tester.enterText(find.byType(TextField).at(2), 'anovikov@gmail.com');
    await tester.enterText(find.byType(TextField).at(3), 'Воронеж, Мира 36');
    await tester.pumpAndSettle();
    await shot('04_checkout');

    // Back to cart, then around the tabs.
    await tester.tap(find.byTooltip('Назад'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Акции'));
    await tester.pumpAndSettle();
    await shot('05_promotions');

    await tester.tap(find.text('Заказы'));
    await tester.pumpAndSettle();
    await shot('06_orders');

    await tester.tap(find.text('Профиль'));
    await tester.pumpAndSettle();
    await shot('07_profile');

    // Auth screens.
    await tester.tap(find.widgetWithText(OutlinedButton, 'Выйти'));
    await tester.pumpAndSettle();
    await shot('08_login');

    await tester.tap(find.widgetWithText(TextButton, 'Регистрация'));
    await tester.pumpAndSettle();
    await shot('09_register');
  });
}
