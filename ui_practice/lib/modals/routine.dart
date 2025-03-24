import 'dart:convert';

class Routine {
  final String? id; // Make id optional for POST requests
  final String? userId; // Make userId optional for POST requests
  final String date;
  final String time;
  final String text;
  final bool status;

  // Constructor updated to make id and userId optional
  Routine({
    this.id,
    this.userId,
    required this.date,
    required this.time,
    required this.text,
    required this.status,
  });

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json['id'],
      userId: json['user_id'],
      date: json['date'],
      time: json['time'],
      text: json['text'],
      status: json['status'],
    );
  }

  static List<Routine> fromJsonList(String str) {
    return List<Routine>.from(json.decode(str).map((x) => Routine.fromJson(x)));
  }

  // Method to convert the routine to JSON format for POST request
  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'text': text,
      'status': status,
    };
  }
}
