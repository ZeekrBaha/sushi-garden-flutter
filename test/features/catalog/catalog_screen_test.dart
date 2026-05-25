import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sushi_garden_flutter/app/theme.dart';
import 'package:sushi_garden_flutter/features/catalog/catalog_screen.dart';

Finder _assetImage(String path) => find.byWidgetPredicate(
  (w) =>
      w is Image &&
      w.image is AssetImage &&
      (w.image as AssetImage).assetName == path,
);

void main() {
  testWidgets('catalog shows real product photos, not placeholders', (
    tester,
  ) async {
    // Catalog uses GoRouter navigation, so host it in a minimal router.
    final router = GoRouter(
      initialLocation: '/catalog',
      routes: [
        GoRoute(path: '/catalog', builder: (c, s) => const CatalogScreen()),
        GoRoute(
          path: '/catalog/product/:id',
          builder: (c, s) => const SizedBox.shrink(),
        ),
      ],
    );

    await tester.pumpWidget(
      MaterialApp.router(theme: buildSushiTheme(), routerConfig: router),
    );

    expect(_assetImage('assets/images/products/hikari.png'), findsOneWidget);
    expect(find.byIcon(Icons.ramen_dining), findsNothing);
  });
}
