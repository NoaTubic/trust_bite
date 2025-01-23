import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';

import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/features/expiration_date_tracker/presentation/widgets/expiration_date_tracker_calendar.dart';
import 'package:food_safety/features/home/presentation/widgets/products_list_view.dart';
import 'package:gap/gap.dart';

class ExpirationDateTrackerPage extends StatelessWidget {
  static const String routeName = 'expiration-date-tracker';
  const ExpirationDateTrackerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Expiration Dates',
            style: context.appTextStyles.headingsBold,
          ),
          Text('Here is your product list',
              style: context.appTextStyles.subHeadings),
          Gap(AppSizes.smallSpacing),
          ExpirationDateTrackerCalendar(),
          Gap(AppSizes.mediumSpacing),
          Expanded(child: ProductListView()),
        ],
      ),
    );
  }
}
