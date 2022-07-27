import 'package:flutter/material.dart';

import 'package:shopping/list.dart';

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

  final List<ListContainer> _lists = getLists();

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
          width: 125,
          height: 125,
          child: FloatingActionButton(
            onPressed: (){},
            backgroundColor: Colors.blue,
            child: const Icon(Icons.add, size: 75,),
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