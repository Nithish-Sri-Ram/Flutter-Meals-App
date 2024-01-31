import 'package:flutter/material.dart';
import 'package:meals_app/Providers/favoirites_provider.dart';
// import 'package:meals_app/Providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/Providers/filters_provider.dart';

const kIntitializer={
  Filters.glutenfree: false,
  Filters.lactosfree: false,
  Filters.vegetarian: false,
  Filters.vegan: false,
};

class TabsScreeen extends ConsumerStatefulWidget {    //Stateful widet has t0 be changed to Consumerstateful widget
  const TabsScreeen({super.key});
  @override
  ConsumerState<TabsScreeen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreeen> {

  int _selectedPage = 0;

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
      await Navigator.of(context).push<Map<Filters, bool>>(
        MaterialPageRoute(
          builder: (ctx) => const FiltersScreen(),
        ),
      );
      // print(result);  To check if values are returned
    } 
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals=ref.watch(filterredMealsProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    Widget activePageTitle = const Text('Categories');

    if (_selectedPage == 1) {
      final favouriteMeals=ref.watch(favoiriteMealsProvider);
      activePage = Meals(
        meals: favouriteMeals,
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