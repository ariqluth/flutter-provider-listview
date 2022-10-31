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

  final dc = DismissDirection.endToStart;

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
                    // confirmDismiss: (dc) {
                    //   return showDialog(
                    //       context: context,
                    //       builder: (context) => AlertDialog(
                    //             title: Text('Konfimasikan Data'),
                    //             content: Text(
                    //                 "apakah kamu pingin menghapus data ini ? "),
                    //             actions: [
                    //               ElevatedButton(
                    //                 onPressed: () {
                    //                   context.read<Tasklist>().deleteTask(task);
                    //                   Navigator.pop(context, true);
                    //                 },
                    //                 child: Text("Konfirmasi"),
                    //               ),
                    //               ElevatedButton(
                    //                 onPressed: () {
                    //                   Navigator.of(context).pop(false);
                    //                 },
                    //                 child: Text("Batalkan"),
                    //               )
                    //             ],
                    //           ));
                    // },
                    background: Container(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.inbox_rounded, color: Colors.white),
                            Text('bergerak Edit data',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.delete, color: Colors.white),
                            Text('bergerak Hapus data',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.startToEnd) {
                        Navigator.pushNamed(context, "/updateTask");
                        if (!mounted) return;
                        context.read<Tasklist>().fetchTaskList();
                        print("edit data");
                      } else {
                        context.read<Tasklist>().deleteTask(task);
                      }
                    },
                    child: ListTile(
                      title:
                          Text(context.watch<Tasklist>().taskList[index].name),
                    ),
                    // background: buildSwipeActionLeft(),
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
