import 'package:flutter/material.dart';
import 'package:new_meals_app/Data/dummy-data.dart';

class RecipeDetailsScreen extends StatelessWidget {
  static const routeName = '/Recipe-Details';

  final Function toggleFavourites;
  final Function isFavourite;

  RecipeDetailsScreen(
    this.toggleFavourites,
    this.isFavourite,
  );

  Widget buildSectionTitle(context, text) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.title.copyWith(
              color: Color.fromRGBO(20, 51, 51, 1),
            ),
      ),
    );
  }

  Widget buildcontainer(context, {child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          width: 2,
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      height: 220,
      width: double.infinity,
      child: child,
      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: child,
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipeId = ModalRoute.of(context).settings.arguments;
    final selectedRecipe = DUMMY_RECIPES.firstWhere((recipe) {
      return recipe.id == recipeId;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text('${selectedRecipe.title}'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 200,
            width: double.infinity,
            child: Image.network(
              selectedRecipe.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 360,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  buildSectionTitle(context, 'Ingredients:'),
                  buildcontainer(
                    context,
                    // child: selectedRecipe.ingredients.map((ingre) {
                    //   return Container(
                    //     width: double.infinity,
                    //     child: Card(
                    //       elevation: 10,
                    //       color: Theme.of(context).accentColor,
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(10),
                    //         child: Text(
                    //           ingre,
                    //         ),
                    //       ),
                    //     ),
                    //   );
                    // }).toList(),
                    child: ListView.builder(
                      itemCount: selectedRecipe.ingredients.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Theme.of(context).accentColor,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 10,
                              horizontal: 10,
                            ),
                            child: Text(
                              selectedRecipe.ingredients[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  buildSectionTitle(context, 'Steps:'),
                  buildcontainer(
                    context,
                    child: ListView.builder(
                      itemCount: selectedRecipe.steps.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            ListTile(
                              leading: CircleAvatar(
                                child: Text(
                                  '${index + 1}',
                                ),
                              ),
                              title: Text(
                                selectedRecipe.steps[index],
                              ),
                            ),
                            Divider(
                              thickness: 1,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => toggleFavourites(recipeId),
        child: Icon(
          isFavourite(recipeId) ? Icons.star : Icons.star_border,
        ),
      ),
    );
  }
}
