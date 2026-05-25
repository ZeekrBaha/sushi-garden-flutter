import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/features/orders/orders_screen.dart';

import '../../test_app.dart';

void main() {
  testWidgets('orders screen shows the courier tracking copy', (tester) async {
    await tester.pumpWidget(const TestApp(child: OrdersScreen()));

    // "Заказы" is also the bottom-nav label, so it appears more than once.
    expect(find.text('Заказы'), findsWidgets);
    expect(find.text('Максим Винокур'), findsOneWidget);
    expect(find.text('Курьер будет в 22:10'), findsOneWidget);
  });
}
