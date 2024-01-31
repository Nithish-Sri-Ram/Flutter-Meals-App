import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Providers/meals_provider.dart';

enum Filters {
  glutenfree,
  lactosfree,
  vegetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filters, bool>> {
  FiltersNotifier()
      : super({
          Filters.glutenfree: false,
          Filters.lactosfree: false,
          Filters.vegetarian: false,
          Filters.vegan: false,
        });

  void setFilters(Map<Filters, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filters filter, bool isActive) {
    state = {...state, filter: isActive};
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filters, bool>>(
  (ref) => FiltersNotifier(),
);

final filterredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((element) {
      if(activeFilters[Filters.glutenfree]!&& !element.isGlutenFree){    //The exclamation mark after the variable is to tell dart that the value wont be null
        return false;
      }
      if(activeFilters[Filters.lactosfree]! && !element.isLactoseFree){
        return false;
      }
      if(activeFilters[Filters.vegan]!&&!element.isVegan){
        return false;
      }
      if(activeFilters[Filters.vegetarian]!&&!element.isVegetarian){
        return false;
      }
      return true;
    }).toList();
});