import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/back_button.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/core/presentation/widgets/custom_toast.dart';
import 'package:food_safety/core/presentation/widgets/logo.dart';
import 'package:food_safety/features/allergen_selection/presentation/pages/allergen_selection_page.dart';
import 'package:food_safety/features/auth/presentation/notifiers/login_notifier.dart';
import 'package:food_safety/features/auth/presentation/notifiers/registration_notifier.dart';
import 'package:food_safety/features/auth/presentation/widgets/registration_form.dart';
import 'package:food_safety/generated/l10n.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_notifier.dart';

class RegistrationPage extends ConsumerWidget {
  static const String routeName = '/registration';
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<BaseState<void>>(
      registrationNotifierProvider,
      (_, next) {
        return switch (next) {
          BaseData() => {
              context.pushNamed(AllergenSelectionPage.routeName),
              CustomToast(
                message: S.current.account_successfully_created,
              ).show(context),
            },
          BaseError(failure: final failure) => CustomToast(
              message: failure.title,
            ).show(context),
          _ => Object(),
        };
      },
    );
    return CustomScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Align(alignment: Alignment.topLeft, child: CustomBackButton()),
                Padding(
                  padding: const EdgeInsets.only(top: AppSizes.largeSpacing),
                  child: Center(
                    child: Logo(
                      size: AppSizes.logoSizeSmall,
                      color: context.appColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            Gap(AppSizes.mediumSpacing),
            RegistrationForm(
              onRegister: (name, email, password) => ref
                  .read(registrationNotifierProvider.notifier)
                  .register(name, email, password),
              onGoogleSignIn: () =>
                  ref.read(loginNotifierProvider.notifier).loginWithGoogle,
              onSignIn: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
