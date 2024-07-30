import 'package:flutter/material.dart';
import 'package:parcial/services/fetch_profile.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchRandomUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> user = snapshot.data!;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Nombre: ${user['name']}'),
                Text('Usuario: ${user['username']}'),
                Text('Email: ${user['email']}'),
                Text('Teléfono: ${user['phone']}'),
                Text('Website: ${user['website']}'),
                const SizedBox(height: 20),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
