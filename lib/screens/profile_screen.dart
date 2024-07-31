import 'package:flutter/material.dart';
import 'package:parcial/services/fetch_profile.dart';
import 'package:parcial/models/profile_field.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fetchRandomUser(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Map<String, dynamic> user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                ProfileField(
                  label: 'Nombre',
                  value: user['name'],
                ),
                const SizedBox(height: 10),
                ProfileField(
                  label: 'Username',
                  value: user['username'],
                ),
                const SizedBox(height: 10),
                ProfileField(
                  label: 'Email',
                  value: user['email'],
                ),
                const SizedBox(height: 10),
                ProfileField(
                  label: 'Teléfono',
                  value: user['phone'],
                ),
                const SizedBox(height: 10),
                ProfileField(
                  label: 'Website',
                  value: user['website'],
                ),
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
