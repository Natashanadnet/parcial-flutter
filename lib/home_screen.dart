import 'package:flutter/material.dart';
import 'login_screen.dart'; // Asegurarse de importar el archivo de la pantalla de login
import 'posts.dart';
import 'fetch_posts.dart';

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

  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    PostsScreen(),
    const Center(child: Text('TODO', style: const TextStyle(fontSize: 24))),
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
        title: const Text('Posts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
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
          return ListView.builder(
            itemCount: posts?.length,
            itemBuilder: (context, index) {
              return Card(
                margin: const EdgeInsets.all(10),
                color: Colors.purple[50],
                child: ListTile(
                  title: Text('${posts![index].id}-${posts[index].title}'),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          PostDetailScreen(post: posts[index]),
                    ));
                  },
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

class PostDetailScreen extends StatelessWidget {
  final Post post;

  PostDetailScreen({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del Post'),
      ),
      body: Center(
        child: Text('ID: ${post.id}', style: const TextStyle(fontSize: 24)),
      ),
    );
  }
}
