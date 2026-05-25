import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sushi_garden_flutter/app/theme.dart';
import 'package:sushi_garden_flutter/core/formatters/money_formatter.dart';
import 'package:sushi_garden_flutter/core/widgets/bottom_nav.dart';
import 'package:sushi_garden_flutter/core/widgets/quantity_stepper.dart';
import 'package:sushi_garden_flutter/data/fake_catalog.dart';
import 'package:sushi_garden_flutter/data/fake_orders.dart';
import 'package:sushi_garden_flutter/features/cart/cart_controller.dart';
import 'package:sushi_garden_flutter/features/catalog/catalog_models.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController _cart = CartController();

  @override
  void initState() {
    super.initState();
    // Seed the cart with the products shown in the Figma `Корзина` mock.
    for (final id in fakeCartProductIds) {
      _cart.add(fakeProducts.firstWhere((product) => product.id == id));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Корзина',
                    style: Theme.of(context).textTheme.headlineMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cartSummaryLabel,
                    style: const TextStyle(color: SushiColors.textMuted),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
                children: [
                  for (final id in fakeCartProductIds) _cartLine(context, id),
                  const SizedBox(height: 12),
                  Text(
                    'Добавить еще',
                    style: Theme.of(context).textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  for (final addOn in fakeAddOns) _addOnRow(addOn),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: _checkoutButton(context),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const SushiBottomNav(currentIndex: 3),
    );
  }

  Widget _cartLine(BuildContext context, String productId) {
    final product = fakeProducts.firstWhere((item) => item.id == productId);
    final quantity = _cart.quantityFor(productId);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: ColoredBox(
              color: SushiColors.surface,
              child: Image.asset(
                product.imageAsset,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 4),
                Text(formatRubles(product.priceRubles)),
                const SizedBox(height: 8),
                QuantityStepper(
                  quantity: quantity,
                  onIncrement: () => setState(() => _cart.add(product)),
                  onDecrement: () =>
                      setState(() => _cart.decrement(productId)),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => setState(() {
              for (var i = 0; i < quantity; i++) {
                _cart.decrement(productId);
              }
            }),
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Удалить',
          ),
        ],
      ),
    );
  }

  Widget _addOnRow(AddOn addOn) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 18,
            backgroundColor: SushiColors.surface,
            child: Icon(Icons.eco, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  addOn.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                Text(
                  '${addOn.weightGrams} г',
                  style: const TextStyle(color: SushiColors.textMuted),
                ),
              ],
            ),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: SushiColors.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                formatRubles(addOn.priceRubles),
                style: const TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkoutButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: SushiColors.accent,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        onPressed: () => context.go('/checkout'),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Оформить заказ',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
            Text(
              formatRubles(cartTotalRubles),
              style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
