import 'package:equatable/equatable.dart';

class ProductCategories extends Equatable {
  final String name;

  const ProductCategories({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}
