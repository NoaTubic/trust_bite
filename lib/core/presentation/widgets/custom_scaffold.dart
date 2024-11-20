import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';

class CustomScaffold extends StatelessWidget {
  final PreferredSizeWidget? appBar;
  final Widget body;
  final EdgeInsetsGeometry padding;
  final Color? backgroundColor;
  const CustomScaffold({
    super.key,
    this.appBar,
    required this.body,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSizes.bodyHorizontalPadding,
      vertical: AppSizes.bodyVerticalPadding,
    ),
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? Colors.white,
      resizeToAvoidBottomInset: true,
      appBar: appBar,
      body: SafeArea(
        child: Padding(
          padding: padding,
          child: body,
        ),
      ),
    );
  }
}
