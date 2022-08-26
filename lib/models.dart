class ListEntry {
  final int id;
  final int listid;
  final String title;
  final bool done;

  const ListEntry({ required this.id, required this.listid, required this.title, required this.done });
}


class Metalist {
  final int id;
  final String title;

  const Metalist({ required this.id, required this.title });
}
