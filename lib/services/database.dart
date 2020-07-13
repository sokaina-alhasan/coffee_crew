import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crew/models/drinks.dart';
import 'package:crew/models/user.dart';
class DatabaseServices{
  final String uid;
  DatabaseServices({this.uid});

  //Collection reverence
  final CollectionReference coffeeCollection=Firestore.instance.collection('drinks');


  Future updateSetData (String sugar,String name,int strength) async{
    
    return await coffeeCollection.document(uid).setData({
      'name': name,
      'sugars':sugar,
      'strength':strength,
      }

    );
  }
  List<Drink> _drinkListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc)  {
      return Drink(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'] ?? '0',
        strength: doc.data['strength'] ?? 0,

      );
    }).toList();
  }


  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );

  }



     Stream<List<Drink>> get coffeeStream {

      return coffeeCollection.snapshots().map(_drinkListFromSnapShot);

    }
    Stream<UserData> get userDataStream{
      return coffeeCollection.document(uid).snapshots()
          .map(_userDataFromSnapshot);
    }
}