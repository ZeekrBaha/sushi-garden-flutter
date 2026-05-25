import 'package:flutter/material.dart';
import 'package:sushi_garden_flutter/app/theme.dart';
import 'package:sushi_garden_flutter/core/widgets/bottom_nav.dart';
import 'package:sushi_garden_flutter/data/fake_orders.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final delivery = fakeDelivery;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Заказы',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 24),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: SushiColors.surface,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const SizedBox(
                  height: 180,
                  child: Center(
                    child: Icon(Icons.local_shipping, size: 64),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                delivery.etaLabel,
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                delivery.statusLabel,
                style: const TextStyle(color: SushiColors.textMuted),
              ),
              const SizedBox(height: 24),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const CircleAvatar(
                  backgroundColor: SushiColors.surface,
                  child: Icon(Icons.person_outline),
                ),
                title: Text(
                  delivery.courierName,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: const Text(
                  'Ваш курьер',
                  style: TextStyle(color: SushiColors.textMuted),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.call),
                  tooltip: 'Позвонить',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SushiBottomNav(currentIndex: 2),
    );
  }
}
