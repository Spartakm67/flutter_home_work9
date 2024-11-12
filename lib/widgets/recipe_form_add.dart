import 'package:flutter/material.dart';
import 'package:flutter_home_work9/models/recipe.dart';
import 'package:flutter_home_work9/repository/category_repository.dart';
import 'package:flutter_home_work9/repository/image_repository.dart';
import 'package:provider/provider.dart';
import 'package:flutter_home_work9/provider/recipe_model.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({super.key});

  @override
  RecipeFormState createState() => RecipeFormState();
}

class RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _ingredientController = TextEditingController();
  final TextEditingController _instructionController = TextEditingController();
  String? _selectedCategory;
  String? _selectedImage;
  final categories = CategoryRepository.getAllCategories();
  final images = ImageRepository.getAllImages();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _ingredientController.dispose();
    _instructionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Створити рецепт')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedImage,
                  items: images.map((image) {
                    return DropdownMenuItem(
                      value: image,
                      child: Row(
                        children: [
                          Image.asset(
                            image,
                            width: 30,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(width: 10),
                          Text(image),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() {
                    _selectedImage = value;
                  }),
                  decoration: const InputDecoration(labelText: 'Зображення'),
                  validator: (value) =>
                      value == null ? 'Оберіть зображення' : null,
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField<String>(
                  value: _selectedCategory,
                  items: categories.map((category) {
                    return DropdownMenuItem(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (value) => setState(() {
                    _selectedCategory = value;
                  }),
                  decoration: const InputDecoration(labelText: 'Категорія'),
                  validator: (value) =>
                      value == null ? 'Оберіть категорію' : null,
                ),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Назва'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Введіть назву рецепту'
                      : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(labelText: 'Опис'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Введіть опис рецепту'
                      : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _ingredientController,
                  decoration: const InputDecoration(labelText: 'Інгредієнти'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Введіть склад продукту'
                      : null,
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _instructionController,
                  decoration: const InputDecoration(labelText: 'Інструкції'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Введіть алгоритм приготування'
                      : null,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: _saveRecipe,
                  child: const Text('Зберегти'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      final recipeTitle = _titleController.text;
      final recipeDescription = _descriptionController.text;
      final recipeIngredients = _ingredientController.text.split(',');
      final recipeInstructions = _instructionController.text.split(',');

      final newRecipe = Recipe(
        title: recipeTitle,
        description: recipeDescription,
        ingredients: recipeIngredients,
        instructions: recipeInstructions,
        category: _selectedCategory ?? 'Без категорії',
        image: _selectedImage != null ? AssetImage(_selectedImage!) : null,
      );

      Provider.of<RecipeModel>(context, listen: false).addRecipe(newRecipe);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Рецепт "$recipeTitle" збережено!')),
      );

      _clearForm();
      Navigator.pop(context);
    }
  }

  void _clearForm() {
    _titleController.clear();
    _descriptionController.clear();
    _ingredientController.clear();
    _instructionController.clear();
    setState(() {
      _selectedImage = null;
      _selectedCategory = null;
    });
  }
}
