import 'package:flutter/material.dart';

import 'package:favmeals/models/meal.dart';
import 'package:favmeals/screens/meal_detail_screen.dart';


class MealItem extends StatelessWidget {
    final String id;
    final String title;
    final String imageUrl;
    final int duration;
    final Complexity complexity;
    final Affordability affordability;
    final Function removeItem;

    MealItem({
      @required this.id,
      @required this.title,
      @required this.imageUrl,
      @required this.duration,
      @required this.complexity,
      @required this.affordability,
      @required this.removeItem
     });

// Getter para convertir los enums en texto
String get complexitytext {
     switch (complexity){
       case Complexity.Simple:
        return 'Simple';
        break;
       case Complexity.Challenging:
        return 'Challenging';
        break;
       case Complexity.Hard:
        return 'Hard';
        break;
       default: 
        return 'Unknown';
     }
}  

// Getter para convertir affordability
String get affordabilityText {
       switch (affordability){
       case Affordability.Affordable:
        return 'Affordable';
        break;
       case Affordability.Pricey:
        return 'Pricey';
        break;
       case Affordability.Luxurious:
        return 'Luxurious';
        break;
       default: 
        return 'Unknown';
      }
}

  void selectMeal(BuildContext context){
    //agregamos la panatalla de detalle
    Navigator.of(context)
    .pushNamed(
      MealDetailScreen.routeName,
      arguments: id,
    ).then((result){
      if (result != null) {
        removeItem(result);
      }
    });
      

  }

  @override
  Widget build(BuildContext context) {

    return InkWell(
      //-----Usamos una funcion anonima para pasarle el context
      onTap: () => selectMeal(context),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)
         ),
         elevation:  4,
         margin: EdgeInsets.all(10),
         child: Column(
           children: <Widget>[
             Stack(
               children: <Widget>[
              //----Primer elemento del stack que va debajo de todo la imagen-------------
                 //clip para redondear la imagen
                 ClipRRect(borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(15),
                   topRight: Radius.circular(15)
                 ),
                 child: Image.network(
                   imageUrl,
                   height: 250,
                   width: double.infinity,
                   fit: BoxFit.cover,
                   ),
                 ),
             // ----Segundo elemento del stack el texto-----------------------------------
             // --se cambio  Text a Widget = Positioned esto solo funciona dentro de un stack
             Positioned(
               bottom: 20,
               right: 20,
               // el txt se volvio container para agregar la propiedad width y haga salto de linea el texto
                child: Container(
                  //se definen las propedades del container para darle un backround y centrado al texto
                  width: 300,
                  //color: Colors.black54,
                  padding: EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.only(                
                      topLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)
                    )
                  ),
                  //text
                  child: Text(
                  title, 
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    ),
                      softWrap: true,
                      overflow: TextOverflow.fade,
                    ),
                ),
             )
               ]
             ),
           //----se wrapeo roww con Padding para poner los elementos debajo de la imagen
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  //acomodar los elementos de abajo
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //elementos
                  children: <Widget>[
                  Row(children: <Widget>[
                    Icon(Icons.schedule),
                    SizedBox(width: 6,),
                    Text('$duration min')
                  ],),
                  Row(children: <Widget>[
                    Icon(Icons.work),
                    SizedBox(width: 6,),
                    Text(complexitytext)
                  ],),
                  Row(children: <Widget>[
                    Icon(Icons.attach_money),
                    SizedBox(width: 6,),
                    Text(affordabilityText)
                  ],)
                ],
              ),
             )
           ]
         ),
      ),
    );
  }
}

