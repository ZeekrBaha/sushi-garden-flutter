import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:sushi_garden_flutter/app/theme.dart';
import 'package:sushi_garden_flutter/core/widgets/bottom_nav.dart';

GoRouter _navRouter() {
  Widget tab(String marker, int index) => Scaffold(
    body: Center(child: Text(marker)),
    bottomNavigationBar: SushiBottomNav(currentIndex: index),
  );

  return GoRouter(
    initialLocation: '/catalog',
    routes: [
      GoRoute(path: '/catalog', builder: (c, s) => tab('CATALOG', 0)),
      GoRoute(path: '/promos', builder: (c, s) => tab('PROMOS', 1)),
      GoRoute(path: '/orders', builder: (c, s) => tab('ORDERS', 2)),
      GoRoute(path: '/cart', builder: (c, s) => tab('CART', 3)),
      GoRoute(path: '/profile', builder: (c, s) => tab('PROFILE', 4)),
    ],
  );
}

void main() {
  testWidgets('bottom nav renders the five Figma tabs', (tester) async {
    await tester.pumpWidget(
      MaterialApp.router(theme: buildSushiTheme(), routerConfig: _navRouter()),
    );

    expect(find.text('Каталог'), findsOneWidget);
    expect(find.text('Акции'), findsOneWidget);
    expect(find.text('Заказы'), findsOneWidget);
    expect(find.text('Корзина'), findsOneWidget);
    expect(find.text('Профиль'), findsOneWidget);
  });

  testWidgets('tapping a tab navigates to that route', (tester) async {
    await tester.pumpWidget(
      MaterialApp.router(theme: buildSushiTheme(), routerConfig: _navRouter()),
    );

    expect(find.text('CATALOG'), findsOneWidget);

    await tester.tap(find.text('Заказы'));
    await tester.pumpAndSettle();

    expect(find.text('ORDERS'), findsOneWidget);
    expect(find.text('CATALOG'), findsNothing);
  });
}
