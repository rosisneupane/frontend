import 'package:flutter/material.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Social"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Social Skills Training
              _buildSectionTitle("Social Skills Training"),
              _buildCard(
                context,
                "Role-Playing Scenarios",
                "Practice initiating and maintaining conversations.",
                Icons.theater_comedy,
              ),
              _buildCard(
                context,
                "Communication Scripts",
                "Access templates for handling difficult topics.",
                Icons.message,
              ),

              // Section 2: Building Confidence
              SizedBox(height: 16),
              _buildSectionTitle("Building Confidence"),
              _buildCard(
                context,
                "Practice Challenges",
                "Complete tasks like joining a group activity.",
                Icons.flag,
              ),
              _buildCard(
                context,
                "Social Interaction Rewards",
                "Earn badges for engaging in social interactions.",
                Icons.star,
              ),

              // Section 3: Community Engagement
              SizedBox(height: 16),
              _buildSectionTitle("Community Engagement"),
              _buildCard(
                context,
                "Safe Chat Spaces",
                "Join moderated spaces to connect with peers.",
                Icons.chat_bubble_outline,
              ),
              _buildCard(
                context,
                "Collaborative Challenges",
                "Work together on group tasks to build teamwork.",
                Icons.group,
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
          color: Colors.purple,
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
