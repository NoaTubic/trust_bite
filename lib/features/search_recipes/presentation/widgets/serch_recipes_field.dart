import 'package:flutter/material.dart';
import 'package:food_safety/features/search_recipes/presentation/notifiers/search_recipes_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

class SearchRecipesField extends ConsumerWidget {
  const SearchRecipesField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchRecipesNotifierProvider);
    final notifier = ref.read(searchRecipesNotifierProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Search Recipes',
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            notifier.searchProducts(
              [
                SearchTerms(terms: ['Nutella'])
              ],
            );
          },
          onChanged: (value) {
            notifier.fetchSuggestions(
              TagType.CATEGORIES,
              input: value,
              language: OpenFoodFactsLanguage.ENGLISH,
            );
          },
        ),
        if (state.isLoading) ...[
          const SizedBox(height: 10),
          const Center(child: CircularProgressIndicator()),
        ],
        if (state.suggestions.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: state.suggestions
                .map((suggestion) => Chip(label: Text(suggestion)))
                .toList(),
          ),
        ],
        if (state.errorMessage != null) ...[
          const SizedBox(height: 10),
          Text(
            state.errorMessage!,
            style: const TextStyle(color: Colors.red),
          ),
        ],
      ],
    );
  }
}
