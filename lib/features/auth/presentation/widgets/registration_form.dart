import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/custom_text_field.dart';
import 'package:food_safety/features/auth/presentation/widgets/social_login_section.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class RegistrationForm extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Sign up',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          FormBuilder(
            key: formKey,
            child: Column(
              children: [
                CustomTextField.normal(
                  name: 'name',
                  label: 'Name',
                  hintText: 'type here...',
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 16),
                CustomTextField.email(
                  name: 'email',
                  label: 'Email',
                  hintText: 'type here...',
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    FormBuilderValidators.email(),
                  ]),
                ),
                const SizedBox(height: 16),
                CustomTextField.password(
                  name: 'password',
                  label: 'Password',
                  hintText: 'type here...',
                  validator: FormBuilderValidators.required(),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.saveAndValidate() ?? false) {
                final name = formKey.currentState?.fields['name']?.value ?? '';
                final email =
                    formKey.currentState?.fields['email']?.value ?? '';
                final password =
                    formKey.currentState?.fields['password']?.value ?? '';
                onRegister(name, email, password);
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
            child: const Text('Sign Up'),
          ),
          const SizedBox(height: AppSizes.largeSpacing),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: context.appColors.primary,
                  thickness: 2,
                  indent: AppSizes.compactSpacing,
                  endIndent: AppSizes.compactSpacing,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text('Or continue with'),
              ),
              Expanded(
                child: Divider(
                  color: context.appColors.primary,
                  thickness: 2,
                  indent: AppSizes.compactSpacing,
                  endIndent: AppSizes.compactSpacing,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.normalSpacing),
          SocialLoginSection(
            onGoogleSignIn: onGoogleSignIn,
            onFacebookSignIn: onFacebookSignIn,
            onAppleSignIn: onAppleSignIn,
          ),
          const SizedBox(height: AppSizes.mediumSpacing),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Already have an account?'),
              TextButton(
                onPressed: onSignIn,
                child: Text(
                  'Sign In',
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
}
