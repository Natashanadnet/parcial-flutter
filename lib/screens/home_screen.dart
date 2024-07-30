import 'package:flutter/material.dart';
import 'package:parcial/models/posts.dart';
import 'comments_screen.dart';
import 'post_detail_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Post>> futurePosts;

  @override
  void initState() {
    super.initState();
    futurePosts = fetchPosts();
  }

  Future<List<Post>> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    PostsScreen(),
    const Center(child: Text('TODO', style: TextStyle(fontSize: 24))),
    const Center(child: Text('PROFILE', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Posts', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Todos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class PostsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Post>>(
      future: fetchPosts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Post>? posts = snapshot.data;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: posts?.length,
                  itemBuilder: (context, index) {
                    return Slidable(
                      key: ValueKey(posts![index].id),
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            flex: 2,
                            onPressed: (context) {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    CommentsScreen(post: posts[index]),
                              ));
                            },
                            backgroundColor: const Color(0xFF7BC043),
                            foregroundColor: Colors.white,
                            icon: Icons.comment,
                            label: 'Comentarios',
                          ),
                          const SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF0392CF),
                            foregroundColor: Colors.white,
                            icon: Icons.save,
                          ),
                        ],
                      ),
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        color: Colors.purple[50],
                        child: ListTile(
                          title:
                              Text('${posts[index].id}-${posts[index].title}'),
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  PostDetailScreen(post: posts[index]),
                            ));
                          },
                        ),
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
    );
  }

  Future<List<Post>> fetchPosts() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => Post.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static void doNothing(BuildContext context) {}
}
