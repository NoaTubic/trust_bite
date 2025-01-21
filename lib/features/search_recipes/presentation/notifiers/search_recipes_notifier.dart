import 'package:food_safety/features/search_recipes/data/repositories/search_recipes_repository_impl.dart';
import 'package:food_safety/features/search_recipes/domain/repositories/search_recipes_repository.dart';
import 'package:food_safety/features/search_recipes/presentation/state/search_recipes_state.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final searchRecipesNotifierProvider =
    StateNotifierProvider<SearchRecipesNotifier, SearchRecipesState>(
  (ref) => SearchRecipesNotifier(
    ref.watch(searchRecipesRepositoryProvider),
  ),
);

class SearchRecipesNotifier extends StateNotifier<SearchRecipesState> {
  final SearchRecipesRepository _repository;

  SearchRecipesNotifier(this._repository) : super(const SearchRecipesState());

  Future<void> searchProducts(List<Parameter> parameters) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final result = await _repository.searchProducts(parameters);
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.title,
      ),
      (products) => state = state.copyWith(
        isLoading: false,
        recipes: products,
      ),
    );
  }

  Future<void> fetchSuggestions(
    TagType taxonomyType, {
    String input = '',
    required OpenFoodFactsLanguage language,
    OpenFoodFactsCountry? country,
    String? categories,
    String? shape,
    int limit = 25,
    UriProductHelper uriHelper = uriHelperFoodProd,
    User? user,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    final result = await _repository.getSuggestions(
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
    result.fold(
      (failure) => state = state.copyWith(
        isLoading: false,
        errorMessage: failure.title,
      ),
      (suggestions) => state = state.copyWith(
        isLoading: false,
        suggestions: suggestions,
      ),
    );
  }
}
