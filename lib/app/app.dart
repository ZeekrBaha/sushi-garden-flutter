import 'package:flutter/material.dart';
import 'package:sushi_garden_flutter/app/router.dart';
import 'package:sushi_garden_flutter/app/theme.dart';

class SushiGardenApp extends StatelessWidget {
  const SushiGardenApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Sushi Garden',
      theme: buildSushiTheme(),
      routerConfig: createRouter(),
    );
  }
}
