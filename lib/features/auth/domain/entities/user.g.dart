// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodSafetyUser _$FoodSafetyUserFromJson(Map<String, dynamic> json) =>
    FoodSafetyUser(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String? ?? '',
      areAllergensChecked: json['areAllergensChecked'] as bool? ?? false,
      allergens: (json['allergens'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$AllergenEnumMap, e))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$FoodSafetyUserToJson(FoodSafetyUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'areAllergensChecked': instance.areAllergensChecked,
      'allergens':
          instance.allergens.map((e) => _$AllergenEnumMap[e]!).toList(),
    };

const _$AllergenEnumMap = {
  Allergen.gluten: 'gluten',
  Allergen.milk: 'milk',
  Allergen.eggs: 'eggs',
  Allergen.nuts: 'nuts',
  Allergen.peanuts: 'peanuts',
  Allergen.celery: 'celery',
  Allergen.soybean: 'soybean',
  Allergen.lupin: 'lupin',
  Allergen.fish: 'fish',
  Allergen.crustaceans: 'crustaceans',
  Allergen.molluscs: 'molluscs',
  Allergen.sulphurDioxide: 'sulphurDioxide',
};
