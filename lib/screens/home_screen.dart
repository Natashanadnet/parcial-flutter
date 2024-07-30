import 'package:flutter/material.dart';
import 'package:parcial/models/posts.dart';
import 'package:parcial/screens/profile_screen.dart';
import 'package:parcial/screens/todos_screen.dart';
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
    TodosScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String appBarTitle;
    IconData appBarIcon;
    VoidCallback appBarAction;

    if (_selectedIndex == 1) {
      appBarTitle = 'Todos';
      appBarIcon = Icons.arrow_back;
      appBarAction = () {
        setState(() {
          _selectedIndex = 0;
        });
      };
    } else if (_selectedIndex == 2) {
      appBarTitle = 'Perfil';
      appBarIcon = Icons.arrow_back;
      appBarAction = () {
        setState(() {
          _selectedIndex = 0;
        });
      };
    } else {
      appBarTitle = 'Posts';
      appBarIcon = Icons.logout;
      appBarAction = () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      };
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(appBarIcon),
          onPressed: appBarAction,
        ),
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
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
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
                      startActionPane: ActionPane(
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
                      endActionPane: const ActionPane(
                        motion: ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            onPressed: doNothing,
                            backgroundColor: Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.share,
                            label: 'Share',
                          ),
                        ],
                      ),
                      child: Card(
                        margin: const EdgeInsets.all(10),
                        color: Color.fromARGB(255, 206, 235, 209),
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
