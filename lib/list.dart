import 'package:flutter/material.dart';
import "entry.dart";

import "dialog.dart";

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  static List<Entry> loadEntries() {
    // TODO actually load entries
    return [];
  }

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<Entry> _entries = ShoppingList.loadEntries();

  void _handleAddEntry() async {
    String title = await askForTitle(context, "Neuer Eintrag");

    if (title.isNotEmpty) {

      Entry newEntry = Entry(title: title);
      List<Entry> entriesCopy = [..._entries];
      entriesCopy.add(newEntry);

      setState(() {
        _entries = entriesCopy;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Einkaufsliste")
      ),
      body: Center(
        child: ListView(
          children: _entries,
        ),
      ),
      floatingActionButton: SizedBox(
        width: 125,
        height: 125,
        child: FloatingActionButton(
          onPressed: _handleAddEntry,
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add, size: 75,),
      ),
      )
    );
  }
}