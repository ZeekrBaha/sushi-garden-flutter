import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sushi_garden_flutter/app/app.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('catalog → product → cart → checkout → orders happy path', (
    tester,
  ) async {
    // Give the tall mobile frame room to lay out. (Sen is fetched on-device by
    // google_fonts; runtime fetching is left enabled so the simulator loads it.)
    tester.view.physicalSize = const Size(430, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const SushiGardenApp());
    await tester.pumpAndSettle();

    // 1. Catalog is the entry screen (splash is skipped locally).
    expect(find.text('Воронеж, Мира 36'), findsOneWidget);

    // 2. Open the Хикари product.
    await tester.tap(find.text('Хикари'));
    await tester.pumpAndSettle();
    expect(find.text('Описание'), findsOneWidget);

    // 3. Add one more, then go to the cart.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'В корзину'));
    await tester.pumpAndSettle();

    // 4. Cart shows the checkout CTA; continue to checkout.
    expect(find.text('3 позиции / 630 г'), findsOneWidget);
    await tester.tap(find.widgetWithText(FilledButton, 'Оформить заказ'));
    await tester.pumpAndSettle();

    // 5. Fill the required checkout fields.
    expect(find.text('Итого'), findsOneWidget);
    await tester.enterText(find.byType(TextField).at(0), 'Александр');
    await tester.enterText(find.byType(TextField).at(1), '888333777');
    await tester.enterText(find.byType(TextField).at(2), 'anovikov@gmail.com');
    await tester.enterText(find.byType(TextField).at(3), 'Воронеж, Мира 36');
    await tester.pumpAndSettle();

    // 6. Confirm the order.
    final confirm = find.widgetWithText(FilledButton, 'Подтвердить');
    await tester.ensureVisible(confirm);
    await tester.tap(confirm);
    await tester.pumpAndSettle();

    // 7. Orders screen shows the courier tracking.
    expect(find.text('Максим Винокур'), findsOneWidget);
  });
}
