import 'dart:typed_data';

import 'package:food_safety/features/scanner/data/mobile_scanner_controller_wrapper.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:q_architecture/q_architecture.dart';

part 'scanner_state.freezed.dart';

@freezed
class ScannerState with _$ScannerState {
  const factory ScannerState({
    required bool isInitialized,
    required bool isLoading,
    MobileScannerController? controllerWrapper,
    required bool isFlashlightOn,
    Failure? failure,
    required bool isCameraPermissionGranted,
    required bool isGalleryPermissionGranted,
    required bool isCameraPermissionRequested,
    required bool isGalleryPermissionRequested,
    required BarcodeCapture previousBarcodeCapture,
    required bool showGalleryPermissionDialog,
    required bool shouldNavigateToProductDetails,
  }) = _ScannerState;

  factory ScannerState.initial() => ScannerState(
      isLoading: true,
      isInitialized: false,
      isCameraPermissionGranted: false,
      isGalleryPermissionGranted: false,
      isCameraPermissionRequested: false,
      isGalleryPermissionRequested: false,
      isFlashlightOn: false,
      previousBarcodeCapture: BarcodeCapture(
        barcodes: [],
        image: Uint8List(0),
      ),
      showGalleryPermissionDialog: false,
      shouldNavigateToProductDetails: false);
}
