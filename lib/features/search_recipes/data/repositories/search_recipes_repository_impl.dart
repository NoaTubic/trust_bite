import 'package:either_dart/either.dart';
import 'package:food_safety/core/data/clients/open_food_facts_client.dart';
import 'package:food_safety/core/data/error_resolvers/generic_error_resolver.dart';
import 'package:food_safety/features/search_recipes/data/datasources/search_recipes_data_source.dart';
import 'package:food_safety/features/search_recipes/domain/repositories/search_recipes_repository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';
import 'package:q_architecture/q_architecture.dart';

final searchRecipesRepositoryProvider = Provider<SearchRecipesRepository>(
  (ref) => SearchRecipesRepositoryImpl(ref.watch(openFoodFactsClientProvider)),
);

class SearchRecipesRepositoryImpl
    with ErrorToFailureMixin
    implements SearchRecipesRepository {
  final SearchRecipesDataSource apiClient;

  SearchRecipesRepositoryImpl(this.apiClient);

  @override
  EitherFailureOr<List<Product>> searchProducts(
          List<Parameter> parameters) async =>
      execute(
        () async {
          final products = await apiClient.searchProducts(parameters);

          return Right(products);
        },
        errorResolver: const GenericErrorResolver(),
      );

  @override
  EitherFailureOr<List<String>> getSuggestions(
    TagType taxonomyType, {
    String input = '',
    required OpenFoodFactsLanguage language,
    OpenFoodFactsCountry? country,
    String? categories,
    String? shape,
    int limit = 25,
    UriProductHelper uriHelper = uriHelperFoodProd,
    User? user,
  }) async =>
      execute(
        () async {
          final List<String> suggestions = await apiClient.getSuggestions(
            taxonomyType,
            input: input,
            language: language,
            country: country,
            categories: categories,
            shape: shape,
            limit: limit,
            uriHelper: uriHelper,
            user: user,
          );
          return Right(suggestions);
        },
        errorResolver: const GenericErrorResolver(),
      );
}
