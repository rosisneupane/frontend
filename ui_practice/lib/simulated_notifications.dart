import 'dart:async';
import 'package:flutter/material.dart';

class SimulatedNotifications extends StatefulWidget {
  const SimulatedNotifications({super.key});

  @override
  _SimulatedNotificationsState createState() => _SimulatedNotificationsState();
}

class _SimulatedNotificationsState extends State<SimulatedNotifications> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scheduleFakeNotification();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _scheduleFakeNotification() {
    // Define the target time for the notification
    final targetTime = Duration(hours: 22, minutes: 57); // Set to 10:40 AM
    final now = DateTime.now();
    final todayAtTargetTime = DateTime(now.year, now.month, now.day,
        targetTime.inHours, targetTime.inMinutes);

    // Calculate the difference from now to the target time
    final duration = todayAtTargetTime.isBefore(now)
        ? todayAtTargetTime.add(Duration(days: 1)).difference(now)
        : todayAtTargetTime.difference(now);

    _timer = Timer(duration, _showFakeNotification);
  }

  void _showFakeNotification() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Daily Check-in'),
        content: Text('Hi, how are you today?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Close'),
          ),
        ],
      ),
    );
    // Reschedule the next notification
    _scheduleFakeNotification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notification Simulation')),
      body: Center(
        child: Text('Wait for simulated notification...'),
      ),
    );
  }
}
