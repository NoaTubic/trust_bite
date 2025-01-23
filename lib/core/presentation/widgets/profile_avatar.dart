import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/features/auth/presentation/notifiers/user_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileAvatar extends ConsumerWidget {
  final double radius;
  const ProfileAvatar({
    super.key,
    this.radius = AppSizes.userAvatarSize + 3,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: context.appColors.tertiary,
      child: CircleAvatar(
        backgroundColor: context.appColors.background,
        radius: AppSizes.userAvatarSize,
        child: Image.network(
          ref.watch(userProvider)!.photoUrl ??
              'https://robohash.org/mail@ashallendesign.co.uk',
          errorBuilder: (context, error, stackTrace) => Icon(
            Icons.person,
            color: context.appColors.tertiary,
            size: AppSizes.userAvatarSize,
          ),
        ),
      ),
    );
  }
}
