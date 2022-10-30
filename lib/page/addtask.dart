import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_listview/service/tasklist.dart';

final _formKey = GlobalKey<FormState>();

class AddTaskPage extends StatelessWidget {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Task Baru"),
      ),
      body: CustomField(),
    );
  }
}

class CustomField extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

class MyCustomFormState extends State<CustomField> {
  // void _submit() {
  //   final isValid = _formKey.currentState!.validate();
  //   if (!isValid) {
  //     return;
  //   }
  //   _formKey.currentState?.save();
  // }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        key: _formKey,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              hintText: "Masukkan Task Baru",
            ),
            validator: (value) {
              if (value == null || value.length < 5) {
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
                    if (_formKey.currentState!.validate()) {
                      Navigator.pop(context, true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text("Tambah Task Baru"),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
