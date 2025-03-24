import 'package:flutter/material.dart';

class WorkScreen extends StatelessWidget {
  const WorkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Work"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Career Exploration
              _buildSectionTitle("Career Exploration"),
              _buildCard(
                context,
                "Strength & Interest Quiz",
                "Take quizzes to identify your strengths and interests.",
                Icons.quiz,
              ),
              _buildCard(
                context,
                "Part-Time Work Resources",
                "Access guides and tips for transitioning to part-time jobs.",
                Icons.work_outline,
              ),

              // Section 2: Skill Building
              SizedBox(height: 16),
              _buildSectionTitle("Skill Building"),
              _buildCard(
                context,
                "Time Management",
                "Learn how to manage your time effectively.",
                Icons.access_time,
              ),
              _buildCard(
                context,
                "Workplace Communication",
                "Practice role-playing for professional interactions.",
                Icons.chat_bubble_outline,
              ),

              // Section 3: Work-Life Balance
              SizedBox(height: 16),
              _buildSectionTitle("Work-Life Balance"),
              _buildCard(
                context,
                "Planner",
                "Organize your school, work, and leisure activities.",
                Icons.calendar_today,
              ),
              _buildCard(
                context,
                "Routine Rewards",
                "Earn rewards for maintaining a balanced routine.",
                Icons.emoji_events,
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
          color: Colors.green,
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
