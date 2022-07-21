import 'package:flutter/material.dart';

class Entry extends StatefulWidget {
  const Entry({ Key? key, required this.title , this.done = false}) : super(key: key);

  final String title;
  final bool done;

  @override
  State<Entry> createState() => _EntryState();
}

class _EntryState extends State<Entry> {
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
      child: Text(widget.title, style: const TextStyle(fontSize: 22),),
    );
  }
}