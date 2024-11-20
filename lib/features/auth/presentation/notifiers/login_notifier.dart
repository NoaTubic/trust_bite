import 'package:food_safety/features/auth/data/repository/auth_repository.dart';
import 'package:food_safety/features/auth/domain/entities/user_credentials.dart';
import 'package:food_safety/features/auth/presentation/notifiers/user_notifier.dart';

import 'package:q_architecture/base_notifier.dart';

final loginNotifierProvider = BaseStateNotifierProvider<LoginNotifier, void>(
  (ref) => LoginNotifier(
    ref.read(authRepositoryProvider),
    ref,
  ),
);

class LoginNotifier extends BaseStateNotifier<void> {
  final AuthRepository _authRepository;

  LoginNotifier(this._authRepository, super.ref);

  Future<void> login(
    String email,
    String password,
  ) {
    showGlobalLoading();
    final userCredentials = UserCredentials(
      email: email,
      password: password,
    );
    return execute(
      _authRepository.login(userCredentials: userCredentials),
      onFailureOccurred: (failure) {
        state = BaseState.error(failure);
        return false;
      },
      globalLoading: true,
    );
  }

  Future<void> loginWithGoogle() =>
      execute(_authRepository.loginWithGoogle(), onFailureOccurred: (failure) {
        state = BaseState.error(failure);
        return false;
      }, globalLoading: true);

  Future<void> loginAnonymously() => execute(
        _authRepository.loginAnonymously(),
        onFailureOccurred: (failure) {
          state = BaseState.error(failure);
          return false;
        },
        onDataReceived: (_) =>
            ref.read(isAnonymousProvider.notifier).state = true,
      );
}
