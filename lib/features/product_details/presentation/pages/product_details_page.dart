import 'package:flutter/material.dart';
import 'package:food_safety/core/presentation/build_context_extensions.dart';
import 'package:food_safety/core/presentation/widgets/custom_scaffold.dart';
import 'package:food_safety/features/auth/presentation/notifiers/user_notifier.dart';
import 'package:food_safety/features/product_details/domain/entities/product_details.dart';
import 'package:food_safety/features/product_details/presentation/notifiers/product_details_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/base_notifier.dart';

class ProductDetailsPage extends HookConsumerWidget {
  static const String routeName = '/product-details';
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(productDetailsNotifier);
    return CustomScaffold(
      padding: EdgeInsets.zero,
      body: switch (state) {
        BaseLoading() => const Center(child: CircularProgressIndicator()),
        BaseData(data: final productDetails) =>
          _ProductDetailsBody(productDetails: productDetails),
        BaseError() => const Center(child: Text("Error")),
        _ => SizedBox.shrink(),
      },
    );
  }
}

class _ProductDetailsBody extends ConsumerWidget {
  final ProductDetails productDetails;

  const _ProductDetailsBody({super.key, required this.productDetails});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Padding(
      padding: const EdgeInsets.all(24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              children: [
                IconButton(
                  icon:
                      Icon(Icons.arrow_back, color: context.appColors.primary),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Text(
                  "Product information",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: context.appColors.primary,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Center(
              child: Image.network(
                productDetails.imageUrl ?? '',
                width: 100,
                height: 100,
              ),
            ),
            SizedBox(height: 16),
            Text(
              productDetails.name ?? '',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: context.appColors.primary,
              ),
            ),
            // Product Name and Origin Info
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "place of origin",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
                Text(
                  "mass",
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  productDetails.country ?? 'N/A',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                Text(
                  productDetails.quantity ?? 'N/A',
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
            SizedBox(height: 8),

            Text(
              "no allergens according to your settings",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),

            // Nutritional Values Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Nutritional values",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: context.appColors.primary,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Circular Nutritional Info
                      Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border: Border.all(color: context.appColors.primary!),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "100g",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context.appColors.primary,
                                ),
                              ),
                              Text(
                                "104 kcal",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: context.appColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 16),

                      // Nutritional Values List
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: productDetails.nutritionalValues
                                  ?.map((value) {
                                return Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        value.name,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      Text(
                                        value.value,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList() ??
                              [],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Ingredients Section
            Text(
              "Ingredients",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: context.appColors.primary,
              ),
            ),
            SizedBox(height: 8),
            ...?productDetails.ingredients?.map((ingredient) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      ingredient,
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                    // Check for ingredient code if available
                    Text(
                      ingredient == "Sodium Benzoate"
                          ? "E211"
                          : ingredient == "Xanthan Gum"
                              ? "E415"
                              : ingredient == "Potassium Sorbate"
                                  ? "E202"
                                  : "",
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              );
            }),
            SizedBox(height: 12),
            Text(
              "water, double tomato concentrate 28%, sugar, alcoholic vinegar, "
              "modified starch, table salt, onion powder, thickener (E415), "
              "preservatives (E202, E211), aroma",
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }
}
