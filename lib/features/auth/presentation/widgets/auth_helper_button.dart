import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';

class AuthHelperButton extends StatelessWidget {
  final String helperText;
  final String buttonLabel;
  final VoidCallback? onTap;
  const AuthHelperButton({
    super.key,
    required this.onTap,
    required this.helperText,
    required this.buttonLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(helperText),
        TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.extraSmallSpacing),
          ),
          child: Text(
            buttonLabel,
            style: context.appTextStyles.normalTextBold!
                .copyWith(color: context.appColors.primary),
          ),
        ),
      ],
    );
  }
}
