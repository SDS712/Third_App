import 'package:flutter/material.dart';

import '../Models/Recipe.dart';
import '../Widgets/Recipe_Item.dart';

class CategoryRecipesScreen extends StatefulWidget {
  final List<Recipe> availableRecipes;
  CategoryRecipesScreen(this.availableRecipes);

  static const routeName = '/Category-Recipes';
  @override
  _CategoryRecipesScreenState createState() => _CategoryRecipesScreenState();
}

class _CategoryRecipesScreenState extends State<CategoryRecipesScreen> {
  String categoryTitle;
  List<Recipe> displayedRecipes;
  bool loadedInitData = false;

  @override
  void initState() {
    //..
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (loadedInitData == false) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      displayedRecipes = widget.availableRecipes.where((recipe) {
        return recipe.categories.contains(categoryId);
      }).toList();
      super.didChangeDependencies();
      loadedInitData = true;
    }
  }

  void removeItem(String recipeId) {
    setState(() {
      displayedRecipes.removeWhere((recipe) => recipe.id == recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: (context, index) {
            return RecipeItem(
              id: displayedRecipes[index].id,
              title: displayedRecipes[index].title,
              imageUrl: displayedRecipes[index].imageUrl,
              duration: displayedRecipes[index].duration,
              complexity: displayedRecipes[index].complexity,
              affordability: displayedRecipes[index].affordability,
              removeItem: removeItem,
            );
          },
          itemCount: displayedRecipes.length,
        ),
      ),
    );
  }
}
