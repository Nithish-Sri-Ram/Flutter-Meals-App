import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key,
      required this.onToggleFavorite,
      required this.availableMeals});

  final List<Meal> availableMeals;
  final void Function(Meal meal) onToggleFavorite;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((element) => element.categories.contains(
              category.id,
            ))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => Meals(
                meals: filteredMeals,
                title: category.title,
                onToggleFavorite: onToggleFavorite,
              )),
    ); // Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      // padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
      ),
      children: [
        for (final i in availableCategories)
          Padding(
            padding: const EdgeInsets.all(8),
            child: CategoryGridItem(
              category: i,
              onselectCategory: () {
                _selectCategory(context, i);
              },
            ),
          ),
      ],
    );
  }
}
