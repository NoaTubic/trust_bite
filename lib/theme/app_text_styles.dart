import 'package:flutter/material.dart';

final class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle? text;
  final TextStyle? headings;
  final TextStyle? subHeadings;

  const AppTextStyles({
    required this.text,
    required this.headings,
    required this.subHeadings,
  });

  @override
  AppTextStyles copyWith({
    TextStyle? regular,
    TextStyle? bold,
    TextStyle? boldLarge,
  }) {
    return AppTextStyles(
      text: regular ?? text,
      headings: bold ?? headings,
      subHeadings: boldLarge ?? subHeadings,
    );
  }

  @override
  AppTextStyles lerp(AppTextStyles? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      text: TextStyle.lerp(text, other.text, t),
      headings: TextStyle.lerp(headings, other.headings, t),
      subHeadings: TextStyle.lerp(subHeadings, other.subHeadings, t),
    );
  }
}

AppTextStyles getAppTextStyles({required Color defaultColor}) {
  final baseTextStyle = TextStyle(
    color: defaultColor,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  return AppTextStyles(
    text: baseTextStyle,
    headings: baseTextStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 32),
    subHeadings:
        baseTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 24),
  );
}
