import 'package:crew/screens/home/drink_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew/models/drinks.dart';
class CoffeeList extends StatefulWidget {
  @override
  _CoffeeListState createState() => _CoffeeListState();
}

class _CoffeeListState extends State<CoffeeList> {
  @override
  Widget build(BuildContext context) {
    final brews=Provider.of<List<Drink>>(context) ?? [];

    return ListView.builder(
        itemCount: brews.length,
        itemBuilder: (context,index){
          return DrinkTile(drink: brews[index]);
        });
  }
}
