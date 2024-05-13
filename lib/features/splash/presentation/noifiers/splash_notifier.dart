import 'package:hooks_riverpod/hooks_riverpod.dart';

final splashNotifierProvider = StateNotifierProvider<SplashNotifier, String?>(
  (ref) => SplashNotifier()..getInitialRoute(),
);

class SplashNotifier extends StateNotifier<String?> {
  SplashNotifier() : super(null);

  Future<void> getInitialRoute() async {
    await Future.delayed(const Duration(seconds: 2));
    state = '';
  }
}
