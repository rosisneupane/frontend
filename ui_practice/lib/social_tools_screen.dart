import 'package:flutter/material.dart';

class SocialToolsScreen extends StatelessWidget {
  const SocialToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social Tools"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          _buildScenarioCard("Responding to a friend in need", Icons.chat_bubble),
          _buildScenarioCard("Starting a conversation", Icons.voice_chat),
          _buildScenarioCard("Joining a group activity", Icons.groups),
        ],
      ),
    );
  }

  Widget _buildScenarioCard(String title, IconData icon) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 36, color: Colors.purple),
        title: Text(title),
        trailing: ElevatedButton(
          onPressed: () {},
          child: Text("Practice"),
        ),
      ),
    );
  }
}
