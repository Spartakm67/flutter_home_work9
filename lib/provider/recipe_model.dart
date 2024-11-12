import 'package:flutter/material.dart';
import 'package:flutter_home_work9/models/recipe.dart';
import 'package:flutter_home_work9/repository/recipe_repository.dart';

class RecipeModel extends ChangeNotifier {
  final List<Recipe> _recipes = RecipeRepository.getAllRecipes();

  List<Recipe> get recipes => _recipes;

  void addRecipe(Recipe recipe) {
    RecipeRepository.addRecipe(recipe);
    notifyListeners();
  }

  void updateRecipe(String id, Recipe updatedRecipe) {
    final index = _recipes.indexWhere((recipe) => recipe.id == id);
    if (index != -1) {
      _recipes[index] = updatedRecipe;
      notifyListeners();
    }
  }

  List<Recipe> getRecipesByCategory(String category) {
    return RecipeRepository.getRecipesByCategory(category);
  }

  List<String> getAllCategories() {
    return RecipeRepository.getAllCategories();
  }
}

