import 'package:flutter/material.dart';
import "globals.dart";
import "dart:math";

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TodoBody();
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
        Text("${toDoList[index].description.substring(0,min(toDoList[index].description.length, 20))}..."),
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
    return Scaffold(
      body: Column(children: _createChildren()),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              toDoList.add(ToDoItem(currentId++, "title", "desc", "bruh"));
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}

class InputEntry extends StatefulWidget {
  const InputEntry({super.key});

  @override
  State<InputEntry> createState() => _InputEntryState();
}

class _InputEntryState extends State<InputEntry> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
