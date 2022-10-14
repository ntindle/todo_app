import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:motor_flutter/motor_flutter.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key, required this.title});

  final String title;

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  GetStorage box = GetStorage();
  TextEditingController todoItemController = TextEditingController();

  void _addItem() async {
    final String task = todoItemController.text;
    final doc = Get.find<Schema>(tag: 'taskSchema').newDocument();
    doc.set<String>('task', task);
    SchemaDocument? resp = await doc.upload(task);
    if (resp != null) {
      Get.snackbar('Success', 'Item added');
      print(resp.schemaDid);
      todoItemController.clear();
    } else {
      Get.snackbar('Error', 'Item not added');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add Item"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    padding: const EdgeInsets.all(25),
                    child: const Text("Add a todo item",
                        style: TextStyle(fontSize: 20))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: todoItemController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Your Todo Item',
                    hintText: 'Enter your todo item'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              margin: const EdgeInsets.only(top: 20),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: ElevatedButton(
                onPressed: () => _addItem(),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void debugPrint(Object? message) {
  if (kDebugMode) {
    print(message);
  }
}
