import 'package:flutter/material.dart';

import '../../../../../utils/app_color.dart';

class NotificationItem {
  final String title;
  final String message;
  final DateTime time;

  NotificationItem({
    required this.title,
    required this.message,
    required this.time,
  });
}

class NotificationPage extends StatelessWidget {
  NotificationPage({super.key});

  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Welcome to our App',
      message: 'Thank you for joining! We are excited to have you.',
      time: DateTime.now().subtract(const Duration(minutes: 5)),
    ),
    NotificationItem(
      title: 'Order Shipped',
      message: 'Your order #1234 has been shipped.',
      time: DateTime.now().subtract(const Duration(hours: 2, minutes: 30)),
    ),
    NotificationItem(
      title: 'New Message',
      message: 'You have received a new message from support.',
      time: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
    ),
    NotificationItem(
      title: 'Weekly Update',
      message: 'Here’s what’s new this week in our app.',
      time: DateTime.now().subtract(const Duration(days: 2, hours: 3)),
    ),
  ];

  String formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(

            leading:  Icon(Icons.notifications, color:AppColor.primaryColor),
            title: Text(
              notification.title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(notification.message),
            trailing: Text(
              formatTime(notification.time),
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
            onTap: () {
              // Optionally handle tap
            },
          );
        },
      ),
    );
  }
}
