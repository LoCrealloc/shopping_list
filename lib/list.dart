import 'package:flutter/material.dart';
import "entry.dart";

import "dialog.dart";

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key, required this.title}) : super(key: key);

  final String title;

  static List<Entry> loadEntries() {
    // TODO actually load entries
    return [];
  }

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<Entry> _entries = ShoppingList.loadEntries();

  void sortEntriesByState() {
    List<Entry> entriesCopy = [..._entries];

    entriesCopy.sort((a, b) {
      if (a.done && b.done) {
        return a.title.length > b.title.length ? 1 : -1;
      }
      return a.done ? 1 : -1;
    });
    setState(() {
      _entries = entriesCopy;
    });
  }

  void _handleAddEntry() async {
    String title = await askForTitle(context, "Neuer Eintrag");

    if (title.isNotEmpty) {

      Entry newEntry = Entry(title: title, sortTrigger: sortEntriesByState);
      List<Entry> entriesCopy = [..._entries];
      entriesCopy.add(newEntry);

      _entries = entriesCopy;

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
          children: _entries,
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