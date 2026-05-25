import 'package:sushi_garden_flutter/features/catalog/catalog_models.dart';

class CartController {
  final Map<String, CartLine> _lines = <String, CartLine>{};

  List<CartLine> get lines => List.unmodifiable(_lines.values);

  int get itemCount {
    return _lines.values.fold(0, (total, line) => total + line.quantity);
  }

  int get totalRubles {
    return _lines.values.fold(0, (total, line) => total + line.totalRubles);
  }

  int get totalGrams {
    return _lines.values.fold(0, (total, line) => total + line.totalGrams);
  }

  int quantityFor(String productId) => _lines[productId]?.quantity ?? 0;

  void add(Product product) {
    final current = _lines[product.id];
    _lines[product.id] = CartLine(
      product: product,
      quantity: (current?.quantity ?? 0) + 1,
    );
  }

  void decrement(String productId) {
    final current = _lines[productId];
    if (current == null) {
      return;
    }

    if (current.quantity <= 1) {
      _lines.remove(productId);
      return;
    }

    _lines[productId] = CartLine(
      product: current.product,
      quantity: current.quantity - 1,
    );
  }
}
