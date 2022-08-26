import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import "models.dart";


class DBHandler {

  static Future<Database> connectToDB() async {
    WidgetsFlutterBinding.ensureInitialized();

    void createTables(Database db) {
      db.execute("CREATE TABLE IF NOT EXISTS lists (id INTEGER PRIMARY KEY, title TEXT);");
      db.execute("CREATE TABLE IF NOT EXISTS entries (id INTEGER PRIMARY KEY, listid INTEGER, title TEXT, done INTEGER);");
    }

    return openDatabase(
        join(await getDatabasesPath(), "shoppinglist.db"),
        onCreate: (db, version) {
          return createTables(db);
        },
        version: 1
    );
  }

  static Future<List<Metalist>> getLists(Database db) async {
    final List<Map<String, dynamic>> maps = await db.query("lists");

    return List.generate(maps.length, (index) {
      return Metalist(id: maps[index]["id"], title: maps[index]["title"]);
    });
  }


  static Future<List<ListEntry>> getListEntries(Database db, int listId) async {
    final List<Map<String, dynamic>> maps = await db.query("entries", where: "listid = $listId");

    return List.generate(maps.length, (index) {
      return ListEntry(id: maps[index]["id"], listid: maps[index]["listid"], title: maps[index]["title"], done: maps[index]["done"] == 1);
    });
  }

  static Future<int> addList(Database db, String title) async {
    return await db.insert("lists", {"title": title});
  }

  static Future<int> addListEntry(Database db, int listID, String title) async {
    return await db.insert("entries", {"listid": listID, "title": title, "done": 0});
  }

  static Future<int> updateEntryDone(Database db, int entryID, bool done) async {
    return await db.update("entries", {"done": (done ? 1 : 0)}, where: "id = ?", whereArgs: [entryID]);
  }

  static Future<int> updateEntryTitle(Database db, int entryID, String title) async {
    return await db.update("entries", {"title": title}, where: "id = ?", whereArgs: [entryID]);
  }
}

