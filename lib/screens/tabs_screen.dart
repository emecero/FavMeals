import 'package:flutter/material.dart';

import 'package:favmeals/screens/categories_screen.dart';
import 'package:favmeals/screens/favorites_screen.dart';
import 'package:favmeals/widgets/main_drawer.dart';
import 'package:favmeals/models/meal.dart';



class TabScreen extends StatefulWidget {

  final List<Meal> favoriteMeals;

  TabScreen(this.favoriteMeals);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  List<Map<String, Object>> _pages;
  int _selectedPageIndex = 0;

  @override
  void initState() { 
    _pages =[
   {
     'page': CategoriesScreen(), 
     'title': 'Categories'
     },
   {
     'page': FavoritesScreen(widget.favoriteMeals), 
     'title': 'Your Favorite'
     },
  ];
    super.initState();
    
  }


  void _selectPage(int index) {
    setState(() {     
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         appBar: AppBar(        
           title: Text(_pages[_selectedPageIndex]['title']),          
          ),
          drawer: MainDrawer(),
          body: _pages[_selectedPageIndex]['page'],
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
           backgroundColor: Theme.of(context).primaryColor,
           unselectedItemColor: Theme.of(context).focusColor,
           selectedItemColor: Colors.white,

           currentIndex: _selectedPageIndex,
           type: BottomNavigationBarType.fixed,
           items: [
             BottomNavigationBarItem(
               backgroundColor: Theme.of(context).primaryColor,
               icon: Icon(Icons.category),
               title: Text('Categories')
               ),
             BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
               icon: Icon(Icons.star),
               title: Text('Favorites')
               )
           ],
           ),
          
         ); 
       
    
  }
}