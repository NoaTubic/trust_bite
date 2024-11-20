// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/core/presentation/widgets/custom_toast.dart';

import 'package:food_safety/core/presentation/widgets/logo.dart';
import 'package:food_safety/features/allergen_selection/presentation/pages/allergen_selection_page.dart';
import 'package:food_safety/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:food_safety/features/auth/presentation/notifiers/auth_state.dart';
import 'package:food_safety/features/auth/presentation/notifiers/login_notifier.dart';
import 'package:food_safety/features/auth/presentation/notifiers/user_notifier.dart';
import 'package:food_safety/features/auth/presentation/widgets/login_form.dart';
import 'package:food_safety/features/home/presentation/pages/home_page.dart';

import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_notifier.dart';

class LoginPage extends ConsumerWidget {
  static const String routeName = '/login';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<BaseState<void>>(
      loginNotifierProvider,
      (_, next) async {
        return switch (next) {
          BaseData() => {
              await ref.read(userProvider.notifier).getUser(),
              if (ref.read(authNotifierProvider) ==
                  const AuthState.authenticated())
                {
                  await ref.read(userProvider.notifier).getUser(),
                  Navigator.of(context).pushNamed(
                      ref.watch(userProvider)!.allergens.isEmpty
                          ? AllergenSelectionPage.routeName
                          : HomePage.routeName),
                },
            },
          BaseError(failure: final failure) => CustomToast(
              message: failure.title,
            ).show(context),
          _ => Object(),
        };
      },
    );

    return CustomScaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Logo(
                size: AppSizes.logoSizeMedium,
                color: context.appColors.primary,
              ),
            ),
            Gap(AppSizes.largeSpacing),
            Text(
              'Welcome back',
              style: context.appTextStyles.subHeadings,
            ),
            Gap(AppSizes.mediumSpacing),
            LoginForm(
              onLogin: (email, password) => ref
                  .read(loginNotifierProvider.notifier)
                  .login(email, password),
              onGoogleSignIn: () =>
                  ref.read(loginNotifierProvider.notifier).loginWithGoogle(),
              onSignUp: () => Navigator.of(context).pushNamed('/registration'),
            ),
          ],
        ),
      ),
    );
  }
}
