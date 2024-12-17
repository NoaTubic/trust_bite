import 'package:food_safety/core/presentation/widgets/bottom_nav_bar.dart';
import 'package:food_safety/features/allergen_selection/presentation/pages/allergen_selection_page.dart';
import 'package:food_safety/features/auth/presentation/pages/login_page.dart';
import 'package:food_safety/features/auth/presentation/pages/registration_page.dart';
import 'package:food_safety/features/expiration_date_tracker/presentation/pages/expiration_date_tracker_page.dart';
import 'package:food_safety/features/home/presentation/pages/home_page.dart';
import 'package:food_safety/features/product_details/presentation/pages/product_details_page.dart';
import 'package:food_safety/features/profile/presentation/pages/profile_page.dart';
import 'package:food_safety/features/scanner/presentation/pages/scanner_page.dart';
import 'package:food_safety/features/search_recipes/presentation/pages/search_recipes_page.dart';
import 'package:food_safety/features/splash/presentation/pages/splash_page.dart';

final routes = {
  SplashPage.routeName: (context) => const SplashPage(),
  LoginPage.routeName: (context) => const LoginPage(),
  RegistrationPage.routeName: (context) => const RegistrationPage(),
  AllergenSelectionPage.routeName: (context) => const AllergenSelectionPage(),
  BottomNavBar.routeName: (context) => const BottomNavBar(),
  HomePage.routeName: (context) => const HomePage(),
  SearchRecipesPage.routeName: (context) => const SearchRecipesPage(),
  ScannerPage.routeName: (context) => const ScannerPage(),
  ExpirationDateTrackerPage.routeName: (context) =>
      const ExpirationDateTrackerPage(),
  ProfilePage.routeName: (context) => const ProfilePage(),
  ProductDetailsPage.routeName: (context) => const ProductDetailsPage(),
};
