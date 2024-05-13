import 'package:flutter/material.dart';
import 'package:food_safety/common/presentation/app_sizes.dart';
import 'package:food_safety/common/presentation/build_context_extensions.dart';
import 'package:food_safety/common/presentation/widgets/base_tile.dart';
import 'package:food_safety/common/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/common/presentation/widgets/logo.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Logo(
                size: AppSizes.logoSizeSmall,
                color: context.appColors.primary,
              ),
              const SizedBox(width: AppSizes.normalSpacing),
              Text(
                'Hello, user!',
                style: context.appTextStyles.subHeadings!
                    .copyWith(color: context.appColors.foreground!),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.largeSpacing),
          BaseTile(
            label: 'Scan  product',
            icon: Icons.qr_code_scanner,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
