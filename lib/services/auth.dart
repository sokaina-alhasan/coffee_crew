import 'package:crew/models/user.dart';
import 'package:crew/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth= FirebaseAuth.instance;

  //create user object based on FirebaseUser
  User userFromFirbase(FirebaseUser user){
    return user!= null ? User(uid: user.uid) :null;
  }
  //auth change user stream
  Stream<User>  get userStream{
    return _auth.onAuthStateChanged.map((FirebaseUser user) => userFromFirbase(user));
 }
  //sign in anon
 Future signInAnon() async{
   try{
     AuthResult result=await _auth.signInAnonymously();
     FirebaseUser user=result.user;
     return userFromFirbase(user);
   }catch(e){
     print(e);
     return null;
   }
 }
  //sign in with email and password
    Future signInWithEmailAndPassword(String email,String password)async{
    try{
      AuthResult result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;
      return userFromFirbase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
    }
  //Register with email and password
    Future signUpWithEmailAndPassword(String email, String password)async{
    try{
      AuthResult result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user=result.user;

      //create new document for user with that id
      await DatabaseServices(uid: user.uid).updateSetData('0', 'New User', 100);
      return userFromFirbase(user);
    }catch(e){
      print(e.toString());
      return null;
    }
    }


  //log out
    Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
    }
}