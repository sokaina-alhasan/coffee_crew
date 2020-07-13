import 'package:crew/services/auth.dart';
import 'package:crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:crew/shared/constants.dart';
class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  String email;
  String password;
  String error='';
  bool loading=false;
  final _formKey=GlobalKey<FormState>();
  final AuthService _auth= AuthService();
  @override
  Widget build(BuildContext context) {
    return loading ? Loading(): Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        title: Text('Sign In Page'),
        backgroundColor: Colors.brown[400],
        centerTitle: true,
        actions: [
          FlatButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register'))
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
                validator: (val) => val.isEmpty ? 'Enter an Email' : null,
                onChanged: (val){
                 setState(() {
                   return  email=val;
                 });
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: textInputDecoration.copyWith(hintText: 'Enter Password'),
                validator: (val) => val.length < 6  ? 'Enter password 6+ digit': null,
                obscureText: true,
                onChanged: (val){
                  setState( ()=>password=val);
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Colors.pink,
                child: Text('Sign In',
                  style: TextStyle(color: Colors.white,fontSize: 20.0),),
                onPressed: () async{
                  if(_formKey.currentState.validate()){
                    setState(() {
                      return loading=true;
                    });
                    dynamic result=await _auth.signInWithEmailAndPassword(email, password);
                    if(result==null){
                      setState(() {
                        loading= false;
                        return error='Email Or Password are NOT correct!';
                      });
                    }
                  }
                }

                ,
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
