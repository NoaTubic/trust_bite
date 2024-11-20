//ignore_for_file: avoid-unused-parameters, avoid-returning-widgets
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:food_safety/core/constants/duration_constants.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';

class CustomToast extends StatelessWidget {
  bool isWarning;
  final String message;

  CustomToast({
    super.key,
    required this.message,
    this.isWarning = true,
  });

  void show(BuildContext context) => getFlushbar(context).show(context);

  Flushbar getFlushbar(BuildContext context) => Flushbar(
        message: message,
        messageText: Padding(
          padding: const EdgeInsets.only(right: AppSizes.mediumSpacing),
          child: Center(
            child: Text(
              message,
              style: context.appTextStyles.normalText!.copyWith(
                color: context.appColors.textDark,
              ),
            ),
          ),
        ),
        icon: isWarning
            ? Icon(
                Icons.warning_amber_rounded,
                color: context.appColors.error,
              )
            : Icon(
                Icons.check_circle,
                color: context.appColors.primary,
              ),
        borderRadius: const BorderRadius.all(
          Radius.circular(AppSizes.normalCircularRadius),
        ),
        maxWidth:
            MediaQuery.of(context).size.width - AppSizes.bodyHorizontalPadding,
        margin: Platform.isAndroid
            ? const EdgeInsets.only(bottom: AppSizes.xlSpacing)
            : EdgeInsets.zero,
        flushbarStyle: FlushbarStyle.FLOATING,
        borderColor: context.appColors.primary,
        backgroundColor: context.appColors.background!,
        duration: DurationConstants.toastDuration,
        isDismissible: true,
        flushbarPosition: FlushbarPosition.BOTTOM,
        dismissDirection: FlushbarDismissDirection.HORIZONTAL,
      );

  @override
  Widget build(BuildContext context) => getFlushbar(context);
}
