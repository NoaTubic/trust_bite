import 'package:food_safety/features/allergen_selection/domain/allergen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllergenSelectionNotifier extends StateNotifier<Set<Allergen>> {
  AllergenSelectionNotifier() : super({});

  void toggleAllergen(Allergen allergen) {
    if (state.contains(allergen)) {
      state = {...state}..remove(allergen);
    } else {
      state = {...state}..add(allergen);
    }
  }
}

final allergenSelectionNotifierProvider =
    StateNotifierProvider<AllergenSelectionNotifier, Set<Allergen>>(
  (ref) => AllergenSelectionNotifier(),
);
