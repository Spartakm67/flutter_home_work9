import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>(); // Ключ для форми
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Якщо форма валідна
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Форма успішно надіслана!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Форма реєстрації')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Ім\'я',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введіть ваше ім\'я';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Електронна пошта',
                  border: OutlineInputBorder(),
                ),
                autofocus: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введіть електронну пошту';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Введіть дійсну електронну пошту';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Відправити'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}

// class RecipeForm extends StatefulWidget {
//   const RecipeForm({super.key});
//
//   @override
//   _RecipeFormState createState() => _RecipeFormState();
// }
//
// class _RecipeFormState extends State<RecipeForm> {
//   final _formKey = GlobalKey<FormState>();
//   String _recipeTitle = '';
//   String _recipeDescription = '';
//   String? _selectedCategory;
//
//   // Доступні категорії
//   final List<String> categories = [
//     'Сніданок',
//     'Обід',
//     'Вечеря',
//     'Десерт'
//   ];
//
//   void _saveRecipe() {
//     if (_formKey.currentState!.validate()) {
//       // Зберігаємо дані форми
//       _formKey.currentState!.save();
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Рецепт збережено! Назва: $_recipeTitle')),
//       );
//
//       // Логіка для збереження рецепту в базі даних чи іншому сховищі
//       print('Назва рецепту: $_recipeTitle');
//       print('Опис рецепту: $_recipeDescription');
//       print('Категорія: $_selectedCategory');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Створити рецепт')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Назва'),
//                 onSaved: (value) => _recipeTitle = value!,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Введіть назву рецепту';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               TextFormField(
//                 decoration: const InputDecoration(labelText: 'Опис'),
//                 onSaved: (value) => _recipeDescription = value!,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Введіть опис рецепту';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               DropdownButtonFormField<String>(
//                 value: _selectedCategory,
//                 items: categories.map((category) {
//                   return DropdownMenuItem(
//                     value: category,
//                     child: Text(category),
//                   );
//                 }).toList(),
//                 onChanged: (value) => setState(() {
//                   _selectedCategory = value!;
//                 }),
//                 decoration: const InputDecoration(labelText: 'Категорія'),
//                 validator: (value) {
//                   if (value == null) {
//                     return 'Оберіть категорію';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16.0),
//               ElevatedButton(
//                 onPressed: _saveRecipe,
//                 child: const Text('Зберегти'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class RecipeForm extends StatefulWidget {
  @override
  _RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  final _formKey = GlobalKey<FormState>();

  // Контролери для введення назви та опису
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String? _selectedCategory;

  // Доступні категорії
  final List<String> categories = [
    'Сніданок',
    'Обід',
    'Вечеря',
    'Десерт'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      // Зберігаємо дані форми
      final recipeTitle = _titleController.text;
      final recipeDescription = _descriptionController.text;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Рецепт "$recipeTitle" збережено!')),
      );

      print('Назва рецепту: $recipeTitle');
      print('Опис рецепту: $recipeDescription');
      print('Категорія: $_selectedCategory');

      // Очищення полів після збереження
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
      appBar: AppBar(title: Text('Створити рецепт')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Назва'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введіть назву рецепту';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Опис'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введіть опис рецепту';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
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
                decoration: InputDecoration(labelText: 'Категорія'),
                validator: (value) {
                  if (value == null) {
                    return 'Оберіть категорію';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _saveRecipe,
                child: Text('Зберегти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}