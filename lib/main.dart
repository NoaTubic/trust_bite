// ignore_for_file: always_use_package_imports, library_prefixes

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:food_safety/core/domain/router/routes.dart';
import 'package:food_safety/firebase_options/firebase_options_dev.dart'
    as firebaseOptionsDev;
import 'package:food_safety/firebase_options/firebase_options_prod.dart'
    as firebaseOptionsProd;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'core/presentation/app_base_widget.dart';
import 'core/utils/custom_provider_observer.dart';
import 'core/utils/logger.dart';
import 'generated/l10n.dart';
import 'main/app_environment.dart';
import 'theme/theme.dart';

Future<void> mainCommon(AppEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: EnvInfo.isProduction
        ? firebaseOptionsProd.DefaultFirebaseOptions.currentPlatform
        : firebaseOptionsDev.DefaultFirebaseOptions.currentPlatform,
  );
  EnvInfo.initialize(environment);
  _registerErrorHandlers();
  Loggy.initLoggy(
    logPrinter: !EnvInfo.isProduction || kDebugMode
        ? StreamPrinter(const PrettyDeveloperPrinter())
        : const DisabledPrinter(),
  );

  void runAppCallback() => SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp],
      ).then(
        (_) => runApp(
          ProviderScope(
            observers: [CustomProviderObserver()],
            child: const AppStartupWidget(),
          ),
        ),
      );
  if (environment == AppEnvironment.PROD) {
    await SentryFlutter.init(
      (options) {
        options.dsn = 'DSN';
      },
      appRunner: runAppCallback,
    );
  } else {
    runAppCallback();
  }
}

final _appStartupProvider = FutureProvider((ref) {
  // here you can initialize all async dependencies like Firebase, SharedPreferences, etc.
});

class AppStartupWidget extends ConsumerWidget {
  const AppStartupWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStartupState = ref.watch(_appStartupProvider);
    return appStartupState.when(
      loading: () => const SizedBox(),
      error: (error, stackTrace) => MaterialApp(
        home: Scaffold(body: Center(child: Text(error.toString()))),
      ),
      data: (_) {
        return MaterialApp(
          debugShowCheckedModeBanner:
              EnvInfo.environment != AppEnvironment.PROD,
          title: EnvInfo.appTitle,
          theme: primaryTheme,
          // darkTheme: secondaryTheme,
          // themeMode: ThemeMode.system,
          localizationsDelegates: const [
            S.delegate,
            ...GlobalMaterialLocalizations.delegates,
          ],
          routes: routes,
          builder: (context, child) => Material(
            type: MaterialType.transparency,
            child: AppBaseWidget(child ?? const SizedBox()),
          ),
        );
      },
    );
  }
}

void _registerErrorHandlers() {
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    debugPrint(error.toString());
    return true;
  };
  ErrorWidget.builder = (FlutterErrorDetails details) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('Error'),
        ),
        body: Center(child: Text(details.toString())),
      );
}
