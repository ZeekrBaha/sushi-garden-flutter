import 'package:flutter/foundation.dart';

@immutable
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.priceRubles,
    required this.weightGrams,
    required this.imageAsset,
    this.description = '',
  });

  final String id;
  final String name;
  final int priceRubles;
  final int weightGrams;
  final String imageAsset;
  final String description;

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Product &&
            other.id == id &&
            other.name == name &&
            other.priceRubles == priceRubles &&
            other.weightGrams == weightGrams &&
            other.imageAsset == imageAsset &&
            other.description == description;
  }

  @override
  int get hashCode {
    return Object.hash(
      id,
      name,
      priceRubles,
      weightGrams,
      imageAsset,
      description,
    );
  }
}

@immutable
class ProductCategory {
  const ProductCategory({required this.id, required this.title});

  final String id;
  final String title;
}

@immutable
class Promo {
  const Promo({
    required this.id,
    required this.title,
    required this.imageAsset,
  });

  final String id;
  final String title;
  final String imageAsset;
}

@immutable
class CartLine {
  const CartLine({required this.product, required this.quantity});

  final Product product;
  final int quantity;

  int get totalRubles => product.priceRubles * quantity;
  int get totalGrams => product.weightGrams * quantity;
}

@immutable
class AddOn {
  const AddOn({
    required this.id,
    required this.name,
    required this.priceRubles,
    required this.weightGrams,
  });

  final String id;
  final String name;
  final int priceRubles;
  final int weightGrams;
}

@immutable
class Order {
  const Order({
    required this.id,
    required this.title,
    required this.totalRubles,
  });

  final String id;
  final String title;
  final int totalRubles;
}

@immutable
class Delivery {
  const Delivery({
    required this.courierName,
    required this.etaLabel,
    required this.statusLabel,
  });

  final String courierName;
  final String etaLabel;
  final String statusLabel;
}

@immutable
class UserProfile {
  const UserProfile({
    required this.name,
    required this.email,
    required this.phone,
  });

  final String name;
  final String email;
  final String phone;
}
