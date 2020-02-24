import 'package:flutter/material.dart';
import 'package:new_meals_app/Screens/Main_Drawer.dart';

import '../Models/Recipe.dart';

import 'Categories_Screen.dart';
import 'Favourites_Screen.dart';

class TabBarScreen extends StatefulWidget {
  final List<Recipe> favoriteRecipes;
  TabBarScreen(this.favoriteRecipes);

  static const routeName = '/Tab-Bar-Screen';
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  List<Map<String, Object>> pages;
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    pages = [
      {
        'Page': CategoriesScreen(),
        'appBarTitle': 'Categories',
      },
      {
        'Page': FavouritesScreen(widget.favoriteRecipes),
        'appBarTitle': 'Favourites',
      },
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /*return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meals'),
          bottom: TabBar(tabs: [
            Tab(
              icon: Icon(Icons.category),
              text:
                  'Catgories', //Note: this doesn't take a Text widget but a string
            ),
            Tab(
              icon: Icon(Icons.star),
              text: 'Favourites',
            ),
          ]),
        ),
        body: TabBarView(children: [//Order of the children should match with the order of the Tabs inside TabBar
          CategoriesScreen(),
          FavouritesScreen(),
        ]),
      ),
    );*/

    return Scaffold(
      appBar: AppBar(
        title: Text(pages[_selectedPageIndex]['appBarTitle']),
      ),
      drawer: MainDrawer(),
      body: pages[_selectedPageIndex]['Page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentIndex) => _selectPage(currentIndex),
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: _selectedPageIndex,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            title: Text('Categories'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            title: Text('Favourites'),
          ),
        ],
      ),
    );
  }
}
