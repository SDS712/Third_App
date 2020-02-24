import 'package:flutter/material.dart';

import '../Widgets/Category_Item.dart';
import '../Data/dummy-data.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      children: DUMMY_CATEGORIES.map(
        (catdata) {
          return CategoryItem(
            catdata.id,
            catdata.title,
            catdata.color,
          );
        },
      ).toList(),
      padding: EdgeInsets.all(15),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        //This argument is used for layouting purpose of the grid
        maxCrossAxisExtent: 300,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}
