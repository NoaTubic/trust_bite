import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/custom_text_field.dart';
import 'package:food_safety/features/auth/presentation/widgets/social_login_section.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';

class LoginForm extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          FormBuilder(
            key: formKey,
            child: Column(
              children: [
                CustomTextField.email(
                  name: 'email',
                  label: 'Email',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                const SizedBox(height: AppSizes.normalSpacing),
                CustomTextField.password(
                  name: 'password',
                  label: 'Password',
                  validator: FormBuilderValidators.required(),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: onForgotPassword,
                    child: Text(
                      'Forgot password',
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
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                final email =
                    formKey.currentState?.fields['email']?.value ?? '';
                final password =
                    formKey.currentState?.fields['password']?.value ?? '';
                onLogin(email, password);
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: context.appColors.textLight,
              backgroundColor: context.appColors.primary,
              padding:
                  const EdgeInsets.symmetric(vertical: AppSizes.normalSpacing),
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(AppSizes.normalCircularRadius),
              ),
            ),
            child: const Text('Login'),
          ),
          const Gap(AppSizes.largeSpacing),
          Row(
            children: [
              Expanded(child: Divider(color: Colors.grey)),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Or continue with'),
              ),
              Expanded(child: Divider(color: Colors.grey)),
            ],
          ),
          const Gap(AppSizes.mediumSpacing),
          SocialLoginSection(),
          const Gap(AppSizes.mediumSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Don\'t have an account?'),
              TextButton(
                onPressed: onSignUp,
                child: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: context.appColors.primary,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _socialButton(IconData icon, VoidCallback? onPressed) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: 32),
      color: Colors.black,
    );
  }
}
