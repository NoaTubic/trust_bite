import 'package:openfoodfacts/openfoodfacts.dart';

abstract class ProductDetailsDataSource {
  Future<Product?> getProductDetails(String barcode);
}
