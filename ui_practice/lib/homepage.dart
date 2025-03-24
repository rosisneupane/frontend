import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_practice/chatbot_screen.dart';
import 'package:ui_practice/education_screen.dart';
import 'package:ui_practice/leisure_screen.dart';
import 'package:ui_practice/login_screen.dart';
import 'package:ui_practice/selfcare_screen.dart';
import 'package:ui_practice/social_screen.dart';
import 'package:ui_practice/work_screen.dart';
import '../widgets/domain_card.dart';
import '../widgets/drawer_menu.dart';
import '../widgets/gamification_card.dart';
import '../widgets/section_title.dart';
import '../widgets/top_section.dart';

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
        title: const Text("MultiCoached"),
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: DrawerMenu(logoutCallback: _logout),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopSection(),
            const SectionTitle(title: "Core Features"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  DomainCard(
                    icon: Icons.book,
                    title: "Education",
                    color: Colors.blue,
                    screen: EducationScreen(),
                  ),
                  DomainCard(
                    icon: Icons.work,
                    title: "Work",
                    color: Colors.green,
                    screen: WorkScreen(),
                  ),
                  DomainCard(
                    icon: Icons.chat,
                    title: "Social",
                    color: Colors.purple,
                    screen: SocialScreen(),
                  ),
                  DomainCard(
                    icon: Icons.spa,
                    title: "Self-Care",
                    color: Colors.orange,
                    screen: SelfCareScreen(),
                  ),
                  DomainCard(
                    icon: Icons.palette,
                    title: "Leisure",
                    color: Colors.red,
                    screen: LeisureScreen(),
                  ),
                  DomainCard(
                    icon: Icons.chat_bubble_outline,
                    title: "EaseTalk",
                    color: Colors.indigo,
                    screen: ChatbotScreen(),
                  ),
                ],
              ),
            ),
            const SectionTitle(title: "Gamification Tracker"),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: GamificationCard(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }
}
