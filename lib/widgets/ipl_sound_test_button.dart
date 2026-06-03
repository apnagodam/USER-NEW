import 'package:flutter/material.dart';
import 'package:apnagodam/core/utils/notification_service.dart';
import 'package:apnagodam/core/constants/notification_sounds.dart';

/// Quick IPL Sound Test Widget
/// Add this anywhere in your app to test the IPL sound
class IPLSoundTestButton extends StatelessWidget {
  const IPLSoundTestButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Debug test button
        ElevatedButton.icon(
          onPressed: () async {
            await NotificationService.testIPLSoundDebug();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    '🏏 IPL sound test sent! Check debug console for details.'),
                backgroundColor: Colors.orange,
              ),
            );
          },
          icon: const Icon(Icons.sports_cricket),
          label: const Text('Test IPL Sound (Debug)'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),

        const SizedBox(height: 8),

        // Regular test button
        ElevatedButton.icon(
          onPressed: () async {
            await NotificationService.showIPLNotification(
              title: '🏏 IPL Alert',
              body: 'Mumbai Indians vs Chennai Super Kings - Live Now!',
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('IPL notification sent!'),
                backgroundColor: Colors.green,
              ),
            );
          },
          icon: const Icon(Icons.notifications),
          label: const Text('Send IPL Notification'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),

        const SizedBox(height: 8),

        // Direct sound test
        ElevatedButton.icon(
          onPressed: () async {
            await NotificationService.showCustomSoundNotification(
              id: DateTime.now().millisecondsSinceEpoch,
              title: 'Direct Sound Test',
              body: 'Testing ipl_message directly',
              customSound: 'ipl_message', // Direct string test
            );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Direct sound test sent!'),
                backgroundColor: Colors.blue,
              ),
            );
          },
          icon: const Icon(Icons.volume_up),
          label: const Text('Direct Sound Test'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
        ),

        const SizedBox(height: 16),

        // Troubleshooting info
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Troubleshooting:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text('✅ File: android/app/src/main/res/raw/ipl_message.mp3'),
              Text('✅ Constant: ${NotificationSounds.iplMessage}'),
              const Text('✅ Check debug console for logs'),
              const Text('✅ Ensure device volume is up'),
              const Text('✅ Test on physical device'),
            ],
          ),
        ),
      ],
    );
  }
}
