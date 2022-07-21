import 'package:flutter/material.dart';
import "entry.dart";

class ShoppingList extends StatelessWidget {
  ShoppingList({Key? key}) : super(key: key);

  static List<Entry> loadEntries() {
    // TODO actually load entries
    return List<Entry>.generate(20, (int index) => Entry(title: index.toString(), done: index % 3 == 0));
  }

  final List<Entry> entries = loadEntries();



  @override
  Widget build(BuildContext context) {
    return ListView(
      children: entries,
    );
  }
}