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
    );

Map<String, dynamic> _$FoodSafetyUserToJson(FoodSafetyUser instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
    };
