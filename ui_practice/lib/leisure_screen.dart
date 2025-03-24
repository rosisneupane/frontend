import 'package:flutter/material.dart';

class LeisureScreen extends StatelessWidget {
  const LeisureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Leisure"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Activity Recommendations
              _buildSectionTitle("Activity Recommendations"),
              _buildCard(
                context,
                "Explore Hobbies & Sports",
                "Get suggestions for creative hobbies, sports, and relaxation.",
                Icons.sports,
              ),
              _buildCard(
                context,
                "Rewards for Trying New Activities",
                "Earn badges and rewards by exploring new leisure activities.",
                Icons.emoji_events,
              ),

              // Section 2: Mind-Body Integration
              SizedBox(height: 16),
              _buildSectionTitle("Mind-Body Integration"),
              _buildCard(
                context,
                "Yoga Routines",
                "Follow guided yoga sessions to relax and recharge.",
                Icons.self_improvement,
              ),
              _buildCard(
                context,
                "Body Scan Meditation",
                "Practice mindfulness with body scan exercises.",
                Icons.bubble_chart,
              ),
              _buildCard(
                context,
                "Mindful Walking",
                "Discover the art of mindful walking for stress relief.",
                Icons.directions_walk,
              ),

              // Section 3: Gamification
              SizedBox(height: 16),
              _buildSectionTitle("Gamification"),
              _buildCard(
                context,
                "Virtual Rewards",
                "Unlock virtual rewards for engaging in leisure tasks.",
                Icons.videogame_asset,
              ),
              _buildCard(
                context,
                "Avatars & Themed Environments",
                "Customize avatars and explore fun themed environments.",
                Icons.person,
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
          color: Colors.red,
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
