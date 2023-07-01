import 'package:firebase_database/firebase_database.dart';

List<ToDoItem> toDoList = [];
int currentId = 0;
bool showTextField = false;
bool loggedin = false;
bool inspecting = false;
int currentPage = 0;
late String uid;

ToDoItem currentItem = ToDoItem(0,"","","");
class ToDoItem {
  late int id;
  late String title;
  late String due;
  late String description;
  ToDoItem(this.id, this.title, this.description, this.due);
}
