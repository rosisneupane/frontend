import 'package:flutter/material.dart';
import 'package:ui_practice/api/mood.dart';
import 'package:ui_practice/modals/mood.dart';

class MoodHistoryPage extends StatefulWidget {
  MoodHistoryPage({super.key});

  @override
  State<MoodHistoryPage> createState() => _MoodHistoryPageState();
}

class _MoodHistoryPageState extends State<MoodHistoryPage> {
  late Future<List<Mood>> futureMoods;
  @override
  void initState() {
    super.initState();
    futureMoods = MoodApiService.getMoods();
    print("The moods are ###### here");

  }



  // Mood Icon mapper
  IconData getMoodIcon(int rating) {
    switch (rating) {
      case 1:
        return Icons.sentiment_very_dissatisfied;
      case 2:
        return Icons.sentiment_dissatisfied;
      case 3:
        return Icons.sentiment_neutral;
      case 4:
        return Icons.sentiment_satisfied;
      case 5:
        return Icons.sentiment_very_satisfied;
      default:
        return Icons.help_outline;
    }
  }

  Color getMoodColor(int rating) {
    switch (rating) {
      case 1:
      case 2:
        return Colors.redAccent;
      case 3:
        return Colors.amber;
      case 4:
      case 5:
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mood History"),

      ),
      body: FutureBuilder<List<Mood>>(
          future: futureMoods,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No moods found'));
            }
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Date",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      Text(
                        "Mood",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ],
                  ),
                  const Divider(),
                  Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        Mood item = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                item.date,
                                style: const TextStyle(fontSize: 15),
                              ),
                              Icon(
                                getMoodIcon(item.moodRating),
                                color: getMoodColor(item.moodRating),
                                size: 32,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
