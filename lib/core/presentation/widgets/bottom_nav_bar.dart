import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/image_assets.dart';
import 'package:food_safety/features/expiration_date_tracker/presentation/pages/expiration_date_tracker_page.dart';
import 'package:food_safety/features/firebase_messaging/domain/utils/firebase_messaging_extension.dart';
import 'package:food_safety/features/home/presentation/pages/home_page.dart';
import 'package:food_safety/features/profile/presentation/pages/profile_page.dart';
import 'package:food_safety/features/scanner/presentation/pages/scanner_page.dart';
import 'package:food_safety/features/search_recipes/presentation/pages/search_recipes_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class BottomNavBar extends ConsumerWidget {
  static const String routeName = '/bottom-nav';
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.firebaseMessagingNotificationListener(context);
    return PersistentTabView(
      navBarHeight: 72,
      navBarBuilder: (navBarConfig) => Style1BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
            color: context.appColors.tertiary!,
            padding: EdgeInsets.all(AppSizes.tinySpacing)),
      ),
      tabs: [
        _bottomNavBarTab(
          screen: HomePage(),
          image: ImageAssets.home,
          context: context,
        ),
        _bottomNavBarTab(
          screen: SearchRecipesPage(),
          image: ImageAssets.search,
          context: context,
        ),
        _bottomNavBarTab(
          screen: ScannerPage(),
          image: ImageAssets.scanner,
          context: context,
          centerTab: true,
        ),
        _bottomNavBarTab(
          screen: ExpirationDateTrackerPage(),
          image: ImageAssets.calendar,
          context: context,
        ),
        _bottomNavBarTab(
          screen: ProfilePage(),
          image: ImageAssets.profile,
          context: context,
        ),
      ],
    );
  }
}

PersistentTabConfig _bottomNavBarTab({
  required Widget screen,
  required String image,
  required BuildContext context,
  bool centerTab = false,
}) {
  return PersistentTabConfig(
    screen: screen,
    item: ItemConfig(
      activeColorSecondary: context.appColors.secondary,
      activeForegroundColor: context.appColors.tertiary!,
      icon: CircleAvatar(
        radius: centerTab ? 30 : 24,
        backgroundColor: context.appColors.foreground,
        child: SvgPicture.asset(image),
      ),
    ),
  );
}
