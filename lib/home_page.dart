// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import "package:firebase_database/firebase_database.dart";
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
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  List<Widget> _createChildren() {
    return List<Widget>.generate(toDoList.length, (int index) {
      return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        FloatingActionButton(
          child: Text(toDoList[index].id.toString()),
          onPressed: () {
            currentItem = toDoList[index];
            setState(() {
              inspecting = true;
            });
          },
        ),
        Text(toDoList[index].title.toString()),
        Text(
            "${toDoList[index].description.substring(0, min(toDoList[index].description.length, 20))}..."),
        FloatingActionButton(
            child: const Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                database.child("${uid}/${toDoList[index].id}").remove();
                toDoList.remove(toDoList[index]);
              });
            })
      ]);
    });
  }

  void checkMostRecent() {
    setState(() {
      currentItem = toDoList[0];
      inspecting = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (inspecting) {
      return const InfoPage();
    }
    return !showTextField
        ? Scaffold(
            body: SingleChildScrollView(
                child: Column(children: _createChildren())),
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    showTextField = true;
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
  final DatabaseReference database = FirebaseDatabase.instance.ref();

  writeData(a, b, c) async {
    print("Writing");
    try {
      await a.set({"title": b, "description": c});
    } catch (e) {
      print("Error: $e");
    } finally {
      print("Done writing!");
    }
  }

  @override
  Widget build(BuildContext context) {
    final toDoListRef = database.child(uid);
    return showTextField
        ? (Column(children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [const Text("ID"), Text(currentId.toString())]),
            Form(
                child: Column(children: [
              TextFormField(controller: titleController),
              TextFormField(controller: descController),
              TextFormField(controller: dueController),
              ElevatedButton(
                onPressed: () {
                  toDoList.add(ToDoItem(currentId++, titleController.text,
                      descController.text, dueController.text));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Great"),
                  ));
                  setState(() {
                    showTextField = false;
                  });
                  writeData(
                      toDoListRef.child((currentId - 1).toString()),
                      titleController.text,
                      descController.text);
                },
                child: const Text("Submit"),
              )
            ])),
            FloatingActionButton(
              child: const Icon(Icons.arrow_back),
              onPressed: () {
                setState(() {
                  showTextField = false;
                });
              },
            )
          ]))
        : const TodoBody();
  }
}

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return inspecting
        ? Container(
            height: double.infinity,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text("ID: ${currentItem.id}"),
                  Text("To-Do: ${currentItem.title}"),
                  Text("Description: ${currentItem.description}"),
                  FloatingActionButton(
                    child: const Icon(Icons.arrow_back),
                    onPressed: () {
                      setState(() {
                        inspecting = false;
                        currentPage = 0;
                      });
                    },
                  )
                ]))
        : const TodoBody();
  }
}
