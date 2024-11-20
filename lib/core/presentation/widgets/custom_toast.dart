//ignore_for_file: avoid-unused-parameters, avoid-returning-widgets
import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:food_safety/core/constants/duration_constants.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

class CustomToast extends StatelessWidget {
  final String message;
  const CustomToast({
    super.key,
    required this.message,
  });

  void show(BuildContext context) =>
      getFlushbar(context).show(rootNavigatorKey.currentState!.context);

  Flushbar getFlushbar(BuildContext context) => Flushbar(
        message: message,
        messageText: Padding(
          padding: const EdgeInsets.only(right: AppSizes.mediumSpacing),
          child: Center(
            child: Text(
              message,
              style: context.appTextStyles.text!.copyWith(
                color: context.appColors.textDark,
              ),
            ),
          ),
        ),
        icon: Icon(
          Icons.warning_amber_rounded,
          color: context.appColors.textDark,
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
