import 'package:food_safety/features/allergen_selection/presentation/pages/allergen_selection_page.dart';
import 'package:food_safety/features/auth/domain/entities/user.dart';
import 'package:food_safety/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:food_safety/features/auth/presentation/notifiers/auth_state.dart';
import 'package:food_safety/features/auth/presentation/notifiers/user_notifier.dart';
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
    await Future.delayed(const Duration(seconds: 2));
    final authState = ref.read(authNotifierProvider);

    if (authState is AuthStateAuthenticated) {
      final FoodSafetyUser? user =
          await ref.read(userProvider.notifier).getUserAsync();

      user != null && user.allergens.isEmpty
          ? state = AllergenSelectionPage.routeName
          : state = HomePage.routeName;
    } else {
      state = LoginPage.routeName;
    }
  }
}
