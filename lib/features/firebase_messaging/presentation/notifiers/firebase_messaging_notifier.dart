import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:food_safety/features/firebase_messaging/data/repositories/firebase_messaging_repository.dart';
import 'package:food_safety/features/firebase_messaging/domain/entities/firebase_messaging_notification.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:q_architecture/base_notifier.dart';

final firebaseMessagingNotifierProvider = NotifierProvider.autoDispose<
    FirebaseMessagingNotifier, BaseState<FirebaseMessagingNotification>>(
  () => FirebaseMessagingNotifier(),
);

class FirebaseMessagingNotifier
    extends AutoDisposeBaseNotifier<FirebaseMessagingNotification> {
  late FirebaseMessagingRepository _firebaseMessagingRepository;

  FlutterLocalNotificationsPlugin? _flutterLocalNotificationsPlugin;

  @override
  void prepareForBuild() {
    _firebaseMessagingRepository =
        ref.watch(firebaseMessagingRepositoryProvider);
    ref.onDispose(() => _firebaseMessagingRepository.close());
    _init();
  }

  Future<void> _init() async {
    if (kIsWeb) return;

    final result = await _firebaseMessagingRepository.init();
    result.fold(setGlobalFailure, (_) {
      _getToken();
      _onTokenRefresh();
      _listenForNotification();

      _initializeFlutterLocalNotificationsPlugin();
    });
  }

  // ignore: avoid-redundant-async
  Future<void> _listenForNotification() async {
    await for (final result
        in _firebaseMessagingRepository.listenForNotifications()) {
      result.fold(
        setGlobalFailure,
        (notification) {
          if (notification.notificationStartedType ==
              NotificationStartedType.onMessage) {
            return _showLocalNotification(notification);
          }

          state = BaseState.data(notification);
        },
      );
    }
  }

  Future<void> _getToken() async {
    final result = await _firebaseMessagingRepository.getToken();
    result.fold((_) => null, (token) {
      logDebug('notification token: $token');
    });
  }

  // ignore: avoid-redundant-async
  Future<void> _onTokenRefresh() async {
    await for (final result in _firebaseMessagingRepository.onTokenRefresh()) {
      result.fold(
        (_) => null,
        (token) {
          logDebug('notification token changed: $token');
        },
      );
    }
  }

  Future<void> _initializeFlutterLocalNotificationsPlugin() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
      const initializationSettingsAndroid = AndroidInitializationSettings(
        '@drawable/ic_notification', // take a look at README.md push notification icon part
      );
      const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
      );
      await _flutterLocalNotificationsPlugin?.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) =>
            _parseLocalNotificationPayload(
          notificationResponse: details,
          notificationStartedType: NotificationStartedType.onResume,
        ),
      );
      final notificationAppLaunchDetails =
          await _flutterLocalNotificationsPlugin
              ?.getNotificationAppLaunchDetails();
      if (notificationAppLaunchDetails?.notificationResponse != null) {
        _parseLocalNotificationPayload(
          notificationResponse:
              notificationAppLaunchDetails!.notificationResponse!,
          notificationStartedType: NotificationStartedType.onLaunch,
        );
      }
    }
  }

  void _showLocalNotification(FirebaseMessagingNotification notification) {
    if (_flutterLocalNotificationsPlugin == null) return;
    final title = notification.title;
    final body = notification.body;
    if (title == null && body == null) {
      return;
    }
    _flutterLocalNotificationsPlugin?.show(
      notification.hashCode,
      title,
      body,
      _androidNotificationDetails(),
      payload: jsonEncode(notification.toJson()),
    );
  }

  void _parseLocalNotificationPayload({
    required NotificationResponse notificationResponse,
    required NotificationStartedType notificationStartedType,
  }) {
    try {
      final payloadJson = jsonDecode(notificationResponse.payload!);
      final notification = FirebaseMessagingNotification.fromJson(payloadJson);
      state = BaseState.data(notification.copyWith(
        notificationStartedType: notificationStartedType,
      ));
    } catch (e) {
      logDebug('_parseLocalNotificationPayload error: $e');
    }
  }

  NotificationDetails _androidNotificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
  }
}
