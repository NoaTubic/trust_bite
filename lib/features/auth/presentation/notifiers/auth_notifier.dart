// ignore_for_file: always_use_package_imports

import 'package:food_safety/features/auth/data/repository/auth_repository.dart';
import 'package:food_safety/features/auth/presentation/notifiers/auth_state.dart';
import 'package:food_safety/features/auth/presentation/notifiers/user_notifier.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

final authNotifierProvider = NotifierProvider<AuthNotifier, AuthState>(
  () => AuthNotifier(),
);

class AuthNotifier extends Notifier<AuthState> {
  late final AuthRepository _authRepository;

  @override
  AuthState build() {
    _authRepository = ref.watch(authRepositoryProvider);
    return const AuthState.unauthenticated();
  }

  Future<void> listenAuthChanges() async =>
      _authRepository.subscribeToAuthChanges().listen(
        (user) {
          final newState = user != null && user.emailVerified
              ? const AuthState.authenticated()
              : const AuthState.unauthenticated();
          if (state != newState) {
            if (newState is AuthStateAuthenticated) {
              ref.read(userProvider);
            }
            state = newState;
          }
        },
      );

  Future<void> logout() async {
    await _authRepository.logout();
    state = const AuthState.unauthenticated();
  }
}
