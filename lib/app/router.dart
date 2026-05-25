import 'package:go_router/go_router.dart';
import 'package:sushi_garden_flutter/features/auth/login_screen.dart';
import 'package:sushi_garden_flutter/features/auth/register_screen.dart';
import 'package:sushi_garden_flutter/features/cart/cart_screen.dart';
import 'package:sushi_garden_flutter/features/catalog/catalog_screen.dart';
import 'package:sushi_garden_flutter/features/catalog/product_detail_screen.dart';
import 'package:sushi_garden_flutter/features/checkout/checkout_screen.dart';
import 'package:sushi_garden_flutter/features/orders/orders_screen.dart';
import 'package:sushi_garden_flutter/features/profile/profile_screen.dart';
import 'package:sushi_garden_flutter/features/promos/promos_screen.dart';
import 'package:sushi_garden_flutter/features/splash/splash_screen.dart';

const routePaths = <String>[
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
];

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/catalog',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/catalog',
        builder: (context, state) => const CatalogScreen(),
      ),
      GoRoute(
        path: '/catalog/product/:id',
        builder: (context, state) {
          return ProductDetailScreen(productId: state.pathParameters['id']!);
        },
      ),
      GoRoute(
        path: '/promos',
        builder: (context, state) => const PromosScreen(),
      ),
      GoRoute(
        path: '/orders',
        builder: (context, state) => const OrdersScreen(),
      ),
      GoRoute(
        path: '/cart',
        builder: (context, state) => const CartScreen(),
      ),
      GoRoute(
        path: '/checkout',
        builder: (context, state) => const CheckoutScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
    ],
  );
}
