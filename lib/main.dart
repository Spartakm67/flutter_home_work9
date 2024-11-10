import 'package:flutter/material.dart';
import 'package:flutter_home_work9/screens/recipe_list_screen.dart';
import 'package:flutter_home_work9/widgets/recipe_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: BuilderListView(),
      home: RecipeList(),
    );
  }
}

