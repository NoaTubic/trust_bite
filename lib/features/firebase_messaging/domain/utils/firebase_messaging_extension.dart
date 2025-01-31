import 'package:flutter/widgets.dart';
import 'package:food_safety/features/firebase_messaging/domain/entities/firebase_messaging_notification.dart';
import 'package:food_safety/features/firebase_messaging/presentation/notifiers/firebase_messaging_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:q_architecture/base_notifier.dart';

extension FirebaseMessagingExtensions on WidgetRef {
  void firebaseMessagingNotificationListener(BuildContext _) {
    listen<BaseState<FirebaseMessagingNotification>>(
      firebaseMessagingNotifierProvider,
      (previous, current) {
        switch (current) {
          case BaseData(data: final firebaseMessagingNotification):
            logDebug('to show $firebaseMessagingNotification');
          default:
            break;
        }
      },
    );
  }
}
