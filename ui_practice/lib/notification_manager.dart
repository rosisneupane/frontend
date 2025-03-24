// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
//
// void scheduleDailyNineAMNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//   var now = tz.TZDateTime.now(tz.local);
//   var nineAM = tz.TZDateTime(tz.local, now.year, now.month, now.day, 22,40);
//   if (nineAM.isBefore(now)) {
//     nineAM = nineAM.add(const Duration(days: 1)); // Schedule for next day if time is past
//   }
//
//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     'Daily Check-in',
//     'Hi, how are you today?',
//     nineAM,
//     const NotificationDetails(
//         android: AndroidNotificationDetails(
//             'your_channel_id',
//             'your_channel_name',
//             channelDescription: 'Daily motivational notifications',
//             importance: Importance.max,
//             priority: Priority.high,
//             ticker: 'ticker'
//         )
//     ),
//     androidAllowWhileIdle: true,
//     uiLocalNotificationDateInterpretation:
//     UILocalNotificationDateInterpretation.absoluteTime,
//     matchDateTimeComponents: DateTimeComponents.time,
//   );
// }
