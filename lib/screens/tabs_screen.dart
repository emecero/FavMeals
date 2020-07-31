import 'package:favmeals/screens/categories_screen.dart';
import 'package:favmeals/screens/favorites_screen.dart';
import 'package:favmeals/widgets/main_drawer.dart';
import 'package:flutter/material.dart';


class TabScreen extends StatefulWidget {
  TabScreen({Key key}) : super(key: key);

  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  final List<Map<String, Object>> _pages = [
   {
     'page': CategoriesScreen(), 
     'title': 'Categories'
     },
   {
     'page': FavoritesScreen(), 
     'title': 'Your Favorite'
     },
  ];
  int _selectedPageIndex = 0;


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