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
  TextEditingController searchController = TextEditingController();
  String searchRecipe = "";
  String? selectedCategory;

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
    final allRecipes = RecipeRepository.getAllRecipes();
    final filteredRecipes = allRecipes.where((recipe) {
      final matchesQuery =
          recipe.title.toLowerCase().contains(searchRecipe.toLowerCase());
      final matchesCategory =
          selectedCategory == null || recipe.category == selectedCategory;
      return matchesQuery && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Рецепти'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              onChanged: (query) {
                setState(() => searchRecipe = query);
              },
              decoration: InputDecoration(
                labelText: 'Пошук за назвою',
                border: const OutlineInputBorder(),
                suffixIcon: searchRecipe.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          setState(() {
                            searchController.clear();
                            searchRecipe = '';
                          });
                        },
                      )
                    : null,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: DropdownButton<String>(
              value: selectedCategory,
              hint: const Text("Обрати категорію"),
              onChanged: (category) {
                setState(() => selectedCategory = category);
              },
              isExpanded: true,
              items: [
                const DropdownMenuItem(
                  value: null,
                  child: Text("Усі категорії"),
                ),
                ...RecipeRepository.getAllCategories().map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category),
                  );
                }),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredRecipes.length,
              itemBuilder: (context, index) {
                final recipe = filteredRecipes[index];
                return RecipeCard(recipe: recipe);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
              context, MaterialPageRoute(builder: (_) => const RecipeForm()));

          if (result == true) {
            _loadRecipes();
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
