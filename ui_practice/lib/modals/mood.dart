import 'dart:convert';

class Mood {
  final String id; // Make id optional for POST requests
  final String userId; // Make userId optional for POST requests
  final String date;
  final int moodRating;


  // Constructor updated to make id and userId optional
  Mood({
    required this.id,
    required this.userId,
    required this.date,
    required this.moodRating,
  });

  factory Mood.fromJson(Map<String, dynamic> json) {
    return Mood(
      id: json['id'],
      userId: json['user_id'],
      date: json['date'],
      moodRating: json['mood_rating'],

    );
  }

  static List<Mood> fromJsonList(String str) {
    return List<Mood>.from(json.decode(str).map((x) => Mood.fromJson(x)));
  }


}
