import 'package:flutter/material.dart';

class GamificationCard extends StatelessWidget {
  const GamificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "You're Level 3! 20 XP to Level 4.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.8,
              color: Colors.amber,
              backgroundColor: Colors.grey[300],
            ),
          ],
        ),
      ),
    );
  }
}
