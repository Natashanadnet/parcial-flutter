import 'package:flutter/material.dart';
import 'package:parcial/models/comment.dart';
import 'package:parcial/models/posts.dart';
import 'package:parcial/services/fetch_comments.dart';

class CommentsScreen extends StatelessWidget {
  final Post post;

  const CommentsScreen({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comentarios del Post ${post.id}'),
      ),
      body: FutureBuilder<List<Comment>>(
        future: fetchComments(post.id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Comment>? comments = snapshot.data;
            return ListView.builder(
              itemCount: comments?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments![index].name),
                  subtitle: Text(comments[index].body),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
