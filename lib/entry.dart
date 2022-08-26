import 'package:flutter/material.dart';
import "dialog.dart";

import "package:sqflite/sqflite.dart";
import "package:shopping/db.dart";

class Entry extends StatefulWidget {
  Entry(
    {
      Key? key,
      required this.title,
      required this.sortTrigger,
      required this.id,
      required this.db,
      this.done = false,
    }) : super(key: key);

  String title;
  bool done;
  int id;
  Database db;

  VoidCallback sortTrigger;

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {

  void _handleEdit() async {
    String newTitle = await askForTitle(context, "Neuer Titel");

    if (newTitle.isNotEmpty) {
      await DBHandler.updateEntryTitle(widget.db, widget.id, newTitle);

      setState(() {
        widget.title = newTitle;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration:  BoxDecoration(
        border: const Border(
          bottom: BorderSide(
            color: Colors.black45,
            width: 2,
          )
        ),
        color: !widget.done ? Colors.white : Colors.grey,
      ),
      child: Row(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: !widget.done ? Colors.blue : Colors.transparent,
              borderRadius: BorderRadius.circular(360),
            ),
            margin: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(!widget.done ? Icons.shopping_cart_outlined : Icons.remove_shopping_cart_outlined),
                color: Colors.white,
                onPressed: () async {
                  setState(() {
                    widget.done = !widget.done;
                  });
                  await DBHandler.updateEntryDone(widget.db, widget.id, widget.done);
                  widget.sortTrigger();
                  },
              )
            ),
          Expanded(
              child: Text(widget.title, style: const TextStyle(fontSize: 22))
          ),
          !widget.done ? IconButton(
              onPressed: _handleEdit,
              icon: const Icon(Icons.edit)
          ) : const SizedBox.shrink()
        ]
    )
    );
  }
}