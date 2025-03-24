import 'package:flutter/material.dart';

class EducationScreen extends StatelessWidget {
  const EducationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Education"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Study Support Tools
              _buildSectionTitle("Study Support Tools"),
              _buildCard(
                context,
                "Focus Timer",
                "Set focus periods using a timer (e.g., Pomodoro technique).",
                Icons.timer,
              ),
              _buildCard(
                context,
                "Study Habit Tracker",
                "Track study sessions and build streaks for consistency.",
                Icons.track_changes,
              ),
              _buildCard(
                context,
                "Stress Management",
                "Learn techniques to manage school-related stress.",
                Icons.self_improvement,
              ),

              // Section 2: Goal Setting
              SizedBox(height: 16),
              _buildSectionTitle("Goal Setting"),
              _buildCard(
                context,
                "Set SMART Goals",
                "Create specific, measurable, achievable, relevant, and time-bound goals.",
                Icons.task_alt,
              ),
              _buildCard(
                context,
                "Earn Rewards",
                "Unlock badges and rewards by completing academic tasks.",
                Icons.emoji_events,
              ),

              // Section 3: Organizational Skills
              SizedBox(height: 16),
              _buildSectionTitle("Organizational Skills"),
              _buildCard(
                context,
                "Task Planner",
                "Visualize and organize tasks to meet deadlines effectively.",
                Icons.calendar_today,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String description, IconData icon) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 40,
          color: Colors.blue,
        ),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(description),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey,
        ),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Navigating to $title...")),
          );
        },
      ),
    );
  }
}
