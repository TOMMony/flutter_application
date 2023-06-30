List<ToDoItem> toDoList = [];
int currentId = 0;
bool showTextField = false;
bool loggedin = false;
class ToDoItem {
  late int id;
  late String title;
  late String due;
  late String description;

  ToDoItem(this.id, this.title, this.description, this.due);
}