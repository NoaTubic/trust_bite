import 'package:flutter/material.dart';

abstract class AppSizes {
  static const double zero = 0;
  static const double size4 = 4;
  static const double size8 = 8;
  static const double size16 = 16;

  static const double extraSmallSpacing = 2;
  static const double tinySpacing = 4;
  static const double smallSpacing = 8;
  static const double compactSpacing = 12;
  static const double normalSpacing = 16;
  static const double mediumSpacing = 24;
  static const double largeSpacing = 32;
  static const double xlSpacing = 48;
  static const double xxlSpacing = 64;

  static const double bodyHorizontalPadding = 32;
  static const double bodyVerticalPadding = 20;

  static const double logoSizeSmall = 72;
  static const double logoSizeMedium = 88;
  static const double logoSize = 200;

  static const double smallIconSize = 16;

  static const double iconSize = 24;
  static const double iconButtonSize = 28;
  static const double largeIconSize = 41;

  static const double textFieldHeight = 52;

  static const double buttonHeight = 52;

  static const double userAvatarSize = 28;

  static const double smallCircularRadius = 8;
  static const double normalCircularRadius = 20;
  static const BorderRadiusGeometry normalCircularBorderRadius =
      BorderRadius.all(
    Radius.circular(normalCircularRadius),
  );
}
