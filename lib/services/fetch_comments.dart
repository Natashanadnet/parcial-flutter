import 'package:parcial/models/comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Comment>> fetchComments(int postId) async {
  final response = await http.get(Uri.parse(
      'https://jsonplaceholder.typicode.com/comments?postId=$postId'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((comment) => Comment.fromJson(comment)).toList();
  } else {
    throw Exception('Failed to load comments');
  }
}
