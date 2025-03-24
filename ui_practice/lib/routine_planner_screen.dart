import 'package:flutter/material.dart';

class RoutinePlannerScreen extends StatelessWidget {
  const RoutinePlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Routine Planner"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 24,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Text("${index + 1}:00", style: TextStyle(fontSize: 18)),
                    title: Text("Task Name"),
                    trailing: Icon(Icons.drag_handle),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text("Save Routine"),
          ),
        ],
      ),
    );
  }
}
