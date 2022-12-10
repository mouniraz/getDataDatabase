import 'package:firebase_database/firebase_database.dart';

class Client {
  String name;
  int age;
  Client(this.name, this.age);


  @override
  String toString() {
    // TODO: implement toString
    return "$name $age";
  }
}
