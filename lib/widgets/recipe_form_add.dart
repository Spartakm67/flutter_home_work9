import 'package:flutter/material.dart';

class RecipeForm extends StatefulWidget {
  const RecipeForm({super.key});

  @override
  RecipeFormState createState() => RecipeFormState();
}

class RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;

  final List<String> categories = [
    'Сніданок',
    'Обід',
    'Вечеря',
    'Десерт',
    'Млинці',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      final recipeTitle = _titleController.text;
      final recipeDescription = _descriptionController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Рецепт "$recipeTitle" збережено!')),
      );

      print('Назва рецепту: $recipeTitle');
      print('Опис рецепту: $recipeDescription');
      print('Категорія: $_selectedCategory');

      _titleController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedCategory = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Створити рецепт')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Назва'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введіть назву рецепту';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Опис'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введіть опис рецепту';
                  }
                  return null;
                },
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
                validator: (value) {
                  if (value == null) {
                    return 'Оберіть категорію';
                  }
                  return null;
                },
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
    );
  }
}