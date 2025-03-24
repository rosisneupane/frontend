import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/config/config.dart';
import 'package:ui_practice/modals/mood.dart';

class MoodApiService {
  static Future<bool> checkTodayMood() async {
    // Retrieve the JWT token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('JWT Token not found');
    }

    String url = AppConfig.apiUrl;

    final response = await http.get(
      Uri.parse('$url/mood/today/exist'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // API returns true or false as plain text
      if (response.body.trim() == 'true') {
        return true;
      } else if (response.body.trim() == 'false') {
        return false;
      } else {
        throw Exception('Unexpected response: ${response.body}');
      }
    } else {
      throw Exception('Failed to check mood status');
    }
  }

  static Future<bool> submitMood(int rating) async {
    // Retrieve the JWT token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('JWT Token not found');
    }

    String url = AppConfig.apiUrl;

    final response = await http.post(
      Uri.parse('$url/mood'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({"mood_rating": rating}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to check mood status');
    }
  }

    static Future<List<Mood>> getMoods() async {
    // Retrieve the JWT token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('JWT Token not found');
    }

    String url = AppConfig.apiUrl;

    final response = await http.get(
      Uri.parse('$url/mood'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    
    );

    if (response.statusCode == 200) {
      return Mood.fromJsonList(response.body);
    } else {
      throw Exception('Failed to check mood status');
    }
  }
}
