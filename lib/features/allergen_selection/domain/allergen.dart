import 'package:flutter/material.dart';

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

  IconData get iconData {
    // Replace these with actual icons
    switch (this) {
      case Allergen.gluten:
        return Icons.eco;
      case Allergen.milk:
        return Icons.local_drink;
      case Allergen.eggs:
        return Icons.egg;
      case Allergen.nuts:
        return Icons.ac_unit;
      case Allergen.peanuts:
        return Icons.emoji_food_beverage;
      case Allergen.celery:
        return Icons.local_florist;
      case Allergen.soybean:
        return Icons.spa;
      case Allergen.lupin:
        return Icons.bubble_chart;
      case Allergen.fish:
        return Icons.water;
      case Allergen.crustaceans:
        return Icons.set_meal;
      case Allergen.molluscs:
        return Icons.beach_access;
      case Allergen.sulphurDioxide:
        return Icons.science;
    }
  }
}
