import 'package:flutter/material.dart';
import "entry.dart";

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

  final TextEditingController _inputController = TextEditingController();

  String _buildTitle = "";

  Future<void> _askForTitle(BuildContext context) async {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: const Text("Neuer Eintrag"),
        content: TextField(
          decoration: const InputDecoration(hintText: "Titel"),
          controller: _inputController,
        ),
        actions: <Widget>[
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Abbrechen")
          ),
          TextButton(
              onPressed: () {
                  _buildTitle = _inputController.text;
                  Navigator.pop(context);
              },
              child: const Text("OK")
          )
        ],
      );
    });
  }

  void _handleAddEntry() async {
    await _askForTitle(context);

    if (_buildTitle.isNotEmpty) {

      Entry newEntry = Entry(title: _buildTitle);
      List<Entry> entriesCopy = [..._entries];
      entriesCopy.add(newEntry);

      setState(() {
        _entries = entriesCopy;
      });
    }

    _inputController.text = "";
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