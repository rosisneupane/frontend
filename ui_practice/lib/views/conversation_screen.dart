import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/config/config.dart';
import 'package:ui_practice/modals/message.dart';

class ConversationScreen extends StatefulWidget {
  final String conversationId;

  const ConversationScreen({
    super.key,
    required this.conversationId,
  });

  @override
  State<ConversationScreen> createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
    fetchMessages();
  }

  Future<void> fetchMessages() async {
    String url = AppConfig.apiUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('JWT Token not found');
    }
    final response = await http.get(
      Uri.parse('$url/messages/conversation/${widget.conversationId}'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      setState(() {
        messages = data.map((json) => Message.fromJson(json)).toList();
      });
    } else {
      // handle error
    }
  }

  Future<void> sendMessage(String content) async {
    String url = AppConfig.apiUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('JWT Token not found');
    }
    final response = await http.post(
      Uri.parse('$url/messages/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'conversation_id': widget.conversationId,
        'content': content,
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final message = Message.fromJson(json.decode(response.body));
      setState(() {
        messages.add(message);
        _controller.clear();
      });
    } else {
      // handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Conversation')),
      body: Column(
        children: [
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification &&
                    scrollNotification.metrics.pixels <=
                        scrollNotification.metrics.minScrollExtent + 50 &&
                    scrollNotification.scrollDelta! < 0) {
                  // User is pulling upward near the top
                  fetchMessages(); // or implement pagination/load more earlier messages
                }
                return false;
              },
              child: ListView.builder(
                reverse:
                    false, // set to true if your messages are ordered from bottom to top
                padding: const EdgeInsets.all(8),
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final msg = messages[index];
                  return ListTile(
                    title: Text(msg.sender.username),
                    subtitle: Text(msg.content),
                    trailing: Text(
                      '${msg.timestamp.hour}:${msg.timestamp.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(fontSize: 12),
                    ),
                  );
                },
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      sendMessage(text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
