import 'package:flutter/material.dart';
import 'package:flutter_home_work9/provider/recipe_list_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_home_work9/provider/recipe_model.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => RecipeModel(),
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter HW9',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const RecipeListPage(),
    );
  }
}

