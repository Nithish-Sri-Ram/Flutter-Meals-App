import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>>{
  FavouriteMealsNotifier():super([]);

  bool toggleMealsFavouriteStatus(Meal meal){
    final mealIsFavourite = state.contains(meal);
//Adding and removing the elements without the remove() function
    if(mealIsFavourite){
      state=state.where((m) => m.id != meal.id).toList();
      return false;
    }
    else{
      state = [...state,meal];
      return true;    //adds the 'meal' to the already existing list if it does no exist in list
    }

  }
}

final favoiriteMealsProvider = StateNotifierProvider<FavouriteMealsNotifier,List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});  //Used for non static lists