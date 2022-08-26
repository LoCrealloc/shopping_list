import 'package:flutter/material.dart';
import 'package:shopping/list.dart';
import 'package:shopping/dialog.dart';
import "package:shopping/db.dart";
import 'package:shopping/models.dart';
import 'package:sqflite/sqflite.dart';

class Overview extends StatefulWidget {
  Overview({Key? key, required this.db}) : super(key: key);

  final Database db;
  List<ListContainer> lists = [];
    
  @override
  State<Overview> createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {

  @override
  void initState() {
    super.initState();

    getLists().then((value) {
      setState(() {
        widget.lists = value;
      });
    });
  }

  @override
  void didUpdateWidget(_) {
    super.didUpdateWidget(_);

    getLists().then((value) {
      setState(() {
        widget.lists = value;
      });
    });
  }

  Future<List<ListContainer>> getLists() async {
    List<Metalist> lists = await DBHandler.getLists(widget.db);

    List<ListContainer> out = [];

    for (int i = 0; i < lists.length; i++) {
      Metalist current = lists[i];
      ListContainer c = ListContainer(
          list: ShoppingList(title: current.title, db: widget.db, listId: current.id)
      );

      out.add(c);
    }

    return out;
  }


  void _createNewList() async {
    String title = await askForTitle(context, "Neue Liste");

    if (title.isNotEmpty) {
      
      int id = await DBHandler.addList(widget.db, title);

      ListContainer newList = ListContainer(list: ShoppingList(title: title, listId: id, db: widget.db));
      List<ListContainer> listsCopy = [...widget.lists];
      listsCopy.add(newList);

      setState(() {
        widget.lists = listsCopy;
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
            children: widget.lists,
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