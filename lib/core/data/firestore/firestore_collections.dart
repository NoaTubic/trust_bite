import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_safety/core/data/firestore/firestore_constants.dart';
import 'package:food_safety/features/auth/domain/entities/user.dart';

class FirestoreCollections {
  static final usersCollection = FirebaseFirestore.instance
      .collection(FirestoreConstants.users)
      .withConverter<FoodSafetyUser>(
        fromFirestore: (data, _) => FoodSafetyUser.fromJson(data.data() ?? {}),
        toFirestore: (data, _) => data.toJson(),
      );
}
