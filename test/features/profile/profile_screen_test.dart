import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/features/profile/profile_screen.dart';

import '../../test_app.dart';

void main() {
  testWidgets('profile screen shows user details, history and logout', (
    tester,
  ) async {
    await tester.pumpWidget(const TestApp(child: ProfileScreen()));

    expect(find.text('Александр Новиков'), findsOneWidget);
    expect(find.text('anovikov@gmail.com'), findsOneWidget);
    expect(find.text('888333777'), findsOneWidget);
    expect(find.text('Заказ №1024'), findsOneWidget);
    expect(find.text('Выйти'), findsOneWidget);
  });
}
