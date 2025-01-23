import 'package:food_safety/features/product_details/domain/entities/product_details.dart';
import 'package:openfoodfacts/openfoodfacts.dart';

ProductDetails mapProductToProductDetails(Product product) {
  return ProductDetails(
    barcode: product.barcode,
    name: product.productName ??
        product.getBestProductName(OpenFoodFactsLanguage.ENGLISH),
    genericName: product.genericName,
    brand: product.getFirstBrand(),
    country: product.countries,
    imageUrl: product.imageFrontUrl ?? product.imageNutritionUrl,
    quantity: product.quantity,
    nutritionalValues: _mapNutritionalValues(product.nutriments),
    ingredients: product.ingredients
        ?.map((ingredient) => ingredient.text ?? '')
        .toList(),
  );
}

List<NutritionalValue> _mapNutritionalValues(Nutriments? nutriments) {
  if (nutriments == null) return [];

  return [
    if (nutriments.getValue(Nutrient.proteins, PerSize.oneHundredGrams) != null)
      NutritionalValue(
          name: "Proteins",
          value:
              "${nutriments.getValue(Nutrient.proteins, PerSize.oneHundredGrams)} g"),
    if (nutriments.getValue(Nutrient.fat, PerSize.oneHundredGrams) != null)
      NutritionalValue(
          name: "Fat",
          value:
              "${nutriments.getValue(Nutrient.fat, PerSize.oneHundredGrams)} g"),
    if (nutriments.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams) !=
        null)
      NutritionalValue(
          name: "Carbohydrates",
          value:
              "${nutriments.getValue(Nutrient.carbohydrates, PerSize.oneHundredGrams)} g"),
    if (nutriments.getValue(Nutrient.salt, PerSize.oneHundredGrams) != null)
      NutritionalValue(
          name: "Salt",
          value:
              "${nutriments.getValue(Nutrient.salt, PerSize.oneHundredGrams)} g"),
    if (nutriments.getValue(Nutrient.sugars, PerSize.oneHundredGrams) != null)
      NutritionalValue(
          name: "Sugars",
          value:
              "${nutriments.getValue(Nutrient.sugars, PerSize.oneHundredGrams)} g"),
  ];
}
