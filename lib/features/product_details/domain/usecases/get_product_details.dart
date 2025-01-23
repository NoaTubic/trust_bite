import 'package:food_safety/features/product_details/domain/entities/product_details.dart';
import 'package:food_safety/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:q_architecture/q_architecture.dart';

final getProductDetailsUseCaseProvider = Provider<GetProductDetails>(
  (ref) => GetProductDetails(
    ref.watch(productDetailsRepositoryProvider),
  ),
);

class GetProductDetails {
  final ProductDetailsRepository _productDetailsRepository;

  GetProductDetails(this._productDetailsRepository);

  EitherFailureOr<ProductDetails> call(String barcode) async =>
      await _productDetailsRepository.getProductDetails(barcode);
}
