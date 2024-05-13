import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/base_tile.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/core/presentation/widgets/logo.dart';
import 'package:food_safety/features/scanner/presentation/pages/scanner_page.dart';
import 'package:food_safety/generated/l10n.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Logo(
                size: AppSizes.logoSizeSmall,
                color: context.appColors.primary,
              ),
              const SizedBox(width: AppSizes.normalSpacing),
              Text(
                S.current.hello,
                style: context.appTextStyles.subHeadings!
                    .copyWith(color: context.appColors.foreground!),
              ),
            ],
          ),
          const SizedBox(height: AppSizes.largeSpacing),
          BaseTile(
            label: S.current.scan_barcode,
            icon: FontAwesomeIcons.barcode,
            onTap: () => Navigator.of(context).pushNamed(ScannerPage.routeName),
          ),
        ],
      ),
    );
  }
}
