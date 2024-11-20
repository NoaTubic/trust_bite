import 'dart:io';

import 'package:either_dart/either.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:food_safety/core/data/error_resolvers/firebase_error_resolver.dart';
import 'package:food_safety/core/data/firestore/firestore_collections.dart';
import 'package:food_safety/features/allergen_selection/domain/allergen.dart';
import 'package:food_safety/features/auth/domain/entities/user.dart';
import 'package:food_safety/generated/l10n.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final usersRepositoryProvider = Provider<UsersRepository>(
  (ref) => UsersRepositoryImpl(FirebaseAuth.instance),
);

abstract class UsersRepository {
  EitherFailureOr<void> initializeUser();

  StreamFailureOr<FoodSafetyUser> getSignedInUser();

  Future<void> deleteSignedInUser();

  EitherFailureOr<List<FoodSafetyUser>> getUsers();

  StreamFailureOr<List<FoodSafetyUser>> getUsersStream();

  EitherFailureOr<void> changeProfilePicture(String imageUrl, String? userId);

  EitherFailureOr<void> removeProfilePicture(String? userId);

  EitherFailureOr<void> updateAllergens(
      String? userId, List<Allergen> allergens);
}

class UsersRepositoryImpl with ErrorToFailureMixin implements UsersRepository {
  final FirebaseAuth _firebaseAuth;
  final _usersCollection = FirestoreCollections.usersCollection;

  UsersRepositoryImpl(this._firebaseAuth);

  @override
  EitherFailureOr<void> initializeUser() async => execute(
        () async {
          final currentUser = _firebaseAuth.currentUser;

          final userDoc = await _usersCollection.doc(currentUser?.uid).get();
          if (!userDoc.exists) {
            await _usersCollection.doc(currentUser?.uid).set(
                  FoodSafetyUser(
                    id: currentUser!.uid,
                    username: currentUser.displayName!,
                    email: currentUser.email!,
                    photoUrl: currentUser.photoURL,
                    allergens: [],
                  ),
                );
          }
          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  StreamFailureOr<FoodSafetyUser> getSignedInUser() {
    final currentUser = _firebaseAuth.currentUser;

    return _usersCollection.doc(currentUser?.uid).snapshots().map(
      (snapshot) {
        final user = snapshot.data();
        return user != null ? Right(user) : Left(Failure.generic());
      },
    );
  }

  @override
  Future<void> deleteSignedInUser() {
    throw UnimplementedError();
  }

  @override
  EitherFailureOr<List<FoodSafetyUser>> getUsers() async => execute(
        () async {
          final users = await _usersCollection.get();
          return Right(users.docs.map((doc) => doc.data()).toList());
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  StreamFailureOr<List<FoodSafetyUser>> getUsersStream() {
    return _usersCollection.snapshots().map(
      (snapshot) {
        try {
          final users = snapshot.docs.map((doc) => doc.data()).toList();
          return Right(users);
        } catch (e) {
          return Left(const FirebaseErrorResolver().resolve(e));
        }
      },
    );
  }

  @override
  EitherFailureOr<void> changeProfilePicture(
          String imageUrl, String? userId) async =>
      execute(
        () async {
          final path = await _storeImage(imageUrl);
          final userDocRef =
              _usersCollection.doc(userId ?? _firebaseAuth.currentUser?.uid);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update(
              {
                'photoUrl': path,
              },
            );
          } else {
            return Left(Failure(title: S.current.user_not_found));
          }

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  @override
  EitherFailureOr<void> removeProfilePicture(String? userId) async => execute(
        () async {
          final userDocRef =
              _usersCollection.doc(userId ?? _firebaseAuth.currentUser?.uid);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update(
              {
                'photoUrl': '',
              },
            );
          } else {
            return Left(Failure(title: S.current.user_not_found));
          }

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );

  Future<String> _storeImage(
    String path,
  ) async {
    final imageRef = FirebaseStorage.instance.ref().child('photos').child(path);
    await imageRef.putFile(File(path));
    final imageUrl = await imageRef.getDownloadURL();
    return imageUrl;
  }

  @override
  EitherFailureOr<void> updateAllergens(
          String? userId, List<Allergen> allergens) async =>
      execute(
        () async {
          final userDocRef =
              _usersCollection.doc(userId ?? _firebaseAuth.currentUser?.uid);

          final userDoc = await userDocRef.get();
          if (userDoc.exists) {
            await userDocRef.update(
              {
                'allergens': allergens.map((e) => e.displayName).toList(),
              },
            );
          } else {
            return Left(Failure(title: S.current.user_not_found));
          }

          return const Right(null);
        },
        errorResolver: const FirebaseErrorResolver(),
      );
}
