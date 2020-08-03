import 'package:flutter/material.dart';

import 'package:favmeals/dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function togglefavorite;
  final Function isFavorite;

  MealDetailScreen(this.togglefavorite, this.isFavorite);

Widget buildSectionTitle(BuildContext context, String text){
    return Container(
           margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              text, 
              style: Theme.of(context).textTheme.headline6)
);
  }


Widget buildContainer(Widget child){

  return  Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color:Colors.grey),
              borderRadius: BorderRadius.circular(10)
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            height: 150,
            width: 300,
            child: child,
     );
}


  @override
  Widget build(BuildContext context) {
    //Pasamos los argumentos de la pagina meal_Item
    final mealId = ModalRoute.of(context).settings.arguments as String;
    // importamos el dato de dummy meals y lo buscamos comparando el id => meal.id regresa tru o false
    final selectedMeal = DUMMY_MEALS.firstWhere((meal) => meal.id == mealId);
    //Toda screen debe regresar un scaffold que forma la screen background....
    return Scaffold(
      appBar: AppBar(title: Text('${selectedMeal.title}')),
      //Aqui la culumna la cambiamos por el widget SingleChildScrollView
      body: SingleChildScrollView(
              child: Column(
          children: <Widget>[
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl,
              fit: BoxFit.cover,
              ), 
              ),
            //agregamos el widget builTitle  
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
               ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  color: Theme.of(context).accentColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                    vertical: 5, 
                    horizontal: 10),
                    child: Text(selectedMeal.ingredients[index])), 
                ),
                 itemCount: selectedMeal.ingredients.length,
              ),       
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(ListView.builder(          
              itemBuilder: (ctx, index) => Column(children: [ListTile(
                leading: CircleAvatar(
                  child: Text('# ${index + 1}')
                  ),
                  title: Text(selectedMeal.steps[index]),
              ), 
              Divider()
              ], ),
              itemCount: selectedMeal.steps.length,
              ))
          ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child:Icon(
          isFavorite(mealId) ? Icons.star : Icons.star_border,
          ),
          onPressed: () => togglefavorite(mealId),
        ),
      );
  }
}