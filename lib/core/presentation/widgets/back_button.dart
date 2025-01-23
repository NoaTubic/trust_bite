import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onPressed;

  final double size;

  const CustomBackButton({
    super.key,
    this.onPressed,
    this.size = 40.0,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed ?? () => Navigator.of(context).maybePop(),
      borderRadius: BorderRadius.circular(size / 2),
      child: Container(
        decoration: BoxDecoration(
          color: context.appColors.primary!.withOpacity(0.8),
          shape: BoxShape.circle,
        ),
        width: size,
        height: size,
        child: Center(
          child: Icon(
            Icons.chevron_left,
            color: context.appColors.background,
            size: size * 0.6,
          ),
        ),
      ),
    );
  }
}
