import 'dart:convert';
import '../models/posts.dart';
import 'package:http/http.dart' as http;

Future<List<Post>> fetchPosts() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((post) => Post.fromJson(post)).toList();
  } else {
    throw Exception('Error al cargar los posts');
  }
}
