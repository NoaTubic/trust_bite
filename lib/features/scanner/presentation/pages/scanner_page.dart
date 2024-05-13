import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_safety/common/presentation/app_sizes.dart';
import 'package:food_safety/common/presentation/build_context_extensions.dart';
import 'package:food_safety/features/scanner/presentation/widgets/animated_scanner_overlay.dart';
import 'package:food_safety/features/scanner/presentation/widgets/scanner_button.dart';
import 'package:food_safety/generated/l10n.dart';
import 'package:food_safety/theme/fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ScannerPage extends ConsumerWidget {
  static const String routeName = '/scanner';
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          const AnimatedOverlay(),
          Padding(
            padding: EdgeInsets.only(bottom: context.screenHeight * 0.5),
            child: Center(
              child: SizedBox(
                width: context.screenWidth * 0.7,
                child: Text(
                  S.current.scanner_helper,
                  textAlign: TextAlign.center,
                  style: context.appTextStyles.text!.copyWith(
                    fontSize: FontSizes.s20,
                    fontWeight: FontWeight.bold,
                    color: context.appColors.background,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.bodyHorizontalPadding,
                vertical: AppSizes.largeSpacing,
              ),
              child: ScannerButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: FontAwesomeIcons.xmark,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.bodyHorizontalPadding,
                vertical: AppSizes.mediumSpacing,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScannerButton(
                    icon: FontAwesomeIcons.bolt,
                  ),
                  ScannerButton(
                    icon: FontAwesomeIcons.images,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
