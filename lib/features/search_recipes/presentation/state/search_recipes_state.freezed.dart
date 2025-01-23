// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_recipes_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SearchRecipesState {
  List<Product> get recipes => throw _privateConstructorUsedError;
  List<String> get suggestions => throw _privateConstructorUsedError;
  bool get isLoading => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SearchRecipesStateCopyWith<SearchRecipesState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchRecipesStateCopyWith<$Res> {
  factory $SearchRecipesStateCopyWith(
          SearchRecipesState value, $Res Function(SearchRecipesState) then) =
      _$SearchRecipesStateCopyWithImpl<$Res, SearchRecipesState>;
  @useResult
  $Res call(
      {List<Product> recipes,
      List<String> suggestions,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class _$SearchRecipesStateCopyWithImpl<$Res, $Val extends SearchRecipesState>
    implements $SearchRecipesStateCopyWith<$Res> {
  _$SearchRecipesStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipes = null,
    Object? suggestions = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      recipes: null == recipes
          ? _value.recipes
          : recipes // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      suggestions: null == suggestions
          ? _value.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchRecipesStateImplCopyWith<$Res>
    implements $SearchRecipesStateCopyWith<$Res> {
  factory _$$SearchRecipesStateImplCopyWith(_$SearchRecipesStateImpl value,
          $Res Function(_$SearchRecipesStateImpl) then) =
      __$$SearchRecipesStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<Product> recipes,
      List<String> suggestions,
      bool isLoading,
      String? errorMessage});
}

/// @nodoc
class __$$SearchRecipesStateImplCopyWithImpl<$Res>
    extends _$SearchRecipesStateCopyWithImpl<$Res, _$SearchRecipesStateImpl>
    implements _$$SearchRecipesStateImplCopyWith<$Res> {
  __$$SearchRecipesStateImplCopyWithImpl(_$SearchRecipesStateImpl _value,
      $Res Function(_$SearchRecipesStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? recipes = null,
    Object? suggestions = null,
    Object? isLoading = null,
    Object? errorMessage = freezed,
  }) {
    return _then(_$SearchRecipesStateImpl(
      recipes: null == recipes
          ? _value._recipes
          : recipes // ignore: cast_nullable_to_non_nullable
              as List<Product>,
      suggestions: null == suggestions
          ? _value._suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isLoading: null == isLoading
          ? _value.isLoading
          : isLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      errorMessage: freezed == errorMessage
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SearchRecipesStateImpl implements _SearchRecipesState {
  const _$SearchRecipesStateImpl(
      {final List<Product> recipes = const [],
      final List<String> suggestions = const [],
      this.isLoading = false,
      this.errorMessage})
      : _recipes = recipes,
        _suggestions = suggestions;

  final List<Product> _recipes;
  @override
  @JsonKey()
  List<Product> get recipes {
    if (_recipes is EqualUnmodifiableListView) return _recipes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_recipes);
  }

  final List<String> _suggestions;
  @override
  @JsonKey()
  List<String> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  @override
  @JsonKey()
  final bool isLoading;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'SearchRecipesState(recipes: $recipes, suggestions: $suggestions, isLoading: $isLoading, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchRecipesStateImpl &&
            const DeepCollectionEquality().equals(other._recipes, _recipes) &&
            const DeepCollectionEquality()
                .equals(other._suggestions, _suggestions) &&
            (identical(other.isLoading, isLoading) ||
                other.isLoading == isLoading) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_recipes),
      const DeepCollectionEquality().hash(_suggestions),
      isLoading,
      errorMessage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchRecipesStateImplCopyWith<_$SearchRecipesStateImpl> get copyWith =>
      __$$SearchRecipesStateImplCopyWithImpl<_$SearchRecipesStateImpl>(
          this, _$identity);
}

abstract class _SearchRecipesState implements SearchRecipesState {
  const factory _SearchRecipesState(
      {final List<Product> recipes,
      final List<String> suggestions,
      final bool isLoading,
      final String? errorMessage}) = _$SearchRecipesStateImpl;

  @override
  List<Product> get recipes;
  @override
  List<String> get suggestions;
  @override
  bool get isLoading;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$$SearchRecipesStateImplCopyWith<_$SearchRecipesStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
