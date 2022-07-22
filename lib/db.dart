import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import "models.dart";

Future<Database> connectToDB() async {
  WidgetsFlutterBinding.ensureInitialized();

  return openDatabase(
      join(await getDatabasesPath(), "shoppinglist.db"),
      onCreate: (db, version) {
        return db.execute(
            "CREATE TABLE IF NOT EXISTS lists(id INTEGER PRIMARY KEY, title TEXT);"
        );
      },
      version: 0
  );
}

Future<List<ListEntry>> getEntries() async {
  final db = await connectToDB();

  final List<Map<String, dynamic>> maps = await db.query("lists");

  return List.generate(maps.length, (index) {
    return ListEntry(id: maps[index]["id"], title: maps[index]["title"]);
  });
}