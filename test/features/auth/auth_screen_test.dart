import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/features/auth/login_screen.dart';
import 'package:sushi_garden_flutter/features/auth/register_screen.dart';

import '../../test_app.dart';

void main() {
  void useTallSurface(WidgetTester tester) {
    tester.view.physicalSize = const Size(430, 1400);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
  }

  testWidgets('login enables its button once email and password are valid', (
    tester,
  ) async {
    useTallSurface(tester);
    await tester.pumpWidget(const TestApp(child: LoginScreen()));

    // "Войти" is both the title and the button label.
    expect(find.text('Войти'), findsWidgets);
    expect(find.byType(TextField), findsNWidgets(2));

    final button = find.widgetWithText(FilledButton, 'Войти');
    expect(tester.widget<FilledButton>(button).onPressed, isNull);

    await tester.enterText(find.byType(TextField).at(0), 'anovikov@gmail.com');
    await tester.enterText(find.byType(TextField).at(1), 'secret');
    await tester.pump();

    expect(tester.widget<FilledButton>(button).onPressed, isNotNull);
  });

  testWidgets('register requires fields and the terms checkbox', (
    tester,
  ) async {
    useTallSurface(tester);
    await tester.pumpWidget(const TestApp(child: RegisterScreen()));

    expect(find.text('Регистрация'), findsWidgets);
    expect(find.byType(TextField), findsNWidgets(3));
    expect(find.byType(Checkbox), findsOneWidget);

    final button = find.widgetWithText(FilledButton, 'Зарегистрироваться');
    expect(tester.widget<FilledButton>(button).onPressed, isNull);

    await tester.enterText(find.byType(TextField).at(0), 'Александр');
    await tester.enterText(find.byType(TextField).at(1), 'anovikov@gmail.com');
    await tester.enterText(find.byType(TextField).at(2), 'secret');
    await tester.tap(find.byType(Checkbox));
    await tester.pump();

    expect(tester.widget<FilledButton>(button).onPressed, isNotNull);
  });
}
