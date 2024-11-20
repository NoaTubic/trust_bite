import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/generated/l10n.dart';

class OrSection extends StatelessWidget {
  const OrSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: context.appColors.primary,
            thickness: 2,
            indent: AppSizes.tinySpacing,
            endIndent: AppSizes.smallSpacing,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.smallSpacing),
          child: Text(S.current.or_continue_with),
        ),
        Expanded(
          child: Divider(
            color: context.appColors.primary,
            thickness: 2,
            indent: AppSizes.tinySpacing,
            endIndent: AppSizes.smallSpacing,
          ),
        ),
      ],
    );
  }
}
