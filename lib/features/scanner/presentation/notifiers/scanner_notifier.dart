import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_safety/core/constants/duration_constants.dart';
import 'package:food_safety/core/domain/failures/permission_failure.dart';
import 'package:food_safety/features/scanner/data/mobile_scanner_controller_wrapper.dart';
import 'package:food_safety/features/scanner/domain/failures/load_from_gallery_canceled_failure.dart';
import 'package:food_safety/features/scanner/domain/usecases/initialize_scanner.dart';
import 'package:food_safety/features/scanner/presentation/notifiers/scanner_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:q_architecture/q_architecture.dart';

final scannerNotifierProvider =
    StateNotifierProvider<ScannerNotifier, ScannerState>(
  (ref) => ScannerNotifier(
    ref.read(initializeScannerUseCaseProvider),
    ref,
  ),
);

class ScannerNotifier extends SimpleStateNotifier<ScannerState> {
  final InitializeScanner _initializeScanner;
  ScannerNotifier(this._initializeScanner, Ref ref)
      : super(
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
      await state.controllerWrapper!.controller.stop();
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
        if (_shouldIgnoreDetection()) return;

        _prepareForCodeProcessing();

        await _processScannedCode(barcode);
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
    // final scanResult =

    // scanResult.fold(
    //   (failure) => state.copyWith(failure: failure),
    //   (routeWithData) => (){},
    // );
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
