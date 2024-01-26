import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

const kIntitializer={
  Filters.glutenfree: false,
  Filters.lactosfree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreeen extends StatefulWidget {
  const TabsScreeen({super.key});
  @override
  State<TabsScreeen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreeen> {

  int _selectedPage = 0;
  final List<Meal> _favouriteMeals = [];
  Map<Filters,bool> _selectedFilters={
    Filters.glutenfree: false,
    Filters.lactosfree: false,
    Filters.vegetarian: false,
    Filters.vegan: false,
  };

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavouriteStatus(Meal meal) {
    final isExisting = _favouriteMeals.contains(meal);

    if (isExisting) {
      setState(() {
        _favouriteMeals.remove(meal);
        _showInfoMessage('Meal is no longer a favourite.');
      });
    } else {
      setState(() {
        _favouriteMeals.add(meal);
        _showInfoMessage('Marked as a favourite');
      });
    }
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  void _setScreen(String identifier) async {
    //Async is used to invoke await keyword to wait until a key is pressed
    Navigator.of(context).pop(); 
    if (identifier == 'filters') {
          //pushreplacement insted of push() - to replace screens insted of stacking up one on another

      //The push method return value - The returned data is stored seperately
      final result = await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(currentFilter: _selectedFilters,),
        ),
      );
      setState(() {
      _selectedFilters=result??kIntitializer;    //The double question mark sets a fallback value if the result value is null 
      });
      // print(result);  To check if values are returned
    } 
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals=dummyMeals.where((element) {
      if(_selectedFilters[Filters.glutenfree]!&& !element.isGlutenFree){    //The exclamation mark after the variable is to tell dart that the value wont be null
        return false;
      }
      if(_selectedFilters[Filters.lactosfree]! && !element.isLactoseFree){
        return false;
      }
      if(_selectedFilters[Filters.vegan]!&&!element.isVegan){
        return false;
      }
      if(_selectedFilters[Filters.vegetarian]!&&!element.isVegetarian){
        return false;
      }
      return true;
    }).toList();

    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavouriteStatus,
      availableMeals: availableMeals,
    );
    Widget activePageTitle = const Text('Categories');

    if (_selectedPage == 1) {
      activePage = Meals(
        meals: _favouriteMeals,
        onToggleFavorite: _toggleMealFavouriteStatus,
      );
      activePageTitle = const Text('Your favourites');
    }
    return Scaffold(
      appBar: AppBar(
        title: activePageTitle,
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(
                (Icons.star),
              ),
              label: 'Favourites')
        ],
      ),
    );
  }
}