import 'package:crew/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:crew/services/auth.dart';
import 'package:crew/shared/loading.dart';
class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email;
  String password;
  String error=' ';
  bool loading=false;
  final AuthService _auth= AuthService();
  final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign Up Page'),
        backgroundColor: Colors.brown[400],
        centerTitle: true,
        actions: [
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Sign In'))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith( hintText: 'Enter Email',),
                validator: (val){
                  if(val.isEmpty){
                    return 'Enter email';
                  }else{
                    return null;
                  }
                },
                onChanged: (val){
                  setState(() {
                    return  email=val;
                  });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Password'),
                validator:  (val){
                  if(val.length<6){
                    return '6+ Digit or more';
                  }else{
                    return null;
                  }
                },
                obscureText: true,
                onChanged: (val){
                  setState( ()=>password=val);
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.pink,
                child: Text('Register',
                  style: TextStyle(color: Colors.white,fontSize: 20.0),),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      return loading=true;
                    });
                    dynamic result=await _auth.signUpWithEmailAndPassword(email, password);
                    if(result == null){
                      setState(() {
                        loading= false;
                        return error='Enter valid Email';
                      });
                    }
                  }
                },
              ),
              SizedBox(height: 20.0,),
              Text(error,style: TextStyle(color: Colors.red,fontSize: 25.0),),
            ],
          ),
        ),
      ),
    );
  }
}
