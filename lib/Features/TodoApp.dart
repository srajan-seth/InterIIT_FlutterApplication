import 'package:flutter/material.dart';

void main() {
  runApp(TodoApp());
}

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do List App',
      theme: ThemeData(primarySwatch: Colors.orange),
      home: TodoListScreen(),
    );
  }
}

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<TodoTask> _todos = [];

  void _addTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTodo = '';
        DateTime? dueDate;

        return AlertDialog(
          title: Text('Add a new task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  newTodo = value;
                },
                decoration: InputDecoration(labelText: 'Task'),
              ),
              SizedBox(height: 10),
              TextField(
                onTap: () async {
                  dueDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                },
                readOnly: true,
                decoration: InputDecoration(labelText: 'Due Date'),
                controller: TextEditingController(
                  text: dueDate != null ? "${dueDate!.toLocal()}".split(' ')[0] : '',
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  if (newTodo.isNotEmpty && dueDate != null) {
                    _todos.add(TodoTask(
                      task: newTodo,
                      dueDate: dueDate,
                      isDone: false,
                    ));
                  }
                  Navigator.of(context).pop();
                });
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _toggleTodoStatus(int index) {
    setState(() {
      _todos[index].isDone = !_todos[index].isDone;
    });
  }

  void _removeTodo(int index) {
    setState(() {
      _todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (BuildContext context, int index) {
          final todo = _todos[index];
          final currentDate = DateTime.now();
          final isOverdue = todo.dueDate != null && todo.dueDate!.isBefore(currentDate);

          return ListTile(
            leading: Checkbox(
              value: todo.isDone,
              onChanged: (bool? value) {
                if (value != null) {
                  _toggleTodoStatus(index);
                }
              },
            ),
            title: Text(
              todo.task,
              style: TextStyle(
                decoration: todo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
                color: isOverdue ? Colors.red : Colors.black,
              ),
            ),
            subtitle: todo.dueDate != null
                ? Text(
              'Due Date: ${todo.dueDate!.toLocal()}'.split(' ')[0],
              style: TextStyle(
                color: isOverdue ? Colors.red : Colors.grey,
              ),
            )
                : null,
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                _removeTodo(index);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodo,
        child: Icon(Icons.add),
      ),
    );
  }
}

class TodoTask {
  String task;
  DateTime? dueDate;
  bool isDone;

  TodoTask({required this.task, this.dueDate, required this.isDone});
}
