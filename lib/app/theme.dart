import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract final class SushiColors {
  static const background = Color(0xFF0F0F0F);
  static const surface = Color(0xFF29282C);
  static const textPrimary = Colors.white;
  static const textMuted = Color(0xFF878787);
  static const divider = Color(0xFF333333);
  static const field = Color(0xFFF5F5FF);
  // Figma call-to-action red (rgb 0.925, 0.102, 0.208).
  static const accent = Color(0xFFEC1A35);
}

ThemeData buildSushiTheme() {
  final baseTextTheme = GoogleFonts.senTextTheme(ThemeData.dark().textTheme);

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: SushiColors.background,
    colorScheme: const ColorScheme.dark(
      primary: SushiColors.textPrimary,
      surface: SushiColors.surface,
      onSurface: SushiColors.textPrimary,
    ),
    textTheme: baseTextTheme.apply(
      bodyColor: SushiColors.textPrimary,
      displayColor: SushiColors.textPrimary,
    ),
    cardTheme: const CardThemeData(
      color: SushiColors.surface,
      margin: EdgeInsets.zero,
    ),
  );
}
