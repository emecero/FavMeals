import 'package:flutter/material.dart';

import 'package:favmeals/dummy_data.dart';
import 'package:favmeals/models/meal.dart';
import 'package:favmeals/screens/settings_screen.dart';
import 'package:favmeals/screens/tabs_screen.dart';
import 'screens/categories_screen.dart';
import 'package:favmeals/screens/meal_detail_screen.dart';
import 'package:favmeals/screens/category_meals_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Map<String, bool> _settings = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _settings = filterData;

      _availableMeals = DUMMY_MEALS.where((meal){
        if (_settings['gluten'] && !meal.isGlutenFree){
          return false;
        }
        if (_settings['lactose'] && !meal.isLactoseFree){
          return false;
        }
        if (_settings['vegan'] && !meal.isVegan){
          return false;
        }
       if (_settings['vegetarian'] && !meal.isVegetarian){
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId){
    final existingIndex = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
       _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId),);
      });
    }
  }

  bool _isMealFavorite(String id){
    //any regresa true
    return _favoriteMeals.any((meal) => meal.id == id);
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'favMeals',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
          headline6: TextStyle(fontFamily: 'RobotoCondensed', fontSize: 20) 
        )
      ),
     // home: TabScreen(),
     initialRoute: '/',
      routes: {
        '/': (ctx) => TabScreen(_favoriteMeals),
        CategoryMealsScreen.routName : (ctx) => CategoryMealsScreen(_availableMeals),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isMealFavorite),
        SettingsScreen.routeName: (ctx) => SettingsScreen(_settings, _setFilters),
      },
      // Crear una ruta 404 cuando no se encuentre una pantalla a donde mandarlo
      onGenerateRoute: (settings){
        print(settings.arguments);
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
      //cuando flutter falla en mostrar una pag que se va mostrar 404
      onUnknownRoute: (settings){
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}


