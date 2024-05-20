import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:food_safety/core/constants/duration_constants.dart';
import 'package:food_safety/features/product_details/domain/usecases/get_product_details.dart';
import 'package:food_safety/features/scanner/data/mobile_scanner_controller_wrapper.dart';
import 'package:food_safety/features/scanner/domain/usecases/initialize_scanner.dart';
import 'package:food_safety/features/scanner/presentation/notifiers/scanner_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'package:q_architecture/q_architecture.dart';

final scannerNotifierProvider =
    StateNotifierProvider<ScannerNotifier, ScannerState>(
  (ref) => ScannerNotifier(
    ref.watch(initializeScannerUseCaseProvider),
    ref.watch(getProductDetailsUseCaseProvider),
    ref,
  ),
);

class ScannerNotifier extends SimpleStateNotifier<ScannerState> {
  final InitializeScanner _initializeScanner;
  final GetProductDetails _getProductDetails;
  ScannerNotifier(
    this._initializeScanner,
    this._getProductDetails,
    Ref ref,
  ) : super(
          ref,
          ScannerState.initial(),
        );

  StreamSubscription<BarcodeCapture>? _subscription;

  @override
  void dispose() {
    disposeScannerController();
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> initialize() async {
    final isScannerInitialized = await _initializeScannerController();

    if (!isScannerInitialized) {
      _setInitializationFailedState();
      return;
    } else {
      // await state.controllerWrapper!.controller.stop();
      _subscription =
          state.controllerWrapper!.controller.barcodes.listen((code) async {
        await onCodeDetected(code);
      });
      clearLoading();
    }
  }

  Future<bool> _initializeScannerController() async {
    final isInitialized = await _initializeScanner();

    return isInitialized.fold(
      (failure) => false,
      (success) {
        state = state.copyWith(
          isInitialized: true,
          isCameraPermissionGranted: true,
          isCameraPermissionRequested: true,
          controllerWrapper: MobileScannerControllerWrapper(
            cameraResolution: const Size(1080, 1920),
          ),
        );
        return true;
      },
    );
  }

  void _setInitializationFailedState() {
    state = state.copyWith(
      isInitialized: false,
      isCameraPermissionRequested: true,
      isCameraPermissionGranted: false,
      isLoading: false,
      failure: Failure.permissionDenied(),
    );
  }

  Future<void> onCodeDetected(BarcodeCapture barcode) async {
    await throttle(
      () async {
        log('Barcode detected: ${barcode.barcodes.first.displayValue}');
        // if (_shouldIgnoreDetection()) return;
        _prepareForCodeProcessing();
        await Future.delayed(
          const Duration(seconds: 1),
        );
        state = state.copyWith(
          shouldNavigateToProductDetails: true,
        );
        clearLoading();
        state = state.copyWith(
          shouldNavigateToProductDetails: false,
        );
        // await _processScannedCode(barcode);
      },
      duration: DurationConstants.scannerThrottleDuration,
    );
  }

  bool _shouldIgnoreDetection() {
    return state.isLoading;
  }

  void _prepareForCodeProcessing() {
    _resetFailure();
    setLoading();
  }

  Future<void> _processScannedCode(BarcodeCapture code) async {
    final scanResult =
        await _getProductDetails(code.barcodes.first.displayValue!);

    scanResult.fold(
      (failure) => state = state.copyWith(failure: failure),
      (routeWithData) {
        state = state.copyWith(
          failure: null,
          shouldNavigateToProductDetails: true,
        );
        clearLoading();
      },
    );
  }

  Future<void> pauseScanner() async {
    _subscription?.cancel();
    _subscription = null;
    await state.controllerWrapper!.controller.stop();
  }

  Future<void> resumeScanner() async {
    await state.controllerWrapper?.controller.start().whenComplete(
      () async {
        _subscription = state.controllerWrapper?.controller.barcodes.listen(
          (code) async {
            await onCodeDetected(code);
          },
        );
      },
    );
  }

  Future<void> resetCameraPermissionRequest() async =>
      state = state.copyWith(isCameraPermissionRequested: false);

  Future<void> resetGalleryPermissionRequest() async =>
      state = state.copyWith(isGalleryPermissionRequested: false);

  Future<void> toggleFlashlight() async {
    final isFlashlightOn = state.isFlashlightOn;
    await state.controllerWrapper!.controller.toggleTorch();
    state = state.copyWith(isFlashlightOn: !isFlashlightOn);
  }

  void setLoading() {
    showGlobalLoading();
    state = state.copyWith(isLoading: true);
  }

  void clearLoading() {
    clearGlobalLoading();
    state = state.copyWith(isLoading: false);
  }

  void _resetFailure() {
    state = state.copyWith(failure: null);
  }

  void disposeScannerController() {
    state.controllerWrapper?.controller.dispose();
  }
}
