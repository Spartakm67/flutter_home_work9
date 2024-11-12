import 'package:flutter/material.dart';
import 'package:flutter_home_work9/models/recipe.dart';
import 'package:flutter_home_work9/repository/category_repository.dart';
import 'package:flutter_home_work9/repository/image_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter_home_work9/provider/recipe_model.dart';

class RecipeFormEdit extends StatefulWidget {
  final Recipe recipe;
  const RecipeFormEdit({super.key, required this.recipe});

  @override
  RecipeFormEditState createState() => RecipeFormEditState();
}

class RecipeFormEditState extends State<RecipeFormEdit> {
  late String selectedImage;
  late String selectedCategory;
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController ingredientsController;
  late TextEditingController instructionsController;

  @override
  void initState() {
    super.initState();
    selectedImage = widget.recipe.image.assetName;
    selectedCategory = widget.recipe.category;
    titleController = TextEditingController(text: widget.recipe.title);
    descriptionController = TextEditingController(text: widget.recipe.description);
    ingredientsController = TextEditingController(text: widget.recipe.ingredients.join(', '));
    instructionsController = TextEditingController(text: widget.recipe.instructions.join(', '));
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    ingredientsController.dispose();
    instructionsController.dispose();
    super.dispose();
  }

  void _saveEditRecipe() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Назва та опис не можуть бути порожніми')),
      );
      return;
    }

    final updatedRecipe = Recipe(
      id: widget.recipe.id,
      title: titleController.text,
      description: descriptionController.text,
      ingredients: ingredientsController.text.split(', '),
      instructions: instructionsController.text.split(', '),
      category: selectedCategory,
      image: AssetImage(selectedImage),
    );

    Provider.of<RecipeModel>(context, listen: false).updateRecipe(widget.recipe.id, updatedRecipe);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Рецепт "${updatedRecipe.title}" оновлено!')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Редагування: ${widget.recipe.title}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Image(
                  image: AssetImage(selectedImage),
                  width: 30,
                  height: 30,
                ),
                const SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedImage,
                  items: ImageRepository.getAllImages().map((String imagePath) {
                    return DropdownMenuItem<String>(
                      value: imagePath,
                      child: Text(imagePath.split('/').last),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedImage = newValue!;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedCategory,
              items: CategoryRepository.getAllCategories().map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue!;
                });
              },
            ),
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Назва'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Опис'),
            ),
            TextField(
              controller: ingredientsController,
              decoration: const InputDecoration(labelText: 'Інгредієнти'),
              maxLines: null,
            ),
            TextField(
              controller: instructionsController,
              decoration: const InputDecoration(labelText: 'Інструкції'),
              maxLines: null,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEditRecipe,
              child: const Text('Зберегти'),
            ),
          ],
        ),
      ),
    );
  }
}



