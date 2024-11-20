import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/theme/fonts.dart';
import 'package:gap/gap.dart';

class AllergenTile extends StatelessWidget {
  final String label;
  final String icon;
  final bool isSelected;
  final VoidCallback onTap;

  const AllergenTile({
    super.key,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(AppSizes.smallSpacing),
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
            SvgPicture.asset(
              icon,
              width: AppSizes.largeIconSize,
              height: AppSizes.largeIconSize,
            ),
            const Gap(AppSizes.tinySpacing),
            Text(
              label,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: context.appTextStyles.normalTextBold!.copyWith(
                  color: context.appColors.primary, fontSize: FontSizes.s12),
            ),
          ],
        ),
      ),
    );
  }
}
