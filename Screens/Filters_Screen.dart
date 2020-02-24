import 'package:flutter/material.dart';
import 'package:new_meals_app/Screens/Main_Drawer.dart';

class FiltersScreen extends StatefulWidget {
  final Map<String, bool> currentFilters;
  final Function setFilters;
  FiltersScreen(this.currentFilters, this.setFilters);
  static const routeName = '/Filters-Screen';

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _isGlutenFree;
  bool _isLactoseFree;
  bool _isvegetarian;
  bool _isvegan;
  bool loadedInitData = false;

  @override
  void initState() {
    super.initState();
    if (loadedInitData == false) {
      _isGlutenFree = widget.currentFilters['gluten'];
      _isLactoseFree = widget.currentFilters['lactose'];
      _isvegetarian = widget.currentFilters['vegetarian'];
      _isvegan = widget.currentFilters['vegan'];
      loadedInitData = true;
    }
  }

  Widget buildSwitchListTile(
      String title, bool currentValue, Function updateFunction) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text('Only include $title meals'),
      value: currentValue,
      onChanged: updateFunction,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _isGlutenFree,
                'lactose': _isLactoseFree,
                'vegetarian': _isvegetarian,
                'vegan': _isvegan,
              };
              print(selectedFilters);
              widget.setFilters(selectedFilters);
            },
            icon: Icon(
              Icons.save,
            ),
            iconSize: 26,
          ),
        ],
        title: Text('Filters!'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.all(15),
            child: Text(
              'Adjust as per your meal selection!',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                buildSwitchListTile(
                  'Gluten-free',
                  _isGlutenFree,
                  (newValue) {
                    setState(() {
                      _isGlutenFree = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'Lactose-free',
                  _isLactoseFree,
                  (newValue) {
                    setState(() {
                      _isLactoseFree = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'Vegetarian',
                  _isvegetarian,
                  (newValue) {
                    setState(() {
                      _isvegetarian = newValue;
                    });
                  },
                ),
                buildSwitchListTile(
                  'Vegan',
                  _isvegan,
                  (newValue) {
                    setState(() {
                      _isvegan = newValue;
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
