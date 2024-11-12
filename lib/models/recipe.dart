import 'package:flutter/material.dart';

class Recipe {
  final AssetImage image;
  final String title;
  final String description;
  final List<String> ingredients;
  final List<String> instructions;
  final String category;

  Recipe({
    AssetImage? image,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.category,
  }): image = image ?? const AssetImage('assets/images/pancake_image.png');
}
