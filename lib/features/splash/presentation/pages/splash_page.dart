import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_safety/common/presentation/app_sizes.dart';
import 'package:food_safety/common/presentation/build_context_extensions.dart';
import 'package:food_safety/common/presentation/image_assets.dart';
import 'package:food_safety/common/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/common/presentation/widgets/logo.dart';
import 'package:food_safety/features/splash/presentation/noifiers/splash_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SplashPage extends ConsumerStatefulWidget {
  static const String routeName = '/';
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  Widget build(BuildContext context) {
    _subscribeToNextPageListener(context);

    return CustomScaffold(
      backgroundColor: context.appColors.primary,
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Logo(),
          ],
        ),
      ),
    );
  }

  void _subscribeToNextPageListener(BuildContext context) {
    ref.listen<String?>(splashNotifierProvider, (_, routeName) async {
      if (routeName != null) {
        Navigator.of(context).pushReplacementNamed(routeName);
      }
    });
  }
}
