import 'package:food_safety/features/allergen_selection/domain/allergen.dart';
import 'package:food_safety/features/auth/data/repository/users_repository.dart';
import 'package:food_safety/features/auth/presentation/notifiers/user_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final allergenSelectionNotifierProvider =
    StateNotifierProvider<AllergenSelectionNotifier, Set<Allergen>>(
  (ref) => AllergenSelectionNotifier(
    ref.watch(usersRepositoryProvider),
    ref,
  ),
);

class AllergenSelectionNotifier extends SimpleStateNotifier<Set<Allergen>> {
  final UsersRepository _usersRepository;

  AllergenSelectionNotifier(this._usersRepository, Ref ref) : super(ref, {});

  Future<void> setAllergens({bool noAllergens = false}) async {
    final userId = ref.read(userProvider)!.id;
    await _usersRepository.updateAllergens(
        userId, noAllergens ? [] : state.toList());
  }

  void toggleAllergen(Allergen allergen) {
    if (state.contains(allergen)) {
      state = {...state}..remove(allergen);
    } else {
      state = {...state}..add(allergen);
    }
  }
}
