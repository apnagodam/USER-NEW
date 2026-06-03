import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:apnagodam/core/utils/notification_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FCMTokenDisplay extends StatelessWidget {
  const FCMTokenDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FCM Token for Postman Testing:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: SelectableText(
              NotificationService.fcmToken ?? 'Token not available',
              style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  final token = NotificationService.fcmToken;
                  if (token != null) {
                    Clipboard.setData(ClipboardData(text: token));
                    Fluttertoast.showToast(
                      msg: 'FCM Token copied to clipboard!',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  }
                },
                icon: const Icon(Icons.copy),
                label: const Text('Copy Token'),
              ),
              const SizedBox(width: 12),
              ElevatedButton.icon(
                onPressed: () {
                  NotificationService.printFCMTokenForTesting();
                },
                icon: const Icon(Icons.print),
                label: const Text('Print to Console'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}