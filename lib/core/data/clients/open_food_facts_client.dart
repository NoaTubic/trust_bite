import 'package:food_safety/features/product_details/data/datasources/product_details_data_source.dart';
import 'package:food_safety/features/search_recipes/data/datasources/search_recipes_data_source.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

final openFoodFactsClientProvider = Provider<OpenFoodFactsClient>(
  (ref) => OpenFoodFactsClient(),
);

class OpenFoodFactsClient
    implements ProductDetailsDataSource, SearchRecipesDataSource {
  @override
  Future<Product?> getProductDetails(String barcode) async {
    OpenFoodAPIConfiguration.userAgent = UserAgent(
      name: 'Trust Bites',
      version: '0.0.1',
      url: 'https://trustbites.com',
      system: 'Trust Bites',
      comment: '',
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

  @override
  Future<List<Product>> searchProducts(List<Parameter> parameters) async {
    final ProductSearchQueryConfiguration configuration =
        ProductSearchQueryConfiguration(
      parametersList: parameters,
      version: ProductQueryVersion.v3,
    );

    final SearchResult result = await OpenFoodAPIClient.searchProducts(
      User(userId: '', password: ''),
      configuration,
    );

    if (result.products != null && result.products!.isNotEmpty) {
      return result.products!;
    } else {
      throw Exception('Products not found');
    }
  }

  @override
  Future<List<String>> getSuggestions(
    final TagType taxonomyType, {
    final String input = '',
    required final OpenFoodFactsLanguage language,
    final OpenFoodFactsCountry? country,
    final String? categories,
    final String? shape,
    final int limit = 25,
    final UriProductHelper uriHelper = uriHelperFoodProd,
    final User? user,
  }) async {
    final Map<String, String> queryParameters = <String, String>{
      'tagtype': taxonomyType.offTag,
      'lc': language.offTag,
      'string': input,
      if (country != null) 'cc': country.offTag,
      if (categories != null) 'categories': categories,
      if (shape != null) 'shape': shape,
      'limit': limit.toString(),
    };

    final Uri uri = uriHelper.getUri(
      path: '/api/v3/taxonomy_suggestions',
      queryParameters: queryParameters,
    );

    final response = await HttpHelper().doGetRequest(
      uri,
      user: user,
      uriHelper: uriHelper,
    );

    final Map<String, dynamic> map = HttpHelper().jsonDecode(response.body);
    final List<String> result = <String>[];
    if (map['suggestions'] != null) {
      for (dynamic value in map['suggestions']) {
        result.add(value.toString());
      }
    }
    return result;
  }
}
