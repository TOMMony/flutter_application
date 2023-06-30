import 'package:flutter/material.dart';
import "globals.dart";
import "dart:math";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return showTextField ? const InputEntry() : const TodoBody();
  }
}

class TodoBody extends StatefulWidget {
  const TodoBody({super.key});

  @override
  State<TodoBody> createState() => _TodoBodyState();
}

class _TodoBodyState extends State<TodoBody> {
  List<Widget> _createChildren() {
    return List<Widget>.generate(toDoList.length, (int index) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(toDoList[index].id.toString()),
        Text(toDoList[index].title.toString()),
        Text(
            "${toDoList[index].description.substring(0, min(toDoList[index].description.length, 20))}..."),
        FloatingActionButton(
            child: const Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                toDoList.remove(toDoList[index]);
              });
            })
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return !showTextField
        ? Scaffold(
            body: Column(children: _createChildren()),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    showTextField = true;
                    print(showTextField);
                    //toDoList.add(ToDoItem(currentId++, "title", "desc", "bruh"));
                  });
                },
                child: const Icon(Icons.add)),
          )
        : const InputEntry();
  }
}

class InputEntry extends StatefulWidget {
  const InputEntry({super.key});

  @override
  State<InputEntry> createState() => _InputEntryState();
}

class _InputEntryState extends State<InputEntry> {
  final titleController = TextEditingController(text: "TODO Title");
  final descController = TextEditingController(text: "TODO Description");
  final dueController = TextEditingController(text: "TODO Due Date");
  @override
  Widget build(BuildContext context) {
    return showTextField ? Column(children: [
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text("ID"), Text(currentId.toString())]),
      Form(
          child: Column(children: [
        TextFormField(controller:titleController),
        TextFormField(controller:descController),
        TextFormField(controller:dueController),
        ElevatedButton(
            onPressed: () {
              toDoList.add(ToDoItem(currentId++, titleController.text, descController.text, dueController.text));
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Great"),
              ));
              setState(() {
                showTextField = false;
              });
            }, child: const Text("Submit"),)
      ])),
    ]) : const TodoBody();
  }
}
