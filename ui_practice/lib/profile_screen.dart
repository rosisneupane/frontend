import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/avatar.png'),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: Text("Rosis", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            SizedBox(height: 32),
            Text("Achievements", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            ListTile(
              leading: Icon(Icons.star, color: Colors.orange),
              title: Text("Completed 5 Tasks"),
            ),
            ListTile(
              leading: Icon(Icons.star, color: Colors.orange),
              title: Text("Level 3 Achieved"),
            ),
          ],
        ),
      ),
    );
  }
}
