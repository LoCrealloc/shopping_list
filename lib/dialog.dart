import 'package:flutter/material.dart';

Future<String> askForTitle(BuildContext context, String dialogTitle) async {
  final TextEditingController inputController = TextEditingController();

  String title = "";

  await showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text(dialogTitle),
      content: TextField(
        decoration: const InputDecoration(hintText: "Titel"),
        controller: inputController,
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
              title = inputController.text;
              Navigator.pop(context);
            },
            child: const Text("OK")
        )
      ],
    );
  });

  return title;
}