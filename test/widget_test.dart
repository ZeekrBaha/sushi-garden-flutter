import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/app/app.dart';

void main() {
  testWidgets('Sushi Garden catalog smoke test', (tester) async {
    await tester.pumpWidget(const SushiGardenApp());

    expect(find.text('Доставка по адресу:'), findsOneWidget);
    expect(find.text('Воронеж, Мира 36'), findsOneWidget);
    expect(find.text('Хикари'), findsOneWidget);
    expect(find.text('Каталог'), findsWidgets);
  });
}
