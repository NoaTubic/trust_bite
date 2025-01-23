import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';

class ScannerButton extends StatelessWidget {
  final IconData? icon;
  final void Function()? onPressed;
  final bool isEnabled;
  final Widget? actionWidget;

  const ScannerButton({
    super.key,
    this.icon,
    this.onPressed,
    this.isEnabled = true,
    this.actionWidget,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: IconButton(
        onPressed: onPressed,
        icon: CircleAvatar(
          radius: AppSizes.iconButtonSize,
          backgroundColor: Colors.white,
          child: actionWidget ??
              Icon(
                icon,
                size: AppSizes.iconButtonSize,
                color: context.appColors.primary,
              ),
        ),
      ),
    );
  }
}
