import 'package:flutter/material.dart';
import 'package:food_safety/common/presentation/app_sizes.dart';
import 'package:food_safety/common/presentation/build_context_extensions.dart';

class ScannerButton extends StatelessWidget {
  final IconData icon;
  final void Function()? onPressed;
  final bool isEnabled;

  const ScannerButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.isEnabled = true,
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
          child: Icon(
            icon,
            size: AppSizes.iconButtonSize,
            color: context.appColors.primary,
          ),
        ),
      ),
    );
  }
}
