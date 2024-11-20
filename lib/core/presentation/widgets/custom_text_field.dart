import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/features/splash/presentation/pages/splash_page.dart';

class CustomTextField extends StatelessWidget {
  final String name;
  final String label;
  final String? hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.name,
    required this.label,
    this.hintText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.validator,
  });

  // Factory constructor for a normal text field
  factory CustomTextField.normal({
    required String name,
    required String label,
    String? hintText,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
  }) {
    return CustomTextField(
      name: name,
      label: label,
      hintText: hintText,
      controller: controller,
      validator: validator,
    );
  }

  // Factory constructor for a password field
  factory CustomTextField.password({
    required String name,
    required String label,
    String? hintText,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
  }) {
    return CustomTextField(
      name: name,
      label: label,
      hintText: hintText ?? 'Enter your password',
      obscureText: true,
      keyboardType: TextInputType.text,
      controller: controller,
      validator: validator,
    );
  }

  // Factory constructor for an email field
  factory CustomTextField.email({
    required String name,
    required String label,
    String? hintText,
    TextEditingController? controller,
    FormFieldValidator<String>? validator,
  }) {
    return CustomTextField(
      name: name,
      label: label,
      hintText: hintText ?? 'Enter your email',
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      validator: validator,
    );
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: name,
      validator: validator,
      builder: (FormFieldState<String?> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: controller,
              obscureText: obscureText,
              keyboardType: keyboardType,
              onChanged: (value) => field.didChange(value),
              decoration: InputDecoration(
                hintText: hintText ?? 'Enter $label',
                enabledBorder: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSizes.normalCircularRadius),
                  borderSide:
                      BorderSide(color: context.appColors.primary!, width: 2),
                ),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSizes.normalCircularRadius),
                  borderSide:
                      BorderSide(color: context.appColors.primary!, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                hintStyle: TextStyle(
                  color: context.appColors.textDark!.withOpacity(0.5),
                  fontSize: 16,
                ),
              ),
            ),
            if (field.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: Text(
                  field.errorText ?? '',
                  style: TextStyle(color: Colors.red),
                ),
              ),
          ],
        );
      },
    );
  }
}
