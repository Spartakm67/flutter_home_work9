import 'package:flutter_home_work9/models/recipe.dart';

class RecipeRepository {
  static final List<Recipe> recipes = [
    Recipe(
      title: 'Борщ',
      description: 'Традиційний український суп',
      ingredients: ['Буряк', 'Картопля', 'Морква', 'Цибуля'],
      instructions: [
        'Підготувати овочі',
        'Варити бульйон',
        'Додати овочі',
        'Варити до готовності'
      ],
      category: 'Обід',
    ),
    Recipe(
      title: 'Салат Цезар',
      description: 'Смачний салат з куркою',
      ingredients: ['Курка', 'Салат', 'Сир пармезан', 'Соус'],
      instructions: [
        'Підготувати інгредієнти',
        'Змішати все в мисці',
        'Заправити соусом'
      ],
      category: 'Салати',
    ),
    Recipe(
      title: 'Омлет',
      description: 'Легкий та смачний сніданок',
      ingredients: ['Яйця', 'Молоко', 'Сіль', 'Перець'],
      instructions: ['Збити яйця', 'Додати молоко', 'Посолити', 'Посмажити'],
      category: 'Сніданок',
    ),
  ];

  static List<Recipe> getAllRecipes() {
    return recipes;
  }

  static List<Recipe> getRecipesByCategory(String category) {
    return recipes.where((recipe) => recipe.category == category).toList();
  }

  static void addRecipe(Recipe recipe) {
    recipes.add(recipe);
  }
}
