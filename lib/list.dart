import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import "entry.dart";
import "package:shopping/db.dart";

import "dialog.dart";

class ShoppingList extends StatefulWidget {
  ShoppingList(
      {Key? key, required this.title, required this.db, required this.listId}
      ) : super(key: key);

  final String title;
  final int listId;
  final Database db;

  late List<Entry> entries = [];

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  @override
  void initState() {
    super.initState();

    DBHandler.getListEntries(widget.db, widget.listId).then((res) {
          setState(() {
            widget.entries = res.map((e) =>
                Entry(
                    title: e.title,
                    sortTrigger: sortEntriesByState,
                    db: widget.db,
                    id: e.id,
                    done: e.done
                )
            ).toList();
          });
          sortEntriesByState();
        }
    );

  }

  void sortEntriesByState() {
    List<Entry> entriesCopy = [...widget.entries];

    entriesCopy.sort((a, b) {
      if (a.done && b.done) {
        return a.title.length > b.title.length ? 1 : -1;
      }
      return a.done ? 1 : -1;
    });
    setState(() {
      widget.entries = entriesCopy;
    });
  }

  void _handleAddEntry() async {
    String title = await askForTitle(context, "Neuer Eintrag");

    if (title.isNotEmpty) {
      int id = await DBHandler.addListEntry(widget.db, widget.listId, title);

      Entry newEntry = Entry(title: title, sortTrigger: sortEntriesByState, db: widget.db, id: id);
      List<Entry> entriesCopy = [...widget.entries];
      entriesCopy.add(newEntry);

      widget.entries = entriesCopy;

      sortEntriesByState();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title)
      ),
      body: Center(
        child: ListView(
          children: widget.entries,
        ),
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          onPressed: _handleAddEntry,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add, size: 30,),
      ),
      )
    );
  }
}