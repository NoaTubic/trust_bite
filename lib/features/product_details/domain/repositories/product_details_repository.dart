import 'package:food_safety/core/data/clients/open_food_facts_client.dart';
import 'package:food_safety/features/product_details/data/repositories/product_details_repository_impl.dart';
import 'package:food_safety/features/product_details/domain/entities/product_details.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final productDetailsRepositoryProvider = Provider<ProductDetailsRepository>(
  (ref) => ProductDetailsRepositoryImpl(
    ref.watch(openFoodFactsClientProvider),
  ),
);

abstract interface class ProductDetailsRepository {
  EitherFailureOr<ProductDetails> getProductDetails(String barcode);
}
