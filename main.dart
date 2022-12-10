import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:databasefire/Client.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_core/firebase_core.dart';
import 'User.dart';
import 'firebase_options.dart';
import 'package:email_validator/email_validator.dart';

void main() {
  initFirebase();
  runApp(const MyApp());
}

Future<void> initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "test"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final _emailController = TextEditingController();
  bool _validateemail = false;
  List<User> list = [];
  var stream;
  final _passwordcontroller = TextEditingController();
  bool _validatemdp = false;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getdata(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return (ListView.builder(
              itemBuilder: (context, index) {
                return Text(snapshot.data![index].name);
              },
              itemCount: snapshot.data!.length,
            ));
          }
          if (snapshot.hasError) {
            return (Text("error"));
          }
          return (CircularProgressIndicator());
        },
      ),
    );
  }

  Future<List<Client>> getdata() async {
    FirebaseDatabase database = FirebaseDatabase.instance;
    final data = await database.ref().child("data/clients").get();
    List<Client> list = [];
    for (var v in data.children) {
      list.add(Client(
          v.child("name").value.toString(), v.child("age").value as int));
    }

    return list;
  }
}
