import 'package:food_safety/features/allergen_selection/presentation/pages/allergen_selection_page.dart';
import 'package:food_safety/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:food_safety/features/auth/presentation/notifiers/auth_state.dart';
import 'package:food_safety/features/auth/presentation/pages/login_page.dart';
import 'package:food_safety/features/home/presentation/pages/home_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final splashNotifierProvider = StateNotifierProvider<SplashNotifier, String?>(
  (ref) => SplashNotifier(ref)..getInitialRoute(),
);

class SplashNotifier extends StateNotifier<String?> {
  final Ref ref;

  SplashNotifier(this.ref) : super(null);

  Future<void> getInitialRoute() async {
    await Future.delayed(const Duration(seconds: 1));
    final authState = ref.read(authNotifierProvider);

    state = AllergenSelectionPage.routeName;

    if (authState is AuthStateAuthenticated) {
      state = HomePage.routeName;
    } else {
      state = LoginPage.routeName;
    }
  }
}
