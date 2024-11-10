import 'package:flutter/material.dart';
import 'package:flutter_home_work9/models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({super.key,
    required this.recipe,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [

            // ClipRRect(
            //   borderRadius: BorderRadius.circular(8),
            //   child: Image.asset(
            //     'assets/images/placeholder.jpg',
            //     width: 60,
            //     height: 60,
            //     fit: BoxFit.cover,
            //   ),
            // ),
            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.category,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  Text(
                    recipe.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    recipe.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
