import 'package:flutter/material.dart';

final class AppColors extends ThemeExtension<AppColors> {
  final Color? primary;
  final Color? secondary;
  final Color? tertiary;
  final Color? foreground;
  final Color? background;
  final Color? textLight;
  final Color? textDark;
  final Color? error;

  AppColors({
    required this.primary,
    required this.secondary,
    required this.tertiary,
    required this.foreground,
    required this.background,
    required this.textLight,
    required this.textDark,
    required this.error,
  });

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? tertiary,
    Color? foreground,
    Color? background,
  }) {
    return AppColors(
      primary: primary ?? primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? tertiary,
      foreground: foreground ?? foreground,
      background: background ?? this.background,
      textLight: textLight ?? textLight,
      textDark: textDark ?? textDark,
      error: error ?? error,
    );
  }

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      primary: Color.lerp(primary, other.primary, t),
      secondary: Color.lerp(secondary, other.secondary, t),
      tertiary: Color.lerp(tertiary, other.tertiary, t),
      foreground: Color.lerp(foreground, other.foreground, t),
      background: Color.lerp(background, other.background, t),
      textLight: Color.lerp(textLight, other.textLight, t),
      textDark: Color.lerp(textDark, other.textDark, t),
      error: Color.lerp(error, other.error, t),
    );
  }
}
