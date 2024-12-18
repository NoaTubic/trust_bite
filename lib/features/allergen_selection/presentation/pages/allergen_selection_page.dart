import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/app_sizes.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/bottom_nav_bar.dart';
import 'package:food_safety/core/presentation/widgets/custom_button.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/core/presentation/widgets/custom_toast.dart';
import 'package:food_safety/features/allergen_selection/domain/allergen.dart';
import 'package:food_safety/features/allergen_selection/presentation/notifiers/allergen_selection_notifier.dart';
import 'package:food_safety/features/allergen_selection/presentation/widgets/allergen_tile.dart';
import 'package:food_safety/features/home/presentation/pages/home_page.dart';
import 'package:food_safety/generated/l10n.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllergenSelectionPage extends ConsumerWidget {
  static const routeName = '/allergen-selection';
  const AllergenSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedAllergens = ref.watch(allergenSelectionNotifierProvider);
    final notifier = ref.read(allergenSelectionNotifierProvider.notifier);

    return CustomScaffold(
      body: Column(
        children: [
          Text(
            S.current.select_allergens,
            style: context.appTextStyles.headingsBold!
                .copyWith(color: context.appColors.primary),
          ),
          const Gap(AppSizes.mediumSpacing),
          Expanded(
            flex: 11,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: AppSizes.normalSpacing,
                mainAxisSpacing: AppSizes.normalSpacing,
              ),
              itemCount: Allergen.values.length,
              itemBuilder: (context, index) {
                final allergen = Allergen.values[index];
                final isSelected = selectedAllergens.contains(allergen);

                return AllergenTile(
                  label: allergen.displayName,
                  icon: allergen.icon,
                  isSelected: isSelected,
                  onTap: () => notifier.toggleAllergen(allergen),
                );
              },
            ),
          ),
          CustomButton.secondary(
            text: S.current.no_allergens,
            onPressed: () => _noAllergens(context, ref),
            context: context,
          ),
          const Gap(AppSizes.normalSpacing),
          CustomButton.primary(
            text: S.current.confirm_allergens,
            onPressed: () => _confirmAllergens(context, ref),
            context: context,
          ),
          Spacer(
            flex: 1,
          ),
        ],
      ),
    );
  }

  void _noAllergens(BuildContext context, WidgetRef ref) {
    ref
        .read(allergenSelectionNotifierProvider.notifier)
        .setAllergens(noAllergens: true);
    context.pushNamed(BottomNavBar.routeName);
    CustomToast(
      message: S.current.allergens_successfully_updated,
      isWarning: false,
    ).show(context);
  }

  void _confirmAllergens(BuildContext context, WidgetRef ref) {
    ref.read(allergenSelectionNotifierProvider.notifier).setAllergens();
    context.pushNamed(HomePage.routeName);
    CustomToast(
      message: S.current.allergens_successfully_updated,
      isWarning: false,
    ).show(context);
  }
}
