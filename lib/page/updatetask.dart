import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_listview/service/tasklist.dart';

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: "Masukkan Task Baru",
              ),
              validator: (value) {
                if (value != null && value.length > 5) {
                  return 'Masukan min 5 character';
                } else {
                  return null;
                }
              },
              onChanged: (value) {
                context.read<Tasklist>().changeTaskName(value);
              },
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<Tasklist>().addTask();
                      Navigator.pop(context, true);
                    },
                    child: const Text("Update Task"),
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
