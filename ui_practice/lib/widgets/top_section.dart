import 'package:flutter/material.dart';
import 'package:ui_practice/api/mood.dart';
import 'package:ui_practice/education_screen.dart';
import 'package:ui_practice/user_service.dart';

class TopSection extends StatefulWidget {
  const TopSection({super.key});

  @override
  State<TopSection> createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  bool? _hasMoodToday;
  final user = UserService().user;



  @override
  void initState() {
    super.initState();

    _fetchMoodStatus();
  }

  Future<void> _fetchMoodStatus() async {
    try {
      bool status = await MoodApiService.checkTodayMood();
      setState(() {
        _hasMoodToday = status;
      });
    } catch (e) {
      setState(() {
        _hasMoodToday = false;
      });
    }
  }

  Future<void> _submitMood(int rating) async {
    try {
      bool status = await MoodApiService.submitMood(rating);
      setState(() {
        _hasMoodToday = status;
      });
    } catch (e) {
      setState(() {
        _hasMoodToday = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasMoodToday == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return _hasMoodToday!
        ? const SizedBox.shrink()
        : Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
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
                    const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage('assets/rosis.png'),
                    ),
                    const SizedBox(width: 16),
                     Expanded(
                      child: Text(
                        "Hi ${user?.username}, how are you feeling today?",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.history, size: 20),
                      label: const Text("Resume"),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const EducationScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue[800],
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 8),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _submitMood(1);
                      },
                      child: Icon(Icons.sentiment_very_dissatisfied,
                          color: Colors.white, size: 36),
                    ),
                    GestureDetector(
                      onTap: () {
                        _submitMood(2);
                      },
                      child: const Icon(Icons.sentiment_dissatisfied,
                          color: Colors.white, size: 36),
                    ),
                    GestureDetector(
                      onTap: () {
                        _submitMood(3);
                      },
                      child: const Icon(Icons.sentiment_neutral,
                          color: Colors.white, size: 36),
                    ),
                    GestureDetector(
                      onTap: () {
                        _submitMood(4);
                      },
                      child: const Icon(Icons.sentiment_satisfied,
                          color: Colors.white, size: 36),
                    ),
                    GestureDetector(
                      onTap: () {
                        _submitMood(5);
                      },
                      child: const Icon(Icons.sentiment_very_satisfied,
                          color: Colors.white, size: 36),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
