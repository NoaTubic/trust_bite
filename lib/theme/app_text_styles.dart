import 'package:flutter/material.dart';
import 'package:food_safety/theme/fonts.dart';

final class AppTextStyles extends ThemeExtension<AppTextStyles> {
  final TextStyle? normalText;
  final TextStyle? normalTextBold;
  final TextStyle? headings;
  final TextStyle? headingsBold;
  final TextStyle? subHeadings;
  final TextStyle? subHeadingsBold;

  const AppTextStyles({
    required this.normalText,
    required this.normalTextBold,
    required this.headings,
    required this.headingsBold,
    required this.subHeadings,
    required this.subHeadingsBold,
  });

  @override
  AppTextStyles copyWith({
    TextStyle? regular,
    TextStyle? bold,
    TextStyle? boldLarge,
  }) {
    return AppTextStyles(
      normalText: regular ?? normalText,
      normalTextBold: bold ?? normalTextBold,
      headings: bold ?? headings,
      headingsBold: boldLarge ?? headingsBold,
      subHeadings: boldLarge ?? subHeadings,
      subHeadingsBold: boldLarge ?? subHeadingsBold,
    );
  }

  @override
  AppTextStyles lerp(AppTextStyles? other, double t) {
    if (other is! AppTextStyles) {
      return this;
    }
    return AppTextStyles(
      normalText: TextStyle.lerp(normalText, other.normalText, t),
      normalTextBold: TextStyle.lerp(normalTextBold, other.normalTextBold, t),
      headings: TextStyle.lerp(headings, other.headings, t),
      headingsBold: TextStyle.lerp(headingsBold, other.headingsBold, t),
      subHeadings: TextStyle.lerp(subHeadings, other.subHeadings, t),
      subHeadingsBold:
          TextStyle.lerp(subHeadingsBold, other.subHeadingsBold, t),
    );
  }
}

AppTextStyles getAppTextStyles({required Color defaultColor}) {
  final baseTextStyle = TextStyle(
    color: defaultColor,
    fontSize: FontSizes.s12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
  return AppTextStyles(
    normalText: baseTextStyle,
    normalTextBold: baseTextStyle.copyWith(fontWeight: FontWeight.bold),
    headings: baseTextStyle.copyWith(fontSize: FontSizes.s20),
    headingsBold: baseTextStyle.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: FontSizes.s20,
    ),
    subHeadings: baseTextStyle.copyWith(fontSize: FontSizes.s16),
    subHeadingsBold: baseTextStyle.copyWith(
      fontWeight: FontWeight.bold,
      fontSize: FontSizes.s16,
    ),
  );
}
