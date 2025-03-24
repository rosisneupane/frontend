import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'education_screen.dart';
import 'work_screen.dart';
import 'social_screen.dart';
import 'selfcare_screen.dart';
import 'leisure_screen.dart';
import 'chatbot_screen.dart';
import 'routine_planner_screen.dart';
import 'sensory_regulation_screen.dart';
import 'social_tools_screen.dart';
import 'profile_screen.dart';
import 'login_screen.dart';


// moods

List<IconData> moodIcons = [
Icons.sentiment_very_dissatisfied,  // sad
Icons.sentiment_dissatisfied,
Icons.sentiment_neutral,
Icons.sentiment_satisfied,
Icons.sentiment_very_satisfied,  // happy
];
int? selectedMoodIndex;



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    String? _token;

  @override
  void initState() {
    super.initState();
    _loadToken();
  }
    Future<void> _logout() async {
      print("Logging You Out!!!");
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');

      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (route) => false,
      );
    }

    Future<void> _loadToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _token = prefs.getString('access_token');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MultiCoached"),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: _buildDrawer(context), // Sidebar Drawer
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Section - Greeting & Progress
            _buildTopSection(context),

            // Core Features Section
            _buildSectionTitle("Core Features"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildDomainCard(
                    context,
                    Icons.book,
                    "Education",
                    Colors.blue,
                    EducationScreen(),
                  ),
                  _buildDomainCard(
                    context,
                    Icons.work,
                    "Work",
                    Colors.green,
                    WorkScreen(),
                  ),
                  _buildDomainCard(
                    context,
                    Icons.chat,
                    "Social",
                    Colors.purple,
                    SocialScreen(),
                  ),
                  _buildDomainCard(
                    context,
                    Icons.spa,
                    "Self-Care",
                    Colors.orange,
                    SelfCareScreen(),
                  ),
                  _buildDomainCard(
                    context,
                    Icons.palette,
                    "Leisure",
                    Colors.red,
                    LeisureScreen(),
                  ),
                  _buildDomainCard(
                    context,
                    Icons.chat_bubble_outline,
                    "EaseTalk",
                    Colors.indigo,
                    ChatbotScreen(),
                  ),
                ],
              ),
            ),

            // Gamification Tracker Section
            _buildSectionTitle("Gamification Tracker"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: _buildGamificationCard(),
            ),
          ],
        ),
      ),
    );
  }

  // Sidebar Drawer
  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Drawer Header
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            decoration: BoxDecoration(
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
              children: [
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
          // Drawer Items
          Expanded(
            child: ListView(
              children: [
                _buildDrawerItem(
                  context,
                  Icons.calendar_today,
                  "Routine Planner",
                  Colors.orange,
                  RoutinePlannerScreen(),
                ),
                _buildDrawerItem(
                  context,
                  Icons.spa,
                  "Sensory Regulation",
                  Colors.teal,
                  SensoryRegulationScreen(),
                ),
                _buildDrawerItem(
                  context,
                  Icons.chat_bubble,
                  "Social Tools",
                  Colors.purple,
                  SocialToolsScreen(),
                ),
                _buildDrawerItem(
                  context,
                  Icons.person,
                  "Profile",
                  Colors.blue,
                  ProfileScreen(),
                ),GestureDetector(
                  onTap: () {
                    print('Component tapped!');
                    _logout();

                  },
                  child: ListTile(
                    leading: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Icon(
                        Icons.logout,
                        // color: Colors.blue,
                        size: 24,
                      ),
                    ),
                    title: Text(
                      "logout",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // trailing: Icon(
                    //   Icons.arrow_forward_ios,
                    //   color: Colors.grey,
                    //   size: 16,
                    // ),

                  ),
                ),

              ],
            ),
          ),
          // Footers
          Container(
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

  // Drawer Item
  Widget _buildDrawerItem(
      BuildContext context, IconData icon, String title, Color color, Widget screen) {
    return ListTile(
      leading: Container(
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(8),
        child: Icon(
          icon,
          color: color,
          size: 24,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey,
        size: 16,
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
    );
  }

  // // Top Section - Greeting and Progress
  Widget _buildTopSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue, Colors.blueAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage('assets/rosis.png'),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Text(
                  "Hi Rosis, how are you feeling today?",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton.icon(
                icon: Icon(Icons.history, size: 20),
                label: Text("Resume Content"),
                onPressed: () {
                  Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => EducationScreen()),
                                      );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          // Display static mood icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Icon(Icons.sentiment_very_dissatisfied, color: Colors.white, size: 36),
              Icon(Icons.sentiment_dissatisfied, color: Colors.white, size: 36),
              Icon(Icons.sentiment_neutral, color: Colors.white, size: 36),
              Icon(Icons.sentiment_satisfied, color: Colors.white, size: 36),
              Icon(Icons.sentiment_very_satisfied, color: Colors.white, size: 36),
            ],
          ),
          SizedBox(height: 8),
          // LinearProgressIndicator(
          //   value: 0.6,
          //   backgroundColor: Colors.white.withOpacity(0.3),
          //   color: Colors.greenAccent,
          // ),
          SizedBox(height: 8),
          // Text(
          //   "5 Days to Go for a Perfect Week!",
          //   style: TextStyle(color: Colors.white, fontSize: 16),
          // ),
        ],
      ),
    );
  }

  // Section Title
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Core Domain Card
  Widget _buildDomainCard(
      BuildContext context,
      IconData icon,
      String title,
      Color color,
      Widget screen,
      ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: color,
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Gamification Card
  Widget _buildGamificationCard() {
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
            Text(
              "You're Level 3! 20 XP to Level 4.",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
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
