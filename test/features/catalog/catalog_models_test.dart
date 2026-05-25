import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/data/fake_catalog.dart';
import 'package:sushi_garden_flutter/features/catalog/catalog_models.dart';

void main() {
  test('fake catalog contains products visible in the Figma catalog', () {
    expect(
      fakeProducts,
      containsAll(<Product>[
        const Product(
          id: 'hikari',
          name: 'Хикари',
          priceRubles: 620,
          weightGrams: 255,
          imageAsset: 'assets/images/products/hikari.png',
          description:
              'креветка в темпуре, спайси тартар из тунца и лосося, рис для суси, нори, трюфельное масло, авокадо, темпура и тобико, васаби (9 шт.)',
        ),
        const Product(
          id: 'los-angeles',
          name: 'Лос-Анджелес',
          priceRubles: 707,
          weightGrams: 285,
          imageAsset: 'assets/images/products/los-angeles.png',
        ),
        const Product(
          id: 'osaka-maki',
          name: 'Осака маки',
          priceRubles: 740,
          weightGrams: 275,
          imageAsset: 'assets/images/products/osaka-maki.png',
        ),
        const Product(
          id: 'idaho-maki',
          name: 'Айдахо маки',
          priceRubles: 810,
          weightGrams: 285,
          imageAsset: 'assets/images/products/idaho-maki.png',
        ),
      ]),
    );
  });

  test('fake categories match Figma catalog filters', () {
    expect(
      fakeCategories.map((category) => category.title),
      orderedEquals(<String>[
        'Роллы',
        'Суши',
        'Горячие роллы',
        'Салаты',
        'WOK',
      ]),
    );
  });

  test('fake add-ons match cart screen add-ons', () {
    expect(
      fakeAddOns.map((addOn) => addOn.name),
      orderedEquals(<String>['Васаби', 'Имбирь', 'Соевый соус']),
    );
  });
}
