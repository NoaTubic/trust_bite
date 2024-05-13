// ignore_for_file: always_use_package_imports
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_text_styles.dart';

final primaryTheme = _getTheme(
  appColors: AppColors(
    primary: const Color(0xFFD65751),
    secondary: const Color(0xFFF69284),
    tertiary: const Color(0xFF193A66),
    foreground: const Color(0xFFFFFFFF),
    background: const Color(0xFF000000),
  ),
);

final secondaryTheme = _getTheme(
  appColors: AppColors(
    primary: const Color(0xFFD65751),
    secondary: const Color(0xFFF69284),
    tertiary: const Color(0xFF193A66),
    foreground: const Color(0xFFFFFFFF),
    background: const Color(0xFF000000),
  ),
);

ThemeData _getTheme({required AppColors appColors}) {
  return ThemeData(
    primarySwatch: Colors.cyan,
    colorScheme: ThemeData().colorScheme.copyWith(
          primary: appColors.primary,
          secondary: appColors.secondary,
        ),
    scaffoldBackgroundColor: appColors.background,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: appColors.primary,
      selectionColor: appColors.primary?.withOpacity(0.2),
      selectionHandleColor: appColors.primary,
    ),
    extensions: [
      appColors,
      getAppTextStyles(defaultColor: appColors.primary!),
    ],
  );
}
