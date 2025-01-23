import 'package:openfoodfacts/openfoodfacts.dart';

abstract class SearchRecipesDataSource {
  Future<List<Product>> searchProducts(List<Parameter> parameters);
  Future<List<String>> getSuggestions(
    TagType taxonomyType, {
    String input,
    required OpenFoodFactsLanguage language,
    OpenFoodFactsCountry? country,
    String? categories,
    String? shape,
    int limit,
    UriProductHelper uriHelper,
    User? user,
  });
}
