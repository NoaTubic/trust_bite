import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/widgets/custom_app_bar.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';

import 'package:food_safety/features/allergen_selection/domain/allergen.dart';
import 'package:food_safety/features/allergen_selection/presentation/notifiers/allergen_selection_notifier.dart';
import 'package:food_safety/features/allergen_selection/presentation/widgets/allergen_tile.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllergenSelectionPage extends ConsumerWidget {
  static const routeName = '/allergen-selection';
  const AllergenSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAllergens = ref.watch(allergenSelectionNotifierProvider);
    final notifier = ref.read(allergenSelectionNotifierProvider.notifier);

    return CustomScaffold(
      // appBar: CustomAppBar(
      //     title: 'Here you can select if you have any allergens  '),
      body: Column(
        children: [
          const Text(
            'Here you can select if you have any allergens',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: Allergen.values.length,
              itemBuilder: (context, index) {
                final allergen = Allergen.values[index];
                final isSelected = selectedAllergens.contains(allergen);

                return AllergenTile(
                  label: allergen.displayName,
                  iconData: allergen.iconData,
                  isSelected: isSelected,
                  onTap: () => notifier.toggleAllergen(allergen),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle confirmation logic
              print('Selected allergens: $selectedAllergens');
            },
            child: const Text('No Allergens'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Handle confirmation logic
              print('Selected allergens: $selectedAllergens');
            },
            child: const Text('Confirm allergens'),
          ),
        ],
      ),
    );
  }
}
