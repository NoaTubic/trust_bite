import 'package:food_safety/features/auth/data/repository/auth_repository.dart';
import 'package:food_safety/features/auth/domain/entities/user.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:q_architecture/q_architecture.dart';

final userProvider = StateNotifierProvider<UserNotifier, FoodSafetyUser?>(
  (ref) {
    return UserNotifier(
      ref.watch(authRepositoryProvider),
      ref,
    )..getUser();
  },
);

final isAnonymousProvider = StateProvider<bool>((ref) => false);

class UserNotifier extends SimpleStateNotifier<FoodSafetyUser?> {
  final AuthRepository _authRepository;

  UserNotifier(this._authRepository, Ref ref) : super(ref, null);

  Future<FoodSafetyUser?> getUserAsync() async {
    _authRepository.getSignedInUser().listen(
      (user) {
        user.fold(
          (failure) => null,
          (user) {
            state = user;
          },
        );
      },
    );
    return null;
  }

  Future<void> getUser() async => _authRepository.getSignedInUser().listen(
        (user) {
          user.fold(
            (failure) => null,
            (user) {
              state = user;
            },
          );
        },
      );
}
