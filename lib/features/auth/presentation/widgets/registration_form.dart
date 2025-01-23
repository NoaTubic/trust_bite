import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_safety/core/domain/utils/base_state_extensions.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/custom_button.dart';
import 'package:food_safety/core/presentation/widgets/custom_text_field.dart';
import 'package:food_safety/features/auth/presentation/notifiers/registration_notifier.dart';
import 'package:food_safety/features/auth/presentation/widgets/auth_helper_button.dart';
import 'package:food_safety/features/auth/presentation/widgets/or_section.dart';
import 'package:food_safety/features/auth/presentation/widgets/social_login_section.dart';
import 'package:food_safety/generated/l10n.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class RegistrationForm extends ConsumerWidget {
  final void Function(String name, String email, String password) onRegister;
  final VoidCallback? onSignIn;
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onFacebookSignIn;
  final VoidCallback? onAppleSignIn;

  const RegistrationForm({
    super.key,
    required this.onRegister,
    this.onSignIn,
    this.onGoogleSignIn,
    this.onFacebookSignIn,
    this.onAppleSignIn,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Sign up', style: context.appTextStyles.headingsBold),
          const Gap(AppSizes.normalSpacing),
          FormBuilder(
            key: formKey,
            child: Column(
              children: [
                CustomTextField.normal(
                  name: 'name',
                  label: S.current.name,
                  validator: FormBuilderValidators.required(),
                ),
                const Gap(AppSizes.normalSpacing),
                CustomTextField.email(
                  name: 'email',
                  label: S.current.email,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                const Gap(AppSizes.normalSpacing),
                CustomTextField.password(
                  name: 'password',
                  label: S.current.password,
                  validator: FormBuilderValidators.required(),
                ),
                const Gap(AppSizes.normalSpacing),
              ],
            ),
          ),
          const Gap(AppSizes.normalSpacing),
          CustomButton.primary(
            text: S.current.sign_up,
            context: context,
            onPressed: () => _onRegister(formKey),
            isLoading: ref.watch(registrationNotifierProvider).isLoading,
          ),
          const SizedBox(height: AppSizes.largeSpacing),
          OrSection(),
          SocialLoginSection(
            onGoogleSignIn: onGoogleSignIn,
            onFacebookSignIn: onFacebookSignIn,
            onAppleSignIn: onAppleSignIn,
          ),
          AuthHelperButton(
            onTap: onSignIn,
            helperText: S.current.already_have_account,
            buttonLabel: S.current.login,
          )
        ],
      ),
    );
  }

  void _onRegister(GlobalKey<FormBuilderState> formKey) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final name = formKey.currentState?.fields['name']?.value ?? '';
      final email = formKey.currentState?.fields['email']?.value ?? '';
      final password = formKey.currentState?.fields['password']?.value ?? '';
      onRegister(name, email, password);
    }
  }
}
