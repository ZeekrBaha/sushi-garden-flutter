/// Formats a whole-ruble amount the way the Figma screens show it:
/// thousands grouped with a plain space and a trailing ` ₽`, e.g. `1 820 ₽`.
String formatRubles(int amount) {
  final digits = amount.abs().toString();
  final buffer = StringBuffer();

  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      buffer.write(' ');
    }
    buffer.write(digits[i]);
  }

  final sign = amount < 0 ? '-' : '';
  return '$sign$buffer ₽';
}
