import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sushi_garden_flutter/app/theme.dart';

class TestApp extends StatelessWidget {
  const TestApp({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    GoogleFonts.config.allowRuntimeFetching = false;

    return MaterialApp(theme: buildSushiTheme(), home: child);
  }
}
