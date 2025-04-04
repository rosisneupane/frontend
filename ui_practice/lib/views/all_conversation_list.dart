import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/config/config.dart';
import 'package:ui_practice/views/conversation_screen.dart';

class AllConversationListScreen extends StatefulWidget {
  const AllConversationListScreen({super.key});

  @override
  State<AllConversationListScreen> createState() => _AllConversationListScreenState();
}

class _AllConversationListScreenState extends State<AllConversationListScreen> {
  List<Map<String, String>> _conversations = [];

  @override
  void initState() {
    super.initState();
    _fetchConversations();
  }

  Future<void> _fetchConversations() async {
    String url = AppConfig.apiUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('JWT Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('$url/conversations/unjoined'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _conversations = data
              .map((conv) => {
                    'id': conv['id'].toString(),
                    'name': conv['name'].toString(),
                    'details': conv['details'].toString(),
                  })
              .toList();
        });
      } else {
        throw Exception("Failed to load conversations");
      }
    } catch (e) {
      print("Error fetching conversations: $e");
    }
  }

    Future<void> _joinConversations(String conversationId) async {
    String url = AppConfig.apiUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('JWT Token not found');
    }

    try {
      final response = await http.post(
        Uri.parse('$url/conversations/join'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "conversation_id":conversationId
        })
      );
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ConversationScreen(conversationId: conversationId,)),
        );
      } else {
        throw Exception("Failed to join conversations");
      }
    } catch (e) {
      print("Error fetching conversations: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Conversations"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: _conversations.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: _conversations.length,
                itemBuilder: (context, index) {
                  final conversation = _conversations[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(
                        conversation['name']!,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(conversation['details']!),
                      onTap: () {
                        _joinConversations(conversation["id"]!);
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
