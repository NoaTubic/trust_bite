import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/theme/fonts.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color backgroundColor;
  final Color foregroundColor;
  final bool isLoading;

  const CustomButton({
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.foregroundColor,
    super.key,
    this.isLoading = false,
  });

  factory CustomButton.primary({
    required String text,
    required VoidCallback? onPressed,
    required BuildContext context,
    bool? isLoading = false,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: context.appColors.primary!,
      foregroundColor: context.appColors.textLight!,
      isLoading: isLoading!,
    );
  }

  factory CustomButton.secondary({
    required String text,
    required VoidCallback? onPressed,
    required BuildContext context,
    bool? isLoading = false,
  }) {
    return CustomButton(
      text: text,
      onPressed: onPressed,
      backgroundColor: context.appColors.background!,
      foregroundColor: context.appColors.primary!,
      isLoading: isLoading!,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: double.infinity, maxHeight: AppSizes.buttonHeight),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: foregroundColor,
          backgroundColor: backgroundColor,
          padding: const EdgeInsets.symmetric(vertical: AppSizes.normalSpacing),
          shape: RoundedRectangleBorder(
            side: BorderSide(color: foregroundColor),
            borderRadius: BorderRadius.circular(AppSizes.normalCircularRadius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: FontSizes.s16,
                width: FontSizes.s16,
                child: CircularProgressIndicator(
                  color: context.appColors.textLight,
                ),
              )
            : Text(
                text,
                style: context.appTextStyles.subHeadingsBold!
                    .copyWith(color: foregroundColor),
              ),
      ),
    );
  }
}
