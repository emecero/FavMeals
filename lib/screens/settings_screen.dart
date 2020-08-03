import 'package:favmeals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {

  static const routeName = '/settings';

  final Function saveFilters;
  final Map<String, bool> currentSettings;

  SettingsScreen(this.currentSettings, this.saveFilters);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

bool _glutenFree = false;
bool _vegetarianFree = false;
bool _vegan = false;
bool _lactoseFree = false;

@override
void initState() { 
  _glutenFree = widget.currentSettings['gluten'];
  _lactoseFree = widget.currentSettings['lactose'];
  _vegan = widget.currentSettings['vegan'];
  _vegetarianFree = widget.currentSettings['vegetarian'];
  super.initState();
  
}


Widget _buildSwitchListTile(String title, String description, bool currentValue, Function updateValue){
  return SwitchListTile(
            title: Text(title), 
            value: currentValue, 
            subtitle: Text(description
            ),
            onChanged: updateValue
          );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save),
          onPressed: () {
           final selectedFiltres = {
                 'gluten': _glutenFree,
                 'lactose': _lactoseFree,
                 'vegan': _vegan,
                 'vegetarian': _vegetarianFree,
           };
            widget.saveFilters(selectedFiltres);
          },
          ),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20), 
          child: Text(
            'Adjust your meal selection',
            style: Theme.of(context).textTheme.headline6,
          )
        ),
        Expanded(child: ListView(children: <Widget>[
          _buildSwitchListTile(
            'Gluten Free', 
            'Only include gluten-free meals', 
            _glutenFree, 
            (newValue){
            setState((){
              _glutenFree = newValue;
            });}
            ),
          _buildSwitchListTile(
            'Lactose Free', 
            'Only include lactose-free meals', 
            _lactoseFree, 
            (newValue){
            setState((){
              _lactoseFree = newValue;
            });}
            ),
           _buildSwitchListTile(
            'Vegeterian', 
            'Only include vegeterian meals', 
            _vegetarianFree, 
            (newValue){
            setState((){
              _vegetarianFree = newValue;
            });}
            ),
          _buildSwitchListTile(
            'Vegan', 
            'Only include vegan meals', 
            _vegan, 
            (newValue){
            setState((){
              _vegan = newValue;
            });}
            ),
         ],
        ),
       )
      ],
     ),
    );
  }
}