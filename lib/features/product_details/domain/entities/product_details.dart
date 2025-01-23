class ProductDetails {
  final String? barcode;
  final String? name;
  final String? genericName;
  final String? brand;
  final String? country;
  final String? imageUrl;
  final String? quantity;
  final List<NutritionalValue>? nutritionalValues;
  final List<String>? ingredients;

  ProductDetails({
    this.barcode,
    this.name,
    this.genericName,
    this.brand,
    this.country,
    this.imageUrl,
    this.quantity,
    this.nutritionalValues,
    this.ingredients,
  });
}

class NutritionalValue {
  final String name;
  final String value;

  NutritionalValue({required this.name, required this.value});
}
