import 'dart:developer';

import 'package:either_dart/either.dart';
import 'package:food_safety/core/data/error_resolvers/generic_error_resolver.dart';
import 'package:food_safety/features/product_details/data/datasources/product_details_data_source.dart';
import 'package:food_safety/features/product_details/data/mappers/product_details_mapper.dart';
import 'package:food_safety/features/product_details/domain/entities/product_details.dart';
import 'package:food_safety/features/product_details/domain/repositories/product_details_repository.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
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

        ProductDetails productDetails =
            mapProductToProductDetails(productResponse!);

        log("Mapped Product Details:");
        log("Barcode: ${productDetails.barcode}");
        log("Name: ${productDetails.name}");
        log("Generic Name: ${productDetails.genericName}");
        log("Brand: ${productDetails.brand}");
        log("Country: ${productDetails.country}");
        log("Image URL: ${productDetails.imageUrl}");
        log("Quantity: ${productDetails.quantity}");
        log("Nutritional Values: ${productDetails.nutritionalValues?.map((e) => "${e.name}: ${e.value}").join(", ")}");
        log("Ingredients: ${productDetails.ingredients?.join(", ")}");

        return Right(productDetails);
      }, errorResolver: const GenericErrorResolver());
}
