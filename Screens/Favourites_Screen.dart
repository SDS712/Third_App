import 'package:flutter/material.dart';

import '../Models/Recipe.dart';
import '../Widgets/Recipe_Item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Recipe> favouriteRecipes;
  FavouritesScreen(this.favouriteRecipes);
  @override
  Widget build(BuildContext context) {
    if (favouriteRecipes.isEmpty) {
      return Center(
        child: Text('Add some favourites!'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return RecipeItem(
            id: favouriteRecipes[index].id,
            title: favouriteRecipes[index].title,
            imageUrl: favouriteRecipes[index].imageUrl,
            duration: favouriteRecipes[index].duration,
            complexity: favouriteRecipes[index].complexity,
            affordability: favouriteRecipes[index].affordability,
            // removeItem: removeItem,
          );
        },
        itemCount: favouriteRecipes.length,
      );
    }
  }
}
