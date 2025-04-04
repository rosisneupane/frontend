import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/api/conversation.dart';
import 'package:ui_practice/config/config.dart';
import 'package:ui_practice/social_tools_screen.dart';

class StartConversationScreen extends StatefulWidget {
  const StartConversationScreen({super.key});

  @override
  State<StartConversationScreen> createState() =>
      _StartConversationScreenState();
}

class _StartConversationScreenState extends State<StartConversationScreen> {
  final TextEditingController _conversationNameController =
      TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  List<Map<String, String>> _users = [];
  final List<Map<String, String>> _selectedUsers = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    String url = AppConfig.apiUrl;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('JWT Token not found');
    }

    try {
      final response = await http.get(
        Uri.parse('$url/user'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);
        setState(() {
          _users = data
              .map((user) => {
                    'id': user['id'].toString(),
                    'username': user['username'].toString(),
                    'email': user['email'].toString(),
                  })
              .toList();
        });
      } else {
        throw Exception("Failed to load users");
      }
    } catch (e) {
      print("Error fetching users: $e");
    }
  }

  void _addUser(String userId) {
    final user = _users.firstWhere((u) => u['id'] == userId);
    if (!_selectedUsers.any((u) => u['id'] == userId)) {
      setState(() {
        _selectedUsers.add(user);
      });
    }
  }

  void _removeUser(String userId) {
    setState(() {
      _selectedUsers.removeWhere((u) => u['id'] == userId);
    });
  }

  void onCreateConversation() async {
    final name = _conversationNameController.text.trim();
    final details = _descriptionController.text.trim();
    final userIds = _selectedUsers.map((u) => u['id']!).toList();

    if (name.isEmpty || details.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill out name and description.")),
      );
      return;
    }

    try {
      bool isSuccess = await ConversationApiService.createConversation(
          name, details, userIds);
      if (isSuccess) {
        // Show success message or navigate to the previous page
        //Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SocialToolsScreen()),
        );
      }
    } catch (e) {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Start a Conversation"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const Text("Conversation Name", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _conversationNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter conversation name",
              ),
            ),
            const SizedBox(height: 16),
            const Text("Description", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Enter description",
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            const Text("Add Participants", style: TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              hint: const Text("Select a user"),
              items: _users.map((user) {
                return DropdownMenuItem<String>(
                  value: user['id'],
                  child: Text("${user['username']} (${user['email']})"),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  _addUser(value);
                }
              },
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _selectedUsers.map((user) {
                return InputChip(
                  label: Text(user['username']!),
                  onDeleted: () => _removeUser(user['id']!),
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Center(
              child: ElevatedButton(
                onPressed: onCreateConversation,
                child: const Text("Start Conversation"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
