// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Unknown error occurred`
  String get unknown_error_occurred {
    return Intl.message(
      'Unknown error occurred',
      name: 'unknown_error_occurred',
      desc: '',
      args: [],
    );
  }

  /// `Permission has been denied, please enable it in device settings`
  String get permission_denied {
    return Intl.message(
      'Permission has been denied, please enable it in device settings',
      name: 'permission_denied',
      desc: '',
      args: [],
    );
  }

  /// `Hello, user!`
  String get hello {
    return Intl.message(
      'Hello, user!',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `Scan product barcode`
  String get scan_barcode {
    return Intl.message(
      'Scan product barcode',
      name: 'scan_barcode',
      desc: '',
      args: [],
    );
  }

  /// `Please align the barcode within the frame to scan`
  String get scanner_helper {
    return Intl.message(
      'Please align the barcode within the frame to scan',
      name: 'scanner_helper',
      desc: '',
      args: [],
    );
  }

  /// `Invalid email and password combination`
  String get login_error_wrong_credentials {
    return Intl.message(
      'Invalid email and password combination',
      name: 'login_error_wrong_credentials',
      desc: '',
      args: [],
    );
  }

  /// `Email already in use`
  String get login_error_email_already_in_user {
    return Intl.message(
      'Email already in use',
      name: 'login_error_email_already_in_user',
      desc: '',
      args: [],
    );
  }

  /// `Weak password`
  String get weak_password {
    return Intl.message(
      'Weak password',
      name: 'weak_password',
      desc: '',
      args: [],
    );
  }

  /// `Server error occurred`
  String get server_error {
    return Intl.message(
      'Server error occurred',
      name: 'server_error',
      desc: '',
      args: [],
    );
  }

  /// `Email not verified. Please check your email for verification link.`
  String get email_not_verified {
    return Intl.message(
      'Email not verified. Please check your email for verification link.',
      name: 'email_not_verified',
      desc: '',
      args: [],
    );
  }

  /// `Google sign in cancelled`
  String get google_sign_in_canceled {
    return Intl.message(
      'Google sign in cancelled',
      name: 'google_sign_in_canceled',
      desc: '',
      args: [],
    );
  }

  /// `User not found`
  String get user_not_found {
    return Intl.message(
      'User not found',
      name: 'user_not_found',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
