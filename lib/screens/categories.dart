import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  //Merging another class
  late AnimationController
      _animationController; //To tell dart that a value will be assigned once this variable is used

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this, //Obtained from the singletinker class
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = widget.availableMeals
        .where((element) => element.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (ctx) => Meals(
                meals: filteredMeals,
                title: category.title,
              )),
    ); // Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
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
            ),
        builder: (context, child) => SlideTransition(
        position: Tween(
        begin: const Offset(0,0.3),
        end: const Offset(0, 0)
        ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeInOut)),
        child: child,
    )
    );
  }
}
