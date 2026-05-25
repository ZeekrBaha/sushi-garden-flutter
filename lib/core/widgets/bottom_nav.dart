import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shared bottom navigation for the five main tabs of the app.
///
/// The order matches the Figma bottom bar: Каталог, Акции, Заказы, Корзина,
/// Профиль. Tapping a destination navigates to its route via GoRouter.
class SushiBottomNav extends StatelessWidget {
  const SushiBottomNav({required this.currentIndex, super.key});

  final int currentIndex;

  static const _routes = <String>[
    '/catalog',
    '/promos',
    '/orders',
    '/cart',
    '/profile',
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: (index) {
        if (index == currentIndex) {
          return;
        }
        context.go(_routes[index]);
      },
      destinations: const [
        NavigationDestination(icon: Icon(Icons.menu_book), label: 'Каталог'),
        NavigationDestination(icon: Icon(Icons.local_offer), label: 'Акции'),
        NavigationDestination(icon: Icon(Icons.receipt_long), label: 'Заказы'),
        NavigationDestination(
          icon: Icon(Icons.shopping_bag_outlined),
          label: 'Корзина',
        ),
        NavigationDestination(
          icon: Icon(Icons.person_outline),
          label: 'Профиль',
        ),
      ],
    );
  }
}
