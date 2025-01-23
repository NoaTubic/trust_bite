// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_messaging_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseMessagingNotification _$FirebaseMessagingNotificationFromJson(
        Map<String, dynamic> json) =>
    FirebaseMessagingNotification(
      title: json['title'] as String?,
      body: json['body'] as String?,
      data: json['data'] as Map<String, dynamic>?,
      notificationStartedType: $enumDecodeNullable(
              _$NotificationStartedTypeEnumMap,
              json['notificationStartedType']) ??
          NotificationStartedType.onResume,
    );

Map<String, dynamic> _$FirebaseMessagingNotificationToJson(
        FirebaseMessagingNotification instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.body,
      'data': instance.data,
      'notificationStartedType':
          _$NotificationStartedTypeEnumMap[instance.notificationStartedType]!,
    };

const _$NotificationStartedTypeEnumMap = {
  NotificationStartedType.onLaunch: 'onLaunch',
  NotificationStartedType.onMessage: 'onMessage',
  NotificationStartedType.onResume: 'onResume',
};
