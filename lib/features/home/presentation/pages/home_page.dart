import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';

import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/core/presentation/widgets/user_profile_tile.dart';
import 'package:food_safety/features/home/presentation/widgets/expiration_date_home_calendar.dart';
import 'package:food_safety/features/home/presentation/widgets/products_list_view.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      body: Column(
        children: [
          UserProfileTile(),
          Gap(AppSizes.mediumSpacing),
          ExpirationDateHomeCalendar(),
          Gap(AppSizes.mediumSpacing),
          SearchBar(),
          Gap(AppSizes.mediumSpacing),
          Expanded(child: ProductListView()),
        ],
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
          borderRadius: AppSizes.smallCircularBorderRadius,
          border: Border.all(color: Colors.grey.shade200, width: 2.5)),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: AppSizes.smallSpacing),
          hintText: 'Type product name here...',
          hintStyle: context.appTextStyles.normalText!
              .copyWith(color: Colors.grey.shade300),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
