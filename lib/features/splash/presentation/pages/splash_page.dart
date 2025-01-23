import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';

import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/core/presentation/widgets/logo.dart';
import 'package:food_safety/features/auth/presentation/notifiers/auth_notifier.dart';
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
    ref.watch(authNotifierProvider.notifier).listenAuthChanges();

    ref.listen<String?>(splashNotifierProvider, (_, routeName) async {
      if (routeName != null) {
        context.pushReplacementNamed(routeName);
      }
    });
  }
}
