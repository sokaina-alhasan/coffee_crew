import 'package:crew/screens/home/coffee_list.dart';
import 'package:crew/screens/home/settings_form.dart';
import 'package:crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew/services/database.dart';
import 'package:crew/models/drinks.dart';



class Home extends StatelessWidget {
  final AuthService _auth=AuthService();
  @override
  Widget build(BuildContext context) {

    void _ShowSettingPanel(){
      showModalBottomSheet(context: context, builder: (context){
        return Container(
          color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 60.0),
            child: SettingsForm(),
          ),
        );
      });
    }
    return StreamProvider<List<Drink>>.value(
      value: DatabaseServices().coffeeStream,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: Text('Coffee Crew'),
          elevation: 0.0,
          backgroundColor: Colors.brown[500],
          actions: [
            FlatButton.icon(
                onPressed: ()async{
                  await _auth.signOut();
                },
                icon: Icon(Icons.person,size: 34.0,),
                label: Text('LogOut'
                          ,style: TextStyle(fontSize: 20.0),    )
            ),
            FlatButton.icon(
                onPressed: ()=> _ShowSettingPanel(),
                icon: Icon(Icons.settings),
                label: Text('Setting')),
            FlatButton.icon(
                onPressed: ()=> _ShowSettingPanel(),
                icon: Icon(Icons.delete),
                label: Text(''))
          ],
        ),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/coffee_bg.png'),
                fit: BoxFit.fill
              )
            ),
            child: CoffeeList()),
      ),
    );
  }
}
