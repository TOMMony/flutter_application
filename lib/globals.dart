List<ToDoItem> toDoList = [];
var currentId = 0;

class ToDoItem {
  late int id;
  late String title;
  late String due;
  late String description;

  ToDoItem(this.id, this.title, this.description, this.due);
}