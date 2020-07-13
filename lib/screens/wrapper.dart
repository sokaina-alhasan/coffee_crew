import 'package:crew/screens/authenticate/authenticate.dart';
import 'package:crew/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:crew/models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);

    //return either home or authentication widget
    if(user==null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
