import 'package:crew/models/drinks.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrinkTile extends StatelessWidget {
  Drink drink;
  DrinkTile({this.drink});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top:8.0 ),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[drink.strength],
            backgroundImage: AssetImage('assets/coffee_icon.png'),
          ),
          title: Text(drink.name),
          subtitle: Text('Take ${drink.sugars} sugar'),
        ),
      ),
    );
  }
}
