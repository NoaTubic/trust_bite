import 'package:food_safety/features/product_details/data/datasources/product_details_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final openFoodFactsClientProvider = Provider<OpenFoodFactsClient>(
  (ref) => OpenFoodFactsClient(),
);

class OpenFoodFactsClient implements ProductDetailsDataSource {
  @override
  Future<Product?> getProductDetails(String barcode) async {
    OpenFoodAPIConfiguration.userAgent = UserAgent(
      name: 'Trust Bites',
    );

    final ProductQueryConfiguration configuration = ProductQueryConfiguration(
      barcode,
      version: ProductQueryVersion.v3,
    );
    final ProductResultV3 result =
        await OpenFoodAPIClient.getProductV3(configuration);

    if (result.status == ProductResultV3.statusSuccess) {
      return result.product;
    } else {
      throw Exception('product not found, please insert data for $barcode');
    }
  }
}
