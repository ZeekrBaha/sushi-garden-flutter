import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/features/catalog/product_detail_screen.dart';

import '../../test_app.dart';

void main() {
  testWidgets('product detail shows Figma copy for Hikari', (tester) async {
    await tester.pumpWidget(
      const TestApp(child: ProductDetailScreen(productId: 'hikari')),
    );

    expect(find.text('Хикари'), findsOneWidget);
    expect(find.text('Описание'), findsOneWidget);
    expect(find.textContaining('креветка в темпуре'), findsOneWidget);
    // Price shows on both the price tag and the "В корзину" CTA total.
    expect(find.text('620 ₽'), findsWidgets);
    expect(find.text('255 г'), findsOneWidget);

    // Real product photo, not a placeholder icon.
    expect(
      find.byWidgetPredicate(
        (w) =>
            w is Image &&
            w.image is AssetImage &&
            (w.image as AssetImage).assetName ==
                'assets/images/products/hikari.png',
      ),
      findsOneWidget,
    );
    expect(find.byIcon(Icons.ramen_dining), findsNothing);
  });
}
