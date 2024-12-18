import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/profile_avatar.dart';
import 'package:food_safety/features/auth/presentation/notifiers/user_notifier.dart';
import 'package:food_safety/generated/l10n.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class UserProfileTile extends ConsumerWidget {
  const UserProfileTile({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return Row(
      children: [
        ProfileAvatar(),
        Gap(AppSizes.normalSpacing),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${S.current.hi}${user?.username ?? ''}',
              style: context.appTextStyles.headingsBold!.copyWith(
                color: context.appColors.tertiary,
              ),
            ),
            Text(
              S.current.welcome,
              style: context.appTextStyles.normalText!.copyWith(
                color: context.appColors.tertiary,
              ),
            ),
          ],
        )
      ],
    );
  }
}
