// ignore_for_file: always_use_package_imports
import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_safety/core/data/error_resolvers/firebase_error_resolver.dart';
import 'package:food_safety/core/data/firestore/firestore_collections.dart';
import 'package:food_safety/features/auth/data/model/registration_request.dart';
import 'package:food_safety/features/auth/data/repository/users_repository.dart';
import 'package:food_safety/features/auth/domain/entities/user.dart';
import 'package:food_safety/features/auth/domain/entities/user_credentials.dart';
import 'package:food_safety/generated/l10n.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    ref.watch(usersRepositoryProvider),
  ),
);

abstract interface class AuthRepository {
  EitherFailureOr<void> register({
    required RegistrationRequest registrationRequest,
  });

  EitherFailureOr<void> verifyEmail();

  EitherFailureOr<void> login({
    required UserCredentials userCredentials,
  });

  EitherFailureOr<void> loginWithGoogle();

  EitherFailureOr<void> loginAnonymously();

  Stream<User?> subscribeToAuthChanges();

  StreamFailureOr<FoodSafetyUser> getSignedInUser();

  Future<void> logout();
}

class AuthRepositoryImpl with ErrorToFailureMixin implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final UsersRepository _usersRepository;
  final _usersCollection = FirestoreCollections.usersCollection;

  AuthRepositoryImpl(this._usersRepository);

  @override
  EitherFailureOr<void> register({
    required RegistrationRequest registrationRequest,
  }) =>
      execute(
        () async {
          await _firebaseAuth.createUserWithEmailAndPassword(
            email: registrationRequest.email,
            password: registrationRequest.password,
          );
          await _firebaseAuth.currentUser!
              .updateDisplayName(registrationRequest.username);

          await _usersRepository.initializeUser();

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> verifyEmail() => execute(
        () async {
          final User? user = _firebaseAuth.currentUser;
          if (user != null && !user.emailVerified) {
            await user.sendEmailVerification();
          }
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> login({
    required UserCredentials userCredentials,
  }) =>
      execute(
        () async {
          await _firebaseAuth.signInWithEmailAndPassword(
            email: userCredentials.email,
            password: userCredentials.password,
          );

          // if (!_firebaseAuth.currentUser!.emailVerified) {
          //   return Left(Failure(title: S.current.email_not_verified));
          // }
          await _usersRepository.initializeUser();
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> loginWithGoogle() => execute(
        () async {
          final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
          if (googleUser == null) {
            return Left(
              Failure(title: S.current.google_sign_in_canceled),
            );
          } else {
            final googleAuth = await googleUser.authentication;
            final authCredential = GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken,
            );
            await _firebaseAuth.signInWithCredential(authCredential);
          }
          await _usersRepository.initializeUser();
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> loginAnonymously() => execute(
        () async {
          await _firebaseAuth.signInAnonymously();
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  Stream<User?> subscribeToAuthChanges() async* {
    yield* _firebaseAuth.authStateChanges();
  }

  @override
  StreamFailureOr<FoodSafetyUser> getSignedInUser() {
    final currentUser = _firebaseAuth.currentUser;
    return _usersCollection.doc(currentUser?.uid).snapshots().map((snapshot) {
      final user = snapshot.data();
      return user != null ? Right(user) : Left(Failure.generic());
    });
  }

  @override
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (_) {}
  }
}
