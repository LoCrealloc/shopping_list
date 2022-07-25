import 'package:flutter/material.dart';
import "entry.dart";

class ShoppingList extends StatelessWidget {
  ShoppingList({Key? key}) : super(key: key);

  static List<Entry> loadEntries() {
    // TODO actually load entries
    return [];
  }

  final List<Entry> entries = loadEntries();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: entries,
    );
  }
}