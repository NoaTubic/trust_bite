import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:q_architecture/q_architecture.dart';

abstract class SearchRecipesRepository {
  EitherFailureOr<List<Product>> searchProducts(List<Parameter> parameters);
  EitherFailureOr<List<String>> getSuggestions(
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
