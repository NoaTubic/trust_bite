// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "email_not_verified": MessageLookupByLibrary.simpleMessage(
            "Email not verified. Please check your email for verification link."),
        "google_sign_in_canceled":
            MessageLookupByLibrary.simpleMessage("Google sign in cancelled"),
        "hello": MessageLookupByLibrary.simpleMessage("Hello, user!"),
        "login_error_email_already_in_user":
            MessageLookupByLibrary.simpleMessage("Email already in use"),
        "login_error_wrong_credentials": MessageLookupByLibrary.simpleMessage(
            "Invalid email and password combination"),
        "permission_denied": MessageLookupByLibrary.simpleMessage(
            "Permission has been denied, please enable it in device settings"),
        "scan_barcode":
            MessageLookupByLibrary.simpleMessage("Scan product barcode"),
        "scanner_helper": MessageLookupByLibrary.simpleMessage(
            "Please align the barcode within the frame to scan"),
        "server_error":
            MessageLookupByLibrary.simpleMessage("Server error occurred"),
        "unknown_error_occurred":
            MessageLookupByLibrary.simpleMessage("Unknown error occurred"),
        "user_not_found":
            MessageLookupByLibrary.simpleMessage("User not found"),
        "weak_password": MessageLookupByLibrary.simpleMessage("Weak password")
      };
}
