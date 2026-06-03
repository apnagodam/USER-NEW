import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:apnagodam/core/utils/notification_service.dart';
import 'package:get/get.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

/// Firebase Console Testing Helper Widget
/// Add this to your app to easily get FCM token and test notifications
class FirebaseTestingWidget extends StatelessWidget {
  const FirebaseTestingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Console Testing'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Firebase Console Testing Helper',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Get FCM Token
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '1. Get FCM Token',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Copy this token to use in Firebase Console',
                      style: TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () {
                        _showFCMToken(context);
                      },
                      icon: const Icon(Icons.copy),
                      label: const Text('Get & Copy FCM Token'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Firebase Console Instructions
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '2. Firebase Console Setup',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text('• Go to Firebase Console > Messaging'),
                    const Text('• Click "Send test message"'),
                    const Text('• Paste your FCM token'),
                    const Text('• Add custom data for sound testing'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Test Examples
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '3. Test Examples',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    _buildTestExample('IPL Sound', 'type', 'ipl_message'),
                    _buildTestExample('Order Sound', 'type', 'order_received'),
                    _buildTestExample('Urgent Sound', 'type', 'urgent'),
                    _buildTestExample('Price Alert', 'type', 'price_alert'),
                    _buildTestExample('Direct Sound', 'sound', 'ipl_message'),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Local Test Buttons
            const Text(
              'Local Testing (No Firebase needed):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      NotificationService.showIPLNotification(
                        title: 'Local IPL Test',
                        body: 'Testing ipl_message.mp3 locally',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Test IPL Sound'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      NotificationService.showUrgentNotification(
                        title: 'Local Urgent Test',
                        body: 'Testing urgent sound locally',
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Test Urgent'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTestExample(String name, String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text('$name:',
                style: const TextStyle(fontWeight: FontWeight.w500)),
          ),
          Expanded(
            flex: 3,
            child: Text(
              '$key: $value',
              style: const TextStyle(
                fontFamily: 'monospace',
                fontSize: 12,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showFCMToken(BuildContext context) {
    final token = NotificationService.fcmToken;

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('FCM Token not available yet. Please wait...'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Print to console for debugging
    NotificationService.printFCMTokenForTesting();

    // Show dialog with token
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('FCM Token'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Copy this token for Firebase Console testing:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: SelectableText(
                token,
                style: const TextStyle(
                  fontSize: 12,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Clipboard.setData(ClipboardData(text: token));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('FCM Token copied to clipboard!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text('Copy Token'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(AppLocalizations.of(context)!.close),
          ),
        ],
      ),
    );
  }
}
