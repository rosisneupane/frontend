import 'package:flutter/material.dart';

class LifeDomainScreen extends StatelessWidget {
  final String domainTitle;
  final IconData domainIcon;

  const LifeDomainScreen({super.key, required this.domainTitle, required this.domainIcon});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Icon(domainIcon, size: 30),
            SizedBox(width: 10),
            Text(domainTitle, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Tasks", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: List.generate(5, (index) {
                  return Card(
                    margin: EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Icon(Icons.task_alt, color: Colors.green),
                      title: Text("Task ${index + 1}"),
                      subtitle: Text("Complete this task to earn XP."),
                      trailing: ElevatedButton(
                        onPressed: () {},
                        child: Text("Start"),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
