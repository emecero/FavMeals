import 'package:flutter/material.dart';

import 'package:favmeals/screens/categories_screen.dart';
import 'package:favmeals/widgets/meal_item.dart';
import 'package:favmeals/models/meal.dart';




class CategoryMealsScreen extends StatefulWidget {

  // para no escribir el string y despues cagarla al escribirlo
  static const routName = '/category-meals';

  final List<Meal> availableMeals;

  CategoryMealsScreen(this.availableMeals);

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;

  @override
  void initState() {
    
    super.initState();
  }

  @override
  void didChangeDependencies() {
    final routeArgs =
     ModalRoute.of(context).settings.arguments as Map<String, String>;
     categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];
     displayedMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId){
      setState(() {
        displayedMeals.removeWhere((meal) => meal.id == mealId);
      });
  }




  @override
  Widget build(BuildContext context) {


    return Scaffold(
        appBar: AppBar(
          title: Text(categoryTitle),
        ),
        body: ListView.builder(itemBuilder: (ctx, index){
          return MealItem(
            id: displayedMeals[index].id,
            title: displayedMeals[index].title,
            imageUrl: displayedMeals[index].imageUrl,
            duration: displayedMeals[index].duration,
            affordability: displayedMeals[index].affordability,
            complexity: displayedMeals[index].complexity,
            removeItem: _removeMeal,
          );
        }, itemCount: displayedMeals.length,),
    ); 
  }
}