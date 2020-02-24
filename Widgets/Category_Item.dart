import 'package:flutter/material.dart';
import '../Screens/Category_Recipes_Screen.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CategoryItem(
    this.id,
    this.title,
    this.color,
  );

  void selectCategory(context) {
    Navigator.of(context).pushNamed(
      CategoryRecipesScreen.routeName,
      arguments: {
        'id': id,
        'title': title,
      },
    );
    // Navigator.of(context).push(MaterialPageRoute(
    //   builder: (_) {
    //     return CategoryRecipesScreen();
    //   },
    // ));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(//InkWell is a type of GestureDetector with the 'splash'
      splashColor: Theme.of(context).accentColor,
      borderRadius: BorderRadius.circular(15),
      onTap: () => selectCategory(context),
      child: Container(
        padding: EdgeInsets.all(15),
        child: Center(
          child: Text(
            title,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(//gradient is used to give a gradient to the color
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
      ),
    );
  }
}
