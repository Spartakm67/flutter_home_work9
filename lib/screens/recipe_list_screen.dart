import 'package:flutter/material.dart';
import 'package:flutter_home_work9/repository/recipe_repository.dart';
import 'package:flutter_home_work9/widgets/recipe_item.dart';
import 'package:flutter_home_work9/widgets/recipe_form_add.dart';
import 'package:flutter_home_work9/models/recipe.dart';

class RecipeListPage extends StatefulWidget {
  const RecipeListPage({super.key});

  @override
  State<RecipeListPage> createState() => _RecipeListPageState();
}

class _RecipeListPageState extends State<RecipeListPage> {
  List<Recipe> recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  void _loadRecipes() {
    setState(() {
      recipes = RecipeRepository.getAllRecipes();
    });
  }

  @override
  Widget build(BuildContext context) {
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
        onPressed: () async {
          final result = await
              Navigator.push(
              context,
              MaterialPageRoute(
              builder: (_) => const RecipeForm()));

          if (result == true) {
            _loadRecipes();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
