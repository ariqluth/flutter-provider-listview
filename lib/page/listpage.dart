import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../service/tasklist.dart';

class MyListPage extends StatefulWidget {
  const MyListPage({super.key});

  @override
  State<MyListPage> createState() => _MyListPageState();
}

class _MyListPageState extends State<MyListPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<Tasklist>().fetchTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic Listview dengan provider"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: context.watch<Tasklist>().taskList.length,
                itemBuilder: (context, index) {
                  var task = context.watch<Tasklist>().taskList[index];
                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (direction) {
                      return showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: Text('Konfimasikan Data'),
                                content: Text(
                                    "apakah kamu pingin menghapus data ini ? "),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      context.read<Tasklist>().deleteTask();
                                      Navigator.pop(context, true);
                                    },
                                    child: Text("Konfirmasi"),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop(false);
                                    },
                                    child: Text("Batalkan"),
                                  )
                                ],
                              ));
                    },
                    onDismissed: (direction) {
                      // print(direction);
                      context.read<Tasklist>().deleteTask();
                    },
                    child: ListTile(
                      title:
                          Text(context.watch<Tasklist>().taskList[index].name),
                    ),
                    // background: buildSwipeActionLeft(),
                    background: buildSwipeActionRight(),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      // context.read<Tasklist>().addTask();
                      await Navigator.pushNamed(context, "/addTask");
                      if (!mounted) return;
                      context.read<Tasklist>().fetchTaskList();
                    },
                    child: const Text("Halaman Tambah"),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget buildSwipeActionLeft() => Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.yellow[700],
      child: Icon(
        Icons.archive_sharp,
        color: Colors.white,
      ),
    );

Widget buildSwipeActionRight() => Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.symmetric(horizontal: 5),
      color: Colors.red[700],
      child: Icon(
        Icons.delete_forever,
        color: Colors.white,
      ),
    );
