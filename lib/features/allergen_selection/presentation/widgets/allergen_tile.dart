import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/back_button.dart';

class AllergenTile extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  const AllergenTile({
    super.key,
    required this.label,
    required this.iconData,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.compactSpacing),
        decoration: BoxDecoration(
          color: context.appColors.secondary,
          borderRadius: BorderRadius.circular(AppSizes.normalCircularRadius),
          border: Border.all(
            color: isSelected
                ? context.appColors.primary!
                : context.appColors.secondary!,
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              color:
                  isSelected ? context.appColors.primary : Colors.grey.shade700,
              size: 32,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: isSelected
                      ? context.appColors.primary
                      : Colors.grey.shade700,
                  fontWeight: FontWeight.w500,
                  fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
