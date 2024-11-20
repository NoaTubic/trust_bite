import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/theme/app_colors.dart';

class BaseTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final void Function()? onTap;
  final Widget? action;

  const BaseTile({
    super.key,
    required this.label,
    required this.icon,
    this.onTap,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.appColors.background,
      borderRadius: AppSizes.normalCircularBorderRadius,
      child: InkWell(
        onTap: (onTap),
        borderRadius: const BorderRadius.all(
          Radius.circular(
            AppSizes.normalCircularRadius,
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(AppSizes.normalSpacing),
          decoration: BoxDecoration(
            borderRadius: AppSizes.normalCircularBorderRadius,
            border: Border.all(
              color: context.appColors.foreground!.withOpacity(0.7),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: context.appColors.primary,
              ),
              const SizedBox(width: AppSizes.normalSpacing),
              Text(
                label,
                style: context.appTextStyles.normalText!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              action ?? const Icon(Icons.keyboard_arrow_right_rounded),
              const SizedBox(width: AppSizes.smallSpacing),
            ],
          ),
        ),
      ),
    );
  }
}
