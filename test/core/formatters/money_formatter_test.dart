import 'package:flutter_test/flutter_test.dart';
import 'package:sushi_garden_flutter/core/formatters/money_formatter.dart';

void main() {
  test('formats rubles below a thousand without grouping', () {
    expect(formatRubles(620), '620 ₽');
  });

  test('groups thousands with a space like the Figma totals', () {
    expect(formatRubles(1820), '1 820 ₽');
  });

  test('formats zero', () {
    expect(formatRubles(0), '0 ₽');
  });

  test('groups millions with spaces', () {
    expect(formatRubles(1234567), '1 234 567 ₽');
  });
}
