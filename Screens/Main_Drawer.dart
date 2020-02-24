import 'package:flutter/material.dart';
import 'package:new_meals_app/Screens/Filters_Screen.dart';
import 'package:new_meals_app/Screens/Tab_Bar_Screen.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(IconData icon, String title, Function pageSetter) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
      onTap: pageSetter,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 50,
      child: Column(
        children: [
          Container(
            height: 150,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            color: Theme.of(context).accentColor,
            alignment: Alignment.centerLeft,
            child: Text(
              'Hungry?',
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 60,
                fontFamily: 'RobotoCondensed',
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          buildListTile(
            Icons.restaurant,
            'Meals',
            () {
              Navigator.of(context)
                  .pushReplacementNamed(TabBarScreen.routeName);
            },
          ),
          buildListTile(
            Icons.settings,
            'Filters',
            () {
              Navigator.of(context)
                  .pushReplacementNamed(FiltersScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
