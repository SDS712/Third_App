import 'package:flutter/material.dart';

import './Data/dummy-data.dart';

import './Models/Recipe.dart';

import './Screens/Filters_Screen.dart';
import './Screens/Recipe_Details_Screen.dart';
import './Screens/Tab_Bar_Screen.dart';
import './Screens/Category_Recipes_Screen.dart';

import './Screens/Categories_Screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegetarian': false,
    'vegan': false,
  };

  List<Recipe> availableRecipes = DUMMY_RECIPES;
  List<Recipe> favouriteRecipes = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
      availableRecipes = DUMMY_RECIPES.where((recipe) {
        if (_filters['gluten'] == true && recipe.isGlutenFree == false) {
          return false;
        }
        if (_filters['lactose'] == true && recipe.isLactoseFree == false) {
          return false;
        }
        if (_filters['vegetarian'] == true && recipe.isVegetarian == false) {
          return false;
        }
        if (_filters['vegan'] == true && recipe.isVegan == false) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void toggleFavourites(String recipeId) {
    final existingIndex = favouriteRecipes.indexWhere(
      (recipe) => recipe.id == recipeId,
    );
    if (existingIndex >= 0) {
      setState(() {
        favouriteRecipes.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favouriteRecipes.add(
          DUMMY_RECIPES.firstWhere(
            (recipe) => recipe.id == recipeId,
          ),
        );
      });
    }
  }

  bool isFavourite(String recipeId) {
    return favouriteRecipes.any(
      (recipe) => recipe.id == recipeId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: //canvasColor means background color(color of the body)
            // Colors.white,
            Color.fromRGBO(255, 254, 229, 1), //here, 'O' is the opacity which
        //indicates contrast as per my opinion
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              //copyWith is used to add extra features
              body1: TextStyle(
                color:
                    // Colors.red,
                    Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color:
                    // Colors.yellow,
                    Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // initialRoute: '/',
      home: TabBarScreen(
          favouriteRecipes), //The Screen/Widget which is put inside of the the home: named argument
      //is declared as homescreen
      routes: {
        // '/': (_) => TabBarScreen(),
        TabBarScreen.routeName: (_) => TabBarScreen(favouriteRecipes),
        CategoryRecipesScreen.routeName: (_) =>
            CategoryRecipesScreen(availableRecipes),
        RecipeDetailsScreen.routeName: (_) =>
            RecipeDetailsScreen(toggleFavourites, isFavourite),
        FiltersScreen.routeName: (_) => FiltersScreen(
              _filters,
              _setFilters,
            ),
      }, //routes are used to create routes to the particular screens and naming those routes
      onGenerateRoute: (settings) {
        //When generating routes dynamically, if the route generated is not mentioned in the
        //routes table then onGenerateRoute(as a Default Route) is reached.
        print(settings.arguments);
        // return MaterialPageRoute(
        //   builder: (context) => CategoriesScreen(),
        // );0
      }, //It takes a function which executes for any named navigation action (= pushNamed())
      // for which no registered route was found in the routes table. You should return a navigation action (e.g.
      //MaterialPageRoute) in onGenerateRoute

      onUnknownRoute: (settings) {
        //onUnknownRoute is reached when flutter is unable to build
        //screen with all other measures taken like on GenerateRoute as a last result or a 'Fallback Page'
        //For Eg. 404 page/could not connect to internet Page,etc
        return MaterialPageRoute(
          builder: (context) => CategoriesScreen(),
        );
      }, //So,onGenerateRoute executes for any unregistered named route,
      // onUnknownRoute executes if onGenerateRoute isn't defined or doesn't return a valid navigation action.
    );
  }
}
