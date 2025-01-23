import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/image_assets.dart';
import 'package:gap/gap.dart';

class ProfileTile extends StatelessWidget {
  final String icon;
  final String label;
  final VoidCallback onTap;
  const ProfileTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.bodyHorizontalPadding,
          vertical: AppSizes.smallSpacing,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppSizes.compactSpacing),
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppSizes.smallCircularRadius),
                color: Colors.grey[200],
              ),
              child: SvgPicture.asset(icon),
            ),
            Gap(AppSizes.compactSpacing),
            Text(label),
            Spacer(),
            SvgPicture.asset(ImageAssets.edit),
          ],
        ),
      ),
    );
  }
}
