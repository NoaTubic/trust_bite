import 'package:food_safety/features/product_details/domain/entities/product_details.dart';
import 'package:food_safety/features/product_details/domain/usecases/get_product_details.dart';
import 'package:q_architecture/base_state_notifier.dart';

final productDetailsNotifier =
    BaseStateNotifierProvider<ProductDetailsNotifier, ProductDetails>(
  (ref) => ProductDetailsNotifier(
    ref.watch(getProductDetailsUseCaseProvider),
    ref,
  ),
);

class ProductDetailsNotifier extends BaseStateNotifier<ProductDetails> {
  final GetProductDetails _getProductDetails;
  ProductDetailsNotifier(this._getProductDetails, super.ref);

  void getProductDetails(String productId) => execute(
        _getProductDetails(productId),
      );
}
