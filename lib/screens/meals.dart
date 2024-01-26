import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/details_screen.dart';
import 'package:meals_app/widgets/meal_item.dart';
// import 'package:meals_app/screens/diaplay_meals.dart';

class Meals extends StatelessWidget {
  const Meals({
    super.key,
    required this.meals,
    this.title,
    required this.onToggleFavorite
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;

  void selectMeal(BuildContext context,Meal meal)
  {
    Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>DetailsScreen(meal: meal,onToggleFavorite: onToggleFavorite,)));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        children: [
          Text(
            'Uh of ... nothing here!',
            style: Theme.of(context)
                .textTheme
                .headlineLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );
    if (meals.isNotEmpty) {
      content = ListView.builder(
        itemCount: meals.length, //Compulsary to include this parameter
        itemBuilder: ((ctx, index) => MealItem(meal: meals[index],onSelectMeal: (meal){
          selectMeal(context, meal);
        },)),
      );
    }

    if(title==null)
    {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
