import 'package:flutter/material.dart';
import 'package:ui_practice/views/all_conversation_list.dart';
import 'package:ui_practice/views/conversation_list.dart';
import 'package:ui_practice/views/start_conversation.dart';

class SocialToolsScreen extends StatelessWidget {
  const SocialToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social Tools"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SocialToolsList(),
      ),
    );
  }
}

class SocialToolsList extends StatelessWidget {
  const SocialToolsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ScenarioCard(
          title: "Responding to a friend in need",
          icon: Icons.chat_bubble,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ConversationListScreen(),
              ),
            );
          }, // Placeholder
        ),
        ScenarioCard(
          title: "Starting a conversation",
          icon: Icons.voice_chat,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const StartConversationScreen(),
              ),
            );
          },
        ),
        ScenarioCard(
          title: "Joining a group activity",
          icon: Icons.groups,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const AllConversationListScreen(),
              ),
            );
          }, // Placeholder
        ),
      ],
    );
  }
}

class ScenarioCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const ScenarioCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 36, color: Colors.purple),
        title: Text(title),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: onTap,
      ),
    );
  }
}
