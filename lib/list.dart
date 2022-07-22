import 'package:flutter/material.dart';
import "entry.dart";

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  static List<Entry> loadEntries() {
    // TODO actually load entries
    return List<Entry>.generate(20, (int index) => Entry(title: index.toString(), done: index % 3 == 0));
  }

  @override
  State<ShoppingList> createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  List<Entry> _entries = ShoppingList.loadEntries();

  String _buildTitle = "";
  bool _buildSuccess = false;

  Future<void> _askForTitle(BuildContext context) async {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Eingabe"),
        content: TextField(
          onChanged: (value) {
            setState(() {
              _buildTitle = value;
            });
          },
          decoration: const InputDecoration(hintText: "Titel"),


        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                _buildSuccess = false;
                Navigator.pop(context);
              },
              child: const Text("Abbrechen")
          ),
          TextButton(
              onPressed: () {
                setState(() {
                  _buildSuccess = true;
                  Navigator.pop(context);
                });
              },
              child: const Text("OK")
          )
        ],
      );
    });
  }

  void _handleAddEntry() async {

    await _askForTitle(context);

    if (_buildSuccess && _buildTitle.isNotEmpty) {

      Entry newEntry = Entry(title: _buildTitle);
      List<Entry> entriesCopy = [..._entries];
      entriesCopy.add(newEntry);

      setState(() {
        _entries = entriesCopy;
      });
    }

    _buildSuccess = false;
    _buildTitle = "";
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
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddEntry,
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add),
      ),
    );
  }
}