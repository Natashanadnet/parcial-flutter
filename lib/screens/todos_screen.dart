import 'package:flutter/material.dart';
import 'package:parcial/models/todo.dart';
import 'package:parcial/services/fetch_todos.dart';

class TodosScreen extends StatefulWidget {
  @override
  _TodosScreenState createState() => _TodosScreenState();
}

class _TodosScreenState extends State<TodosScreen> {
  late Future<List<Todo>> futureTodos;

  @override
  void initState() {
    super.initState();
    futureTodos = fetchTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Todo>>(
        future: futureTodos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Todo>? todos = snapshot.data;
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: todos?.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        child: ListTile(
                          title: Text(todos![index].title),
                          trailing: todos[index].completed
                              ? const Icon(Icons.check, color: Colors.green)
                              : const Icon(Icons.close, color: Colors.red),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
