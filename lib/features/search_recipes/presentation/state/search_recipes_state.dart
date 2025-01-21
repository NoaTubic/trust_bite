import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

part 'search_recipes_state.freezed.dart';

@freezed
class SearchRecipesState with _$SearchRecipesState {
  const factory SearchRecipesState({
    @Default([]) List<Product> recipes,
    @Default([]) List<String> suggestions,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _SearchRecipesState;
}
