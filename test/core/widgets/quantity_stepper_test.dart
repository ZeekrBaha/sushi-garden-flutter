import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/core/widgets/quantity_stepper.dart';

import '../../test_app.dart';

void main() {
  testWidgets('shows the current quantity', (tester) async {
    await tester.pumpWidget(
      TestApp(
        child: QuantityStepper(
          quantity: 3,
          onIncrement: () {},
          onDecrement: () {},
        ),
      ),
    );

    expect(find.text('3'), findsOneWidget);
  });

  testWidgets('plus and minus invoke their callbacks', (tester) async {
    var increments = 0;
    var decrements = 0;

    await tester.pumpWidget(
      TestApp(
        child: QuantityStepper(
          quantity: 1,
          onIncrement: () => increments++,
          onDecrement: () => decrements++,
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.add));
    await tester.tap(find.byIcon(Icons.remove));

    expect(increments, 1);
    expect(decrements, 1);
  });
}
