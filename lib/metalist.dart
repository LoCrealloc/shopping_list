import 'package:flutter/material.dart';

import 'package:shopping/list.dart';

import 'package:shopping/dialog.dart';

class Overview extends StatefulWidget {
  const Overview({Key? key}) : super(key: key);


  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {

  static List<ListContainer> getLists() {
    // TODO actually load lists
    return [const ListContainer(list: ShoppingList(title: "Title"))];
  }

  void _createNewList() async {
    String title = await askForTitle(context, "Neue Liste");

    if (title.isNotEmpty) {

      ListContainer newList = ListContainer(list: ShoppingList(title: title));
      List<ListContainer> listsCopy = [..._lists];
      listsCopy.add(newList);

      setState(() {
        _lists = listsCopy;
      });
    }
  }

  List<ListContainer> _lists = getLists();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Einkaufsliste")
        ),
        body: Center(
          child: ListView(
            children: _lists,
          ),
        ),
        floatingActionButton: SizedBox(
          width: 60,
          height: 60,
          child: FloatingActionButton(
            onPressed: _createNewList,
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, size: 30,),
          ),
        )
    );
  }
}

class ListContainer extends StatelessWidget{
  const ListContainer({Key? key, required this.list}) : super(key: key);

  final ShoppingList list;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => list),
        );
      },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration:  const BoxDecoration(
            border: Border(
                bottom: BorderSide(
                  color: Colors.black45,
                  width: 2,
                )
            ),
            color: Colors.white,
          ),
          child: Row(
              children: <Widget>[
                Expanded(
                    child: Text(list.title, style: const TextStyle(fontSize: 22))
                ),
              ]
          )
        )
    );
  }

}