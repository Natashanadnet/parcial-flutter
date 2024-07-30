import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:parcial/models/todo.dart';

Future<List<Todo>> fetchTodos() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((todo) => Todo.fromJson(todo)).toList();
  } else {
    throw Exception('Failed to load todos');
  }
}
