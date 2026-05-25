import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/features/cart/cart_screen.dart';

import '../../test_app.dart';

void main() {
  testWidgets('cart screen shows the Figma items, add-ons and total', (
    tester,
  ) async {
    // The Figma `Корзина` frame is 430x1029 — taller than the default test
    // viewport, so use a tall surface to lay out the whole scroll content.
    tester.view.physicalSize = const Size(430, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const TestApp(child: CartScreen()));

    // "Корзина" is both the title and the bottom-nav label.
    expect(find.text('Корзина'), findsWidgets);
    expect(find.text('3 позиции / 630 г'), findsOneWidget);

    expect(find.text('Лос-Анджелес'), findsOneWidget);
    expect(find.text('Хикари'), findsOneWidget);
    expect(find.text('Осака маки'), findsOneWidget);
    expect(find.text('707 ₽'), findsOneWidget);
    expect(find.text('620 ₽'), findsOneWidget);
    expect(find.text('740 ₽'), findsOneWidget);

    expect(find.text('Добавить еще'), findsOneWidget);
    expect(find.text('Васаби'), findsOneWidget);
    expect(find.text('Имбирь'), findsOneWidget);
    expect(find.text('Соевый соус'), findsOneWidget);
    expect(find.text('60 ₽'), findsNWidgets(3));

    expect(find.text('Оформить заказ'), findsOneWidget);
    expect(find.text('1 820 ₽'), findsOneWidget);

    // Cart lines use real product photos, not placeholder icons.
    expect(
      find.byWidgetPredicate(
        (w) =>
            w is Image &&
            w.image is AssetImage &&
            (w.image as AssetImage).assetName ==
                'assets/images/products/los-angeles.png',
      ),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.ramen_dining), findsNothing);
  });

  testWidgets('tapping plus on a line increments its quantity', (tester) async {
    await tester.pumpWidget(const TestApp(child: CartScreen()));

    // Every line starts at quantity 1.
    expect(find.text('1'), findsNWidgets(3));

    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pump();

    expect(find.text('2'), findsOneWidget);
  });
}
