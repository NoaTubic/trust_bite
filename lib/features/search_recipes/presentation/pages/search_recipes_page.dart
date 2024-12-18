import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/features/search_recipes/presentation/widgets/recipe_tile.dart';
import 'package:gap/gap.dart';

class SearchRecipesPage extends StatelessWidget {
  static const String routeName = '/search-recipes';
  const SearchRecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Search',
            style: context.appTextStyles.headingsBold,
          ),
          const SearchBarWidget(),
          Gap(AppSizes.normalSpacing),
          Expanded(
            child: ListView(
              children: const [
                RecipeTile(
                  title: 'Chicken parts',
                  subtitle: 'legs or thigh',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '1-2 days',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('if refrigerated from the date of purchase'),
                      SizedBox(height: 8),
                      Text(
                        '9 months',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text('if frozen from date of purchase'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'type here...',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: context.appColors.primary!.withOpacity(0.7),
            width: 2.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: context.appColors.primary!.withOpacity(0.7),
            width: 2.5,
          ),
        ),
      ),
    );
  }
}
