import 'package:flutter/material.dart';

class ResultsScreen extends StatelessWidget {
  final int score;

  const ResultsScreen({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Results")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Congratulations, you have completed the quiz!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Your score is: $score",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            // Provide feedback based on the score
            Text(
              scoreFeedback(score),
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  String scoreFeedback(int score) {
    if (score > 75) {
      return "You have a healthy emotional and stress management skillset.";
    } else if (score > 50) {
      return "You're doing okay, but there's room to improve your coping strategies.";
    } else {
      return "Consider developing stronger emotional and stress management skills.";
    }
  }
}
