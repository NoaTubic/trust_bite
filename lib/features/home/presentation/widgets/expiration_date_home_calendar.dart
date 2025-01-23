import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/image_assets.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

class ExpirationDateHomeCalendar extends StatelessWidget {
  final int today = DateTime.now().day;

  ExpirationDateHomeCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(ImageAssets.restaurantMenu),
              Gap(AppSizes.smallSpacing),
              Text("Monthly leftovers and expirations",
                  style: context.appTextStyles.normalText),
            ],
          ),
          Gap(AppSizes.normalSpacing),
          Container(
            padding: EdgeInsets.all(AppSizes.smallSpacing),
            decoration: BoxDecoration(
              color: Color(0xFFEBE6E0),
              borderRadius: AppSizes.smallCircularBorderRadius,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(7, (index) {
                final date = DateTime.now().subtract(
                  Duration(days: DateTime.now().weekday - index - 1),
                );

                return Column(
                  children: [
                    Text(
                      DateFormat('E').format(date), // Weekday name
                      style: TextStyle(
                        fontWeight: today == date.day
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: today == date.day
                            ? context.appColors.tertiary
                            : Colors.black54,
                      ),
                    ),
                    Text(
                      '${date.day}',
                      style: TextStyle(
                        fontWeight: today == date.day
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: today == date.day
                            ? context.appColors.tertiary
                            : Colors.black54,
                      ),
                    ),
                    if (today == date.day)
                      Container(
                        margin: const EdgeInsets.only(top: 4),
                        height: 2,
                        width: 20,
                        color: context.appColors.tertiary,
                      ),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
