import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sushi_garden_flutter/app/theme.dart';
import 'package:sushi_garden_flutter/core/formatters/money_formatter.dart';
import 'package:sushi_garden_flutter/data/fake_orders.dart';
import 'package:sushi_garden_flutter/features/checkout/checkout_controller.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final CheckoutController _controller = CheckoutController(
    subtotalRubles: cartTotalRubles,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () => context.go('/cart'),
                  icon: const Icon(Icons.arrow_back),
                  tooltip: 'Назад',
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Оформление заказа',
                    style: Theme.of(context).textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            _field(
              label: 'Ваше имя*',
              onChanged: (value) => setState(() => _controller.name = value),
            ),
            _field(
              label: 'Телефон',
              keyboardType: TextInputType.phone,
              onChanged: (value) => setState(() => _controller.phone = value),
            ),
            _field(
              label: 'Почта',
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => setState(() => _controller.email = value),
            ),
            _field(
              label: 'Адрес',
              onChanged: (value) => setState(() => _controller.address = value),
            ),
            const SizedBox(height: 16),
            _totalRow('Сумма заказа', _controller.subtotalRubles),
            _totalRow('Доставка', CheckoutController.deliveryRubles),
            _totalRow('Сервисный сбор', CheckoutController.serviceFeeRubles),
            const Divider(color: SushiColors.divider, height: 32),
            _totalRow('Итого', _controller.totalRubles, emphasize: true),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: SushiColors.accent,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: SushiColors.surface,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                onPressed: _controller.canConfirm
                    ? () => context.go('/orders')
                    : null,
                child: const Text(
                  'Подтвердить',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _field({
    required String label,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextField(
        onChanged: onChanged,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: SushiColors.surface,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _totalRow(String label, int amount, {bool emphasize = false}) {
    final style = TextStyle(
      fontWeight: emphasize ? FontWeight.w700 : FontWeight.w400,
      fontSize: emphasize ? 18 : 14,
      color: emphasize ? SushiColors.textPrimary : SushiColors.textMuted,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(formatRubles(amount), style: style),
        ],
      ),
    );
  }
}
