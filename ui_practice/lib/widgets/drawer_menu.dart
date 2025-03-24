import 'package:flutter/material.dart';
import 'package:ui_practice/profile_screen.dart';
import 'package:ui_practice/routine_planner_screen.dart';
import 'package:ui_practice/sensory_regulation_screen.dart';
import 'package:ui_practice/social_tools_screen.dart';
import 'package:ui_practice/views/mood_history.dart';


class DrawerMenu extends StatelessWidget {
  final VoidCallback logoutCallback;
  const DrawerMenu({super.key, required this.logoutCallback});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.blueAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage('assets/rosis.png'),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hi Rosis!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Ready to achieve your goals?",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(context, Icons.calendar_today, "Routine Planner", Colors.orange, const RoutinePlannerScreen()),
                _buildDrawerItem(context, Icons.spa, "Sensory Regulation", Colors.teal, const SensoryRegulationScreen()),
                _buildDrawerItem(context, Icons.chat_bubble, "Social Tools", Colors.purple, const SocialToolsScreen()),
                _buildDrawerItem(context, Icons.person, "Profile", Colors.blue, const ProfileScreen()),
                _buildDrawerItem(context, Icons.person, "Mood History", Colors.blue,  MoodHistoryPage()),
                GestureDetector(
                  onTap: logoutCallback,
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.logout, size: 24),
                    ),
                    title: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              "© 2025 MultiCoached",
              style: TextStyle(color: Colors.grey, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, Color color, Widget screen) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
        child: Icon(icon, color: color, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }
}
