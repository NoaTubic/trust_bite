import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/image_assets.dart';
import 'package:food_safety/core/presentation/widgets/base_tile.dart';
import 'package:food_safety/core/presentation/widgets/custom_button.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/core/presentation/widgets/user_profile_tile.dart';
import 'package:food_safety/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:food_safety/features/product_details/presentation/pages/product_details_page.dart';
import 'package:food_safety/features/scanner/presentation/notifiers/scanner_notifier.dart';
import 'package:food_safety/features/scanner/presentation/pages/scanner_page.dart';
import 'package:gap/gap.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomePage extends ConsumerWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      body: Column(
        children: [
          UserProfileTile(),
          Gap(AppSizes.mediumSpacing),
          BaseTile(
            icon: ImageAssets.scanner,
            label: 'Scan products',
            onTap: () => context.pushNamed(ScannerPage.routeName),
          ),
        ],
      ),
    );
  }
}
