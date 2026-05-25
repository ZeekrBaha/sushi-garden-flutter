import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sushi_garden_flutter/app/theme.dart';

/// `Старт` frame: brand logo centred on the near-black background.
///
/// Tapping anywhere continues to the catalog. (The Figma logo asset is pending
/// export — see Task 10 — so the wordmark is rendered as text for now.)
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SushiColors.background,
      body: GestureDetector(
        onTap: () => context.go('/catalog'),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.ramen_dining, size: 96, color: SushiColors.accent),
              const SizedBox(height: 16),
              Text(
                'SUSHI GARDEN',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
