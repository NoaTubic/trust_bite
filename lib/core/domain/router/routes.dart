import 'package:food_safety/features/home/presentation/pages/home_page.dart';
import 'package:food_safety/features/product_details/presentation/pages/product_details_page.dart';
import 'package:food_safety/features/scanner/presentation/pages/scanner_page.dart';
import 'package:food_safety/features/splash/presentation/pages/splash_page.dart';

final routes = {
  SplashPage.routeName: (context) => const SplashPage(),
  HomePage.routeName: (context) => const HomePage(),
  ScannerPage.routeName: (context) => const ScannerPage(),
  ProductDetailsPage.routeName: (context) => const ProductDetailsPage(),
};
