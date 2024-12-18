import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_safety/core/domain/utils/base_state_extensions.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/custom_button.dart';
import 'package:food_safety/core/presentation/widgets/custom_text_field.dart';
import 'package:food_safety/features/auth/presentation/notifiers/login_notifier.dart';
import 'package:food_safety/features/auth/presentation/widgets/auth_helper_button.dart';
import 'package:food_safety/features/auth/presentation/widgets/or_section.dart';
import 'package:food_safety/features/auth/presentation/widgets/social_login_section.dart';
import 'package:food_safety/generated/l10n.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginForm extends ConsumerWidget {
  final void Function(String email, String password) onLogin;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onSignUp;
  final VoidCallback? onGoogleSignIn;
  final VoidCallback? onFacebookSignIn;
  final VoidCallback? onAppleSignIn;

  const LoginForm({
    super.key,
    required this.onLogin,
    this.onForgotPassword,
    this.onSignUp,
    this.onGoogleSignIn,
    this.onFacebookSignIn,
    this.onAppleSignIn,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormBuilderState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilder(
          key: formKey,
          child: Column(
            children: [
              CustomTextField.email(
                name: 'email',
                label: S.current.email,
                validator: FormBuilderValidators.compose(
                  [
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.normalSpacing),
              CustomTextField.password(
                name: 'password',
                label: S.current.password,
                validator: FormBuilderValidators.required(),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: onForgotPassword,
                  child: Text(
                    S.current.forgot_password,
                    style: TextStyle(
                        color: context.appColors.primary,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(AppSizes.normalSpacing),
        CustomButton.primary(
          text: S.current.login,
          onPressed: () => _onLogin(formKey),
          context: context,
          isLoading: ref.watch(loginNotifierProvider).isLoading,
        ),
        const Gap(AppSizes.largeSpacing),
        OrSection(),
        SocialLoginSection(
          onGoogleSignIn: () =>
              ref.read(loginNotifierProvider.notifier).loginWithGoogle(),
        ),
        AuthHelperButton(
          helperText: S.current.dont_have_account,
          buttonLabel: S.current.sign_up,
          onTap: onSignUp,
        ),
      ],
    );
  }

  void _onLogin(GlobalKey<FormBuilderState> formKey) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final email = formKey.currentState?.fields['email']?.value ?? '';
      final password = formKey.currentState?.fields['password']?.value ?? '';
      onLogin(email, password);
    }
  }
}
