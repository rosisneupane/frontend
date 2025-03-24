import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui_practice/api/routine.dart';
import 'package:ui_practice/modals/routine.dart';
import 'package:ui_practice/views/create_routine.dart'; // Import the create routine page

class RoutinePlannerScreen extends StatefulWidget {
  const RoutinePlannerScreen({super.key});

  @override
  State<RoutinePlannerScreen> createState() => _RoutinePlannerScreenState();
}

class _RoutinePlannerScreenState extends State<RoutinePlannerScreen> {
  late Future<List<Routine>> futureRoutines;

  @override
  void initState() {
    super.initState();
    futureRoutines = ApiService.fetchRoutines();
  }

  String formatDateTime(String date, String time) {
    try {
      DateTime dateTime = DateTime.parse('$date $time');
      return DateFormat('MMM d, yyyy - h:mm a').format(dateTime);
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Routine Planner")),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Routine>>(
              future: futureRoutines,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No routines found'));
                }

                List<Routine> routines = snapshot.data!;
                return ListView.builder(
                  itemCount: routines.length,
                  itemBuilder: (context, index) {
                    Routine routine = routines[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      child: ListTile(
                        title: Text(
                          routine.text,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(formatDateTime(routine.date, routine.time)),
                        trailing: Icon(
                          routine.status ? Icons.check_circle : Icons.cancel,
                          color: routine.status ? Colors.green : Colors.red,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity, // Make the button full-width
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CreateRoutine()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Button color
                  padding: const EdgeInsets.symmetric(vertical: 16), // Bigger touch area
                ),
                child: const Text(
                  "Create Routine",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
