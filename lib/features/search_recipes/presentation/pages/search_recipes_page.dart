import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/image_assets.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/features/search_recipes/presentation/notifiers/search_recipes_notifier.dart';
import 'package:food_safety/features/search_recipes/presentation/widgets/recipe_tile.dart';
import 'package:food_safety/features/search_recipes/presentation/widgets/serch_recipes_field.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SearchRecipesPage extends ConsumerWidget {
  static const String routeName = '/search-recipes';
  const SearchRecipesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchRecipesNotifierProvider);
    return CustomScaffold(
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Search',
          style: context.appTextStyles.headingsBold,
        ),
        Gap(AppSizes.normalSpacing),
        const SearchRecipesField(),
        Gap(AppSizes.normalSpacing),
        Expanded(
          child: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : state.recipes.isNotEmpty
                  ? ListView.builder(
                      itemCount: state.recipes.length,
                      itemBuilder: (context, index) {
                        final recipe = state.recipes[index];
                        return RecipeTile(
                          title: recipe.productName ?? 'Unknown',
                          subtitle: recipe.brands ?? 'No brand',
                          content: Text(recipe.ingredientsText ?? 'No details'),
                        );
                      },
                    )
                  : Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(ImageAssets.search),
                          Gap(AppSizes.compactSpacing),
                          Text('Start searching for recipes'),
                        ],
                      ),
                    ),
        ),
      ]),
    );
  }
}
