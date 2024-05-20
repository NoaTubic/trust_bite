import 'dart:io';

import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_safety/core/constants/duration_constants.dart';
import 'package:food_safety/core/domain/failures/permission_failure.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/hooks/app_lifecycle_hook.dart';
import 'package:food_safety/features/product_details/presentation/pages/product_details_page.dart';
import 'package:food_safety/features/scanner/presentation/notifiers/scanner_notifier.dart';
import 'package:food_safety/features/scanner/presentation/notifiers/scanner_state.dart';
import 'package:food_safety/features/scanner/presentation/widgets/animated_scanner_overlay.dart';
import 'package:food_safety/features/scanner/presentation/widgets/scanner_button.dart';
import 'package:food_safety/generated/l10n.dart';
import 'package:food_safety/theme/fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:q_architecture/q_architecture.dart';

class ScannerPage extends HookConsumerWidget {
  static const String routeName = '/scanner';
  const ScannerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scannerNotifier = ref.read(scannerNotifierProvider.notifier);
    final scannerState = ref.watch(scannerNotifierProvider);
    final bool enableScannerButtons =
        scannerState.isInitialized && !scannerState.isLoading;

    _registerListeners(ref, context, scannerNotifier);
    _initializeScanner(
        ref.read(scannerNotifierProvider.notifier), scannerState);

    return Scaffold(
      body: Stack(
        children: [
          scannerState.isCameraPermissionGranted && scannerState.isInitialized
              ? Platform.isAndroid
                  ? Transform(
                      transform: Matrix4.diagonal3Values(1.35, 1, 1),
                      child: MobileScanner(
                        controller: scannerState.controllerWrapper!.controller,
                      ),
                    )
                  : MobileScanner(
                      controller: scannerState.controllerWrapper!.controller,
                    )
              : Container(
                  color: Colors.black.withOpacity(0.4),
                ),
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.bodyHorizontalPadding,
                vertical: AppSizes.mediumSpacing,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ScannerButton(
                    onPressed: () => scannerNotifier.toggleFlashlight(),
                    isEnabled: enableScannerButtons,
                    actionWidget: Stack(
                      children: [
                        Icon(
                          FontAwesomeIcons.bolt,
                          color: context.appColors.primary,
                        ),
                        AnimatedOpacity(
                          opacity: scannerState.isFlashlightOn ? 1 : 0,
                          duration: DurationConstants.shortAnimationDuration,
                          child: Icon(
                            FontAwesomeIcons.slash,
                            color: context.appColors.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                  const ScannerButton(
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

  void _initializeScanner(
      ScannerNotifier scannerNotifier, ScannerState scannerState) {
    useAppLifecycle(
      onInitialize: () {
        scannerNotifier.initialize();
      },
      onAppOpen: () {
        if (scannerState.failure == Failure.permissionDenied()) {
          scannerNotifier
            ..resetCameraPermissionRequest()
            ..initialize();
        } else {
          scannerNotifier.resumeScanner();
        }
        if (scannerState.failure ==
            const PermissionFailure(permission: Permission.photos)) {
          scannerNotifier.resetGalleryPermissionRequest();
        }
      },
      onAppClosed: () {
        scannerNotifier.pauseScanner();
        if (scannerState.isFlashlightOn) {
          scannerNotifier.toggleFlashlight();
        }
      },
    );
  }

  void _registerListeners(
      WidgetRef ref, BuildContext context, ScannerNotifier scannerNotifier) {
    ref.listen(
      scannerNotifierProvider,
      (previous, next) {
        if (previous == next) return;
        if (next.shouldNavigateToProductDetails) {
          Navigator.of(context).pushNamed(ProductDetailsPage.routeName);
        }
      },
    );
  }
}
