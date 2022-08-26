import 'package:flutter/material.dart';
import 'package:shopping/db.dart';
import 'package:shopping/metalist.dart';
import 'package:sqflite/sqflite.dart';


void main() async {
  Database db = await DBHandler.connectToDB();
  runApp(App(db: db));
}

class App extends StatelessWidget {
  const App({Key? key, required this.db}) : super(key: key);

  final Database db;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Einkaufsliste',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Overview(db: db)
    );
  }
}
