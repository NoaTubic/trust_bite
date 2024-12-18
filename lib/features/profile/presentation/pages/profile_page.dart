import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/image_assets.dart';
import 'package:food_safety/core/presentation/widgets/custom_button.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/core/presentation/widgets/profile_avatar.dart';
import 'package:food_safety/features/auth/presentation/notifiers/auth_notifier.dart';
import 'package:food_safety/features/auth/presentation/notifiers/user_notifier.dart';
import 'package:food_safety/features/auth/presentation/pages/login_page.dart';
import 'package:food_safety/features/profile/presentation/widgets/profile_tile.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfilePage extends ConsumerWidget {
  static const String routeName = '/profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      padding: EdgeInsets.symmetric(
          vertical: AppSizes.bodyVerticalPadding, horizontal: AppSizes.zero),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.bodyHorizontalPadding),
            child: Row(
              children: [
                ProfileAvatar(),
                Gap(AppSizes.normalSpacing),
                Text(
                  ref.watch(userProvider)!.username,
                  style: context.appTextStyles.headingsBold,
                ),
              ],
            ),
          ),
          Gap(AppSizes.mediumSpacing),
          ProfileTile(
            icon: ImageAssets.idCard,
            label: 'Profile settings',
            onTap: () {},
          ),
          ProfileTile(
            icon: ImageAssets.settings,
            label: 'General settings',
            onTap: () {},
          ),
          ProfileTile(
            icon: ImageAssets.restaurantMenu,
            label: 'Food preferences settings',
            onTap: () {},
          ),
          Divider(
            color: context.appColors.tertiary,
            thickness: 2,
            indent: AppSizes.bodyHorizontalPadding,
            endIndent: AppSizes.bodyHorizontalPadding,
          ),
          Gap(AppSizes.normalSpacing),
          _ProfileTextButton(label: 'Terms of user', onTap: () {}),
          _ProfileTextButton(
            label: 'Privacy policy',
            onTap: () {},
          ),
          _ProfileTextButton(
            label: 'About Us',
            onTap: () {},
          ),
          _ProfileTextButton(
            label: 'Contact Us',
            onTap: () {},
          ),
          _ProfileTextButton(
            label: 'Help/FAQ',
            onTap: () {},
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.bodyHorizontalPadding),
            child: CustomButton.primary(
              text: 'Log Out',
              onPressed: () {
                ref.read(authNotifierProvider.notifier).logout();
                context.pushNamed(LoginPage.routeName);
              },
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _ProfileTextButton({
    super.key,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.bodyHorizontalPadding,
      ),
      child: TextButton(
        onPressed: onTap,
        child: Text(label),
      ),
    );
  }
}
