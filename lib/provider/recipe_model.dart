import 'package:flutter/material.dart';
import 'package:flutter_home_work9/models/recipe.dart';
import 'package:flutter_home_work9/repository/recipe_repository.dart';

class RecipeModel extends ChangeNotifier {
  final List<Recipe> _recipes = RecipeRepository.getAllRecipes();
  final TextEditingController searchController = TextEditingController();
  String searchQuery = '';
  String? _selectedCategory;

  List<Recipe> get recipes {
    return _recipes.where((recipe) {
      final matchesQuery = recipe.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == null || recipe.category == _selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();
  }

  String? get selectedCategory => _selectedCategory;

  void setSearchQuery(String query) {
    searchQuery = query;
    notifyListeners();
  }

  void setSelectedCategory(String? category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void clearSearchQuery() {
    searchController.clear();
    searchQuery = '';
    notifyListeners();
  }

  void addRecipe(Recipe recipe) {
    _recipes.add(recipe);   
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

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}

