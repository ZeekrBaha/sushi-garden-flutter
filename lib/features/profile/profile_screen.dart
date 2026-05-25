import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sushi_garden_flutter/app/theme.dart';
import 'package:sushi_garden_flutter/core/formatters/money_formatter.dart';
import 'package:sushi_garden_flutter/core/widgets/bottom_nav.dart';
import 'package:sushi_garden_flutter/data/fake_orders.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = fakeProfile;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 20, 24, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Профиль',
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const CircleAvatar(
                    radius: 32,
                    backgroundColor: SushiColors.surface,
                    child: Icon(Icons.person, size: 36),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        profile.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        profile.email,
                        style: const TextStyle(color: SushiColors.textMuted),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        profile.phone,
                        style: const TextStyle(color: SushiColors.textMuted),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 28),
              Text(
                'История заказов',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Expanded(
                child: ListView.separated(
                  itemCount: fakeOrderHistory.length,
                  separatorBuilder: (context, index) =>
                      const Divider(color: SushiColors.divider, height: 1),
                  itemBuilder: (context, index) {
                    final order = fakeOrderHistory[index];

                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(order.title),
                      trailing: Text(
                        formatRubles(order.totalRubles),
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => context.go('/login'),
                  icon: const Icon(Icons.logout),
                  label: const Text('Выйти'),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SushiBottomNav(currentIndex: 4),
    );
  }
}
