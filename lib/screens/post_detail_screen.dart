import 'package:flutter/material.dart';
import 'package:parcial/models/posts.dart';

class PostDetailScreen extends StatelessWidget {
  final Post post;

  const PostDetailScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del post:'),
      ),
      body: Center(
        child: Text('Post ID: ${post.id}'),
      ),
    );
  }
}
