import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/widgets/custom_button.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/core/presentation/widgets/user_profile_tile.dart';
import 'package:food_safety/features/auth/presentation/notifiers/auth_notifier.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  static const String routeName = '/home';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      body: Column(
        children: [
          UserProfileTile(),
          Spacer(),
          CustomButton.primary(
            text: 'Log Out',
            onPressed: () => ref.read(authNotifierProvider.notifier).logout(),
            context: context,
          ),
        ],
      ),
    );
  }
}
