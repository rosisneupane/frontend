import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/config/config.dart';

class ConversationApiService {
  static Future<bool> createConversation(
      String name, String details, List<String> userIds) async {
    // Retrieve the JWT token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('JWT Token not found');
    }

    String url = AppConfig.apiUrl;

    final response = await http.post(
      Uri.parse('$url/conversations/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"name": name, "details": details, "user_ids": userIds}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to check mood status');
    }
  }
}
