import 'package:flutter/material.dart';

class SensoryRegulationScreen extends StatelessWidget {
  const SensoryRegulationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Find Your Calm"),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: [
          _buildActivityCard("Movement Breaks", Icons.directions_walk),
          _buildActivityCard("Relaxation", Icons.self_improvement),
          _buildActivityCard("Heavy Work", Icons.fitness_center),
        ],
      ),
    );
  }

  Widget _buildActivityCard(String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Activity action
      },
      child: Card(
        elevation: 4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
