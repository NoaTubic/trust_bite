import 'package:flutter/material.dart';
import 'package:food_safety/common/domain/router/pages.dart';
import 'package:food_safety/common/presentation/image_assets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashPage extends ConsumerWidget {
  static const routeName = Pages.splash;
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          ImageAssets.logo,
          width: 100,
        ),
      ),
    );
  }
}
