import 'package:food_safety/features/allergen_selection/domain/allergen.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class FoodSafetyUser {
  final String id;
  final String username;
  final String email;
  final String? photoUrl;
  final bool? areAllergensChecked;
  final List<Allergen> allergens;

  FoodSafetyUser({
    required this.id,
    required this.username,
    required this.email,
    this.photoUrl = '',
    this.areAllergensChecked = false,
    this.allergens = const [],
  });

  factory FoodSafetyUser.fromJson(Map<String, dynamic> json) =>
      _$FoodSafetyUserFromJson(json);

  Map<String, dynamic> toJson() => _$FoodSafetyUserToJson(this);
}
