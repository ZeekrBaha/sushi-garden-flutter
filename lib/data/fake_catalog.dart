import 'package:sushi_garden_flutter/features/catalog/catalog_models.dart';

const fakeCategories = <ProductCategory>[
  ProductCategory(id: 'rolls', title: 'Роллы'),
  ProductCategory(id: 'sushi', title: 'Суши'),
  ProductCategory(id: 'hot-rolls', title: 'Горячие роллы'),
  ProductCategory(id: 'salads', title: 'Салаты'),
  ProductCategory(id: 'wok', title: 'WOK'),
];

const fakeProducts = <Product>[
  Product(
    id: 'hikari',
    name: 'Хикари',
    priceRubles: 620,
    weightGrams: 255,
    imageAsset: 'assets/images/products/hikari.png',
    description:
        'креветка в темпуре, спайси тартар из тунца и лосося, рис для суси, нори, трюфельное масло, авокадо, темпура и тобико, васаби (9 шт.)',
  ),
  Product(
    id: 'los-angeles',
    name: 'Лос-Анджелес',
    priceRubles: 707,
    weightGrams: 285,
    imageAsset: 'assets/images/products/los-angeles.png',
  ),
  Product(
    id: 'osaka-maki',
    name: 'Осака маки',
    priceRubles: 740,
    weightGrams: 275,
    imageAsset: 'assets/images/products/osaka-maki.png',
  ),
  Product(
    id: 'idaho-maki',
    name: 'Айдахо маки',
    priceRubles: 810,
    weightGrams: 285,
    imageAsset: 'assets/images/products/idaho-maki.png',
  ),
];

const fakeAddOns = <AddOn>[
  AddOn(id: 'wasabi', name: 'Васаби', priceRubles: 60, weightGrams: 10),
  AddOn(id: 'ginger', name: 'Имбирь', priceRubles: 60, weightGrams: 30),
  AddOn(id: 'soy-sauce', name: 'Соевый соус', priceRubles: 60, weightGrams: 30),
];
