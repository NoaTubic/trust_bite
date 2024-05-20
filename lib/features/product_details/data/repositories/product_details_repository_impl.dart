import 'package:either_dart/either.dart';
import 'package:food_safety/core/data/error_resolvers/generic_error_resolver.dart';
import 'package:food_safety/features/product_details/data/datasources/product_details_data_source.dart';
import 'package:food_safety/features/product_details/domain/entities/product_details.dart';
import 'package:food_safety/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:q_architecture/q_architecture.dart';

class ProductDetailsRepositoryImpl
    with ErrorToFailureMixin
    implements ProductDetailsRepository {
  final ProductDetailsDataSource _productDetailsDataSource;

  ProductDetailsRepositoryImpl(this._productDetailsDataSource);
  @override
  EitherFailureOr<ProductDetails> getProductDetails(String barcode) =>
      execute(() async {
        final productResponse =
            await _productDetailsDataSource.getProductDetails(barcode);
        return Right(ProductDetails());
      }, errorResolver: const GenericErrorResolver());
}
