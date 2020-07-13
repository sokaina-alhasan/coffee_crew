import 'package:crew/models/user.dart';
import 'package:crew/services/database.dart';
import 'package:crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:crew/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey=GlobalKey<FormState>();
  List<String> sugars=['0','1','2','3','4'];
  String currentName;
  String currentSugars;
  int currentStrength;

  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseServices(uid: user.uid).userDataStream,
      builder: (context, snapshot) {

        if(snapshot.hasData){
          UserData userData=snapshot.data;
        return Form(
          key: _formKey,
          child: Column(
            children: [
              Text('Update your drink settings',
                style: TextStyle(fontSize: 20.0,),
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                initialValue: userData.name,
                decoration: textInputDecoration,
                onChanged: (val){
                  return setState(()=>currentName = val);
                },
                validator: (val){
                  return val.isEmpty ? 'Please Enter a name' : null;
                },
              ),
              SizedBox(height: 20.0,),
              DropdownButtonFormField(
                value: currentSugars ?? userData.sugars,
                items: sugars.map((sugar) {
                  return DropdownMenuItem(
                    value: sugar,
                    child: Text('$sugar Sugars'),
                  );}
                ).toList(),
                onChanged: (val)=> setState(()=>currentSugars=val),
              ),
              SizedBox(height: 20.0,),
              Slider(
                value: (currentStrength ?? userData.strength).toDouble(),
                min: 100,
                max: 900,
                divisions: 8,
                activeColor: Colors.brown[currentStrength ?? userData.strength],
                inactiveColor: Colors.brown[currentStrength ?? userData.strength],
                onChanged: (val){
                  return setState(()=>currentStrength=val.round());
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.pink[400],
                child: Text('Update',style: TextStyle(fontSize: 20.0,color: Colors.white),),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    DatabaseServices(uid: user.uid).updateSetData(
                        currentSugars ?? userData.sugars,
                        currentName ?? userData.name,
                        currentStrength ?? userData.strength);
                    Navigator.pop(context);
                  }
                },
              )


            ],
          ),
        );
        }
        else{
          return Loading();
        }
      }
    );
  }
}
