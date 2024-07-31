import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

Future<Map<String, dynamic>> fetchRandomUser() async {
  final random = Random();
  final userId = random.nextInt(10) + 1;
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users?id=$userId'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse[0];
  } else {
    throw Exception('Failed to load user');
  }
}
