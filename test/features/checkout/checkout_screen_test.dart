import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/features/checkout/checkout_screen.dart';

import '../../test_app.dart';

void main() {
  void useTallSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(430, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  testWidgets('checkout shows the form fields and totals breakdown', (
    tester,
  ) async {
    useTallSurface(tester);
    await tester.pumpWidget(const TestApp(child: CheckoutScreen()));

    expect(find.text('Ваше имя*'), findsOneWidget);
    expect(find.text('Телефон'), findsOneWidget);
    expect(find.text('Почта'), findsOneWidget);
    expect(find.text('Адрес'), findsOneWidget);

    expect(find.text('Сумма заказа'), findsOneWidget);
    expect(find.text('Сервисный сбор'), findsOneWidget);
    expect(find.text('Доставка'), findsOneWidget);
    expect(find.text('Итого'), findsOneWidget);
  });

  testWidgets('confirm is disabled until required fields are valid', (
    tester,
  ) async {
    useTallSurface(tester);
    await tester.pumpWidget(const TestApp(child: CheckoutScreen()));

    final confirm = find.widgetWithText(FilledButton, 'Подтвердить');
    expect(tester.widget<FilledButton>(confirm).onPressed, isNull);

    await tester.enterText(find.byType(TextField).at(0), 'Александр');
    await tester.enterText(find.byType(TextField).at(1), '888333777');
    await tester.enterText(find.byType(TextField).at(2), 'anovikov@gmail.com');
    await tester.enterText(find.byType(TextField).at(3), 'Воронеж, Мира 36');
    await tester.pump();

    expect(tester.widget<FilledButton>(confirm).onPressed, isNotNull);
  });
}
