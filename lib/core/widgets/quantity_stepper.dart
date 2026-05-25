import 'package:flutter/material.dart';
import 'package:sushi_garden_flutter/app/theme.dart';

/// Dark `−  n  +` pill used on the catalog, product detail and cart screens.
class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: SushiColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onDecrement,
            icon: const Icon(Icons.remove),
            iconSize: 18,
            visualDensity: VisualDensity.compact,
          ),
          Text(
            '$quantity',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          IconButton(
            onPressed: onIncrement,
            icon: const Icon(Icons.add),
            iconSize: 18,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
