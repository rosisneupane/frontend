import 'package:flutter/material.dart';

class SelfCareScreen extends StatelessWidget {
  const SelfCareScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Self-Care"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section 1: Daily Routines
              _buildSectionTitle("Daily Routines"),
              _buildCard(
                context,
                "Morning & Evening Routines",
                "Set up customizable routines for your mornings and evenings.",
                Icons.wb_sunny,
              ),
              _buildCard(
                context,
                "Visual Checklists",
                "Follow checklists for tasks like hygiene and meal prep.",
                Icons.checklist,
              ),

              // Section 2: Healthy Habits
              SizedBox(height: 16),
              _buildSectionTitle("Healthy Habits"),
              _buildCard(
                context,
                "Track Hydration, Sleep & Nutrition",
                "Monitor and improve your daily health habits.",
                Icons.local_drink,
              ),
              _buildCard(
                context,
                "Crisis Tools",
                "Access grounding exercises for overwhelming emotions.",
                Icons.self_improvement,
              ),

              // Section 3: Sensory Regulation
              SizedBox(height: 16),
              _buildSectionTitle("Sensory Regulation"),
              _buildCard(
                context,
                "Personalized Sensory Diet",
                "Receive recommendations for sensory activities.",
                Icons.dining,
              ),
              _buildCard(
                context,
                "Movement Breaks & Calming Exercises",
                "Guided exercises for relaxation and focus.",
                Icons.accessibility_new,
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
          color: Colors.orange,
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
