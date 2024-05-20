// ignore_for_file: deprecated_member_use

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';

class MobileScannerControllerWrapper extends Equatable {
  final MobileScannerController controller;

  MobileScannerControllerWrapper({
    CameraFacing facing = CameraFacing.back,
    DetectionSpeed detectionSpeed = DetectionSpeed.normal,
    int detectionTimeoutMs = 350,
    bool returnImage = false,
    Size? cameraResolution,
  }) : controller = MobileScannerController(
          autoStart: true,
          facing: facing,
          detectionSpeed: detectionSpeed,
          detectionTimeoutMs: detectionTimeoutMs,
          formats: [BarcodeFormat.code39],
          returnImage: returnImage,
          cameraResolution: cameraResolution,
          useNewCameraSelector: true,
        );

  Future<void> start({CameraFacing? cameraFacingOverride}) {
    return controller.start(cameraDirection: cameraFacingOverride);
  }

  Future<void> stop() async {
    await controller.stop();
  }

  Future<void> toggleTorch() async {
    await controller.toggleTorch();
  }

  Future<void> switchCamera() async {
    await controller.switchCamera();
  }

  Future<BarcodeCapture?> analyzeImage(String path) async {
    return controller.analyzeImage(path);
  }

  Future<void> setZoomScale(double zoomScale) async {
    await controller.setZoomScale(zoomScale);
  }

  Future<void> resetZoomScale() async {
    await controller.resetZoomScale();
  }

  void dispose() {
    controller.dispose();
  }

  Future<void> updateScanWindow(Rect? window) async {
    await controller.updateScanWindow(window);
  }

  Stream<BarcodeCapture> get barcodes => controller.barcodes;

  bool get isTorchEnabled => controller.torchEnabled;

  CameraFacing get cameraFacingState => controller.facing;

  @override
  List<Object?> get props => [
        controller.facing,
        controller.detectionSpeed,
        controller.detectionTimeoutMs,
        controller.torchEnabled,
        controller.formats,
        controller.returnImage,
        controller.cameraResolution,
      ];

  @override
  bool get stringify => true;
}
