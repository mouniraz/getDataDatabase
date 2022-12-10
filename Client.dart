import 'package:firebase_database/firebase_database.dart';

class Client {
  String name;
  int age;
  Client(this.name, this.age);

 /*Client.fromSnapshot(DataSnapshot snapshot) :
     name = snapshot.child("name"),
     age = snapshot.value["age"];*/
  @override
  String toString() {
    // TODO: implement toString
    return "$name $age";
  }
}
