import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/config/config.dart';
import 'package:ui_practice/modals/routine.dart';
import 'dart:convert';

class ApiService {
  static Future<List<Routine>> fetchRoutines() async {
    // Retrieve the JWT token from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance(); 
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('JWT Token not found');
    }

    String url = AppConfig.apiUrl;

    final response = await http.get(
      Uri.parse('$url/routines'),
      headers: {
        'Authorization': 'Bearer $token', // Pass JWT Token in Header
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Routine.fromJsonList(response.body);
    } else {
      throw Exception('Failed to load Routines');
    }
  }

  // Function to post a new routine
  static Future<bool> postRoutine(Routine routine) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('access_token');

    if (token == null) {
      throw Exception('JWT Token not found');
    }

    String url = AppConfig.apiUrl;

    final response = await http.post(
      Uri.parse('$url/routines'),
      headers: {
        'Authorization': 'Bearer $token', // Pass JWT Token in Header
        'Content-Type': 'application/json',
      },
      body: jsonEncode(routine.toJson()),
    );

    if (response.statusCode == 200) {
      // If successful, return true
      return true;
    } else {
      throw Exception('Failed to create routine');
    }
  }
}
