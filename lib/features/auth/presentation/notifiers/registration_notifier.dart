import 'package:food_safety/features/auth/data/model/registration_request.dart';
import 'package:food_safety/features/auth/data/repository/auth_repository.dart';
import 'package:q_architecture/base_notifier.dart';

final registrationNotifierProvider =
    BaseStateNotifierProvider<RegistrationNotifier, void>(
  (ref) => RegistrationNotifier(
    ref.read(authRepositoryProvider),
    ref,
  ),
);

class RegistrationNotifier extends BaseStateNotifier<void> {
  final AuthRepository _authRepository;

  RegistrationNotifier(
    this._authRepository,
    super.ref,
  );

  Future<void> register(
    String name,
    String email,
    String password,
  ) {
    final registrationRequest = RegistrationRequest(
      username: name,
      email: email,
      password: password,
    );
    return execute(
      _authRepository.register(registrationRequest: registrationRequest),
      onFailureOccurred: (failure) {
        state = BaseState.error(failure);
        return false;
      },
      onDataReceived: (_) {
        _authRepository.verifyEmail();
        return true;
      },
      globalLoading: true,
    );
  }

  Future<void> verifyEmail() async => _authRepository.verifyEmail();
}
