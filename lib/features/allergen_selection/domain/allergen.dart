import 'package:food_safety/core/presentation/image_assets.dart';

enum Allergen {
  gluten,
  milk,
  eggs,
  nuts,
  peanuts,
  celery,
  soybean,
  lupin,
  fish,
  crustaceans,
  molluscs,
  sulphurDioxide,
}

extension AllergenExtension on Allergen {
  String get displayName {
    switch (this) {
      case Allergen.gluten:
        return 'Gluten';
      case Allergen.milk:
        return 'Milk';
      case Allergen.eggs:
        return 'Eggs';
      case Allergen.nuts:
        return 'Nuts';
      case Allergen.peanuts:
        return 'Peanuts';
      case Allergen.celery:
        return 'Celery';
      case Allergen.soybean:
        return 'Soybean';
      case Allergen.lupin:
        return 'Lupin';
      case Allergen.fish:
        return 'Fish';
      case Allergen.crustaceans:
        return 'Crustaceans';
      case Allergen.molluscs:
        return 'Molluscs';
      case Allergen.sulphurDioxide:
        return 'Sulphur Dioxide';
    }
  }

  String get icon {
    switch (this) {
      case Allergen.gluten:
        return ImageAssets.gluten;
      case Allergen.milk:
        return ImageAssets.milk;
      case Allergen.eggs:
        return ImageAssets.eggs;
      case Allergen.nuts:
        return ImageAssets.nuts;
      case Allergen.peanuts:
        return ImageAssets.peanuts;
      case Allergen.celery:
        return ImageAssets.celery;
      case Allergen.soybean:
        return ImageAssets.soyBean;
      case Allergen.lupin:
        return ImageAssets.lupin;
      case Allergen.fish:
        return ImageAssets.fish;
      case Allergen.crustaceans:
        return ImageAssets.crab;
      case Allergen.molluscs:
        return ImageAssets.abalone;
      case Allergen.sulphurDioxide:
        return ImageAssets.sulfurDioxide;
    }
  }

  static Allergen fromString(String allergen) {
    switch (allergen) {
      case 'Gluten':
        return Allergen.gluten;
      case 'Milk':
        return Allergen.milk;
      case 'Eggs':
        return Allergen.eggs;
      case 'Nuts':
        return Allergen.nuts;
      case 'Peanuts':
        return Allergen.peanuts;
      case 'Celery':
        return Allergen.celery;
      case 'Soybean':
        return Allergen.soybean;
      case 'Lupin':
        return Allergen.lupin;
      case 'Fish':
        return Allergen.fish;
      case 'Crustaceans':
        return Allergen.crustaceans;
      case 'Molluscs':
        return Allergen.molluscs;
      case 'Sulphur Dioxide':
        return Allergen.sulphurDioxide;
      default:
        throw Exception('Invalid allergen');
    }
  }
}
