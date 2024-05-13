import 'package:flutter/material.dart';

abstract class AppSizes {
  static const double size4 = 4;
  static const double size8 = 8;
  static const double size16 = 16;

  static const double smallSpacing = 8;

  static const double normalSpacing = 16;
  static const double mediumSpacing = 24;
  static const double largeSpacing = 32;

  static const double bodyHorizontalPadding = 16;
  static const double bodyVerticalPadding = 16;

  static const double logoSizeSmall = 52;
  static const double logoSize = 200;

  static const double normalCircularRadius = 8;
  static const BorderRadiusGeometry normalCircularBorderRadius =
      BorderRadius.all(
    Radius.circular(normalCircularRadius),
  );
}
