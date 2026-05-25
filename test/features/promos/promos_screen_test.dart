import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/features/promos/promos_screen.dart';

import '../../test_app.dart';

void main() {
  testWidgets('promos screen shows the Акции categories with banners', (
    tester,
  ) async {
    await tester.pumpWidget(const TestApp(child: PromosScreen()));

    // "Акции" appears both as the screen title and the bottom-nav tab label.
    expect(find.text('Акции'), findsWidgets);
    expect(find.text('Постное меню'), findsOneWidget);
    expect(find.text('Сеты'), findsOneWidget);

    // Promo cards use real banner images.
    expect(
      find.byWidgetPredicate(
        (w) =>
            w is Image &&
            w.image is AssetImage &&
            (w.image as AssetImage).assetName ==
                'assets/images/promos/banner_promo_1.png',
      ),
      findsOneWidget,
    );
  });
}
