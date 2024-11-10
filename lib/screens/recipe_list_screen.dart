import 'package:flutter/material.dart';
import 'package:flutter_home_work9/repository/repository.dart';
import 'package:flutter_home_work9/widgets/recipe_item.dart';

class RecipeListPage extends StatelessWidget {
  const RecipeListPage({super.key});

  @override
  Widget build(BuildContext context) {

    final recipes = Repository.getAllRecipes();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Рецепти'),
      ),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (context, index) {
          final recipe = recipes[index];
          return RecipeCard(recipe: recipe);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
