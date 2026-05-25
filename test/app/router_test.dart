import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/app/router.dart';

void main() {
  test('router exposes Figma app routes', () {
    expect(routePaths, <String>[
      '/splash',
      '/catalog',
      '/catalog/product/:id',
      '/promos',
      '/orders',
      '/cart',
      '/checkout',
      '/profile',
      '/login',
      '/register',
    ]);
  });

  test(
    'router starts on catalog after splash milestone is skipped locally',
    () {
      expect(
        createRouter().routeInformationProvider.value.uri.path,
        '/catalog',
      );
    },
  );
}
