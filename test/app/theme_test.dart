import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_garden_flutter/app/theme.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  GoogleFonts.config.allowRuntimeFetching = false;

  test('SushiColors exposes Figma dark palette', () {
    expect(SushiColors.background, const Color(0xFF0F0F0F));
    expect(SushiColors.surface, const Color(0xFF29282C));
    expect(SushiColors.textPrimary, Colors.white);
    expect(SushiColors.textMuted, const Color(0xFF878787));
  });

  test('buildSushiTheme uses the dark Figma scaffold color', () {
    final theme = buildSushiTheme();

    expect(theme.scaffoldBackgroundColor, SushiColors.background);
    expect(theme.colorScheme.surface, SushiColors.surface);
    expect(theme.brightness, Brightness.dark);
  });
}
