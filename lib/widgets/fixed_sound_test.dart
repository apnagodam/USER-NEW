import 'package:flutter/material.dart';
import 'package:apnagodam/core/utils/notification_service.dart';

class FixedSoundTest extends StatelessWidget {
  const FixedSoundTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green[700], size: 20),
              const SizedBox(width: 8),
              Text(
                '✅ FIXED DIRECT TEST',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.green[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'Now using FORCED approach for all custom sounds - no fallback to cached channels',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          
          ElevatedButton.icon(
            onPressed: () async {
              await NotificationService.showCustomSoundNotification(
                id: DateTime.now().millisecondsSinceEpoch,
                title: '✅ FIXED Direct Test',
                body: 'This should now work - using forced approach only!',
                customSound: 'ipl_message',
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('✅ Fixed direct test sent! Should work now.'),
                  backgroundColor: Colors.green[700],
                ),
              );
            },
            icon: const Icon(Icons.rocket_launch),
            label: const Text('✅ TEST FIXED DIRECT METHOD'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          
          const SizedBox(height: 8),
          
          ElevatedButton.icon(
            onPressed: () async {
              // Test Firebase path with fixed direct method
              await NotificationService.testFirebaseNotificationPath(
                title: '🔥 Fixed Firebase Test',
                body: 'Testing Firebase path with fixed direct method',
                sound: 'ipl_message',
                type: 'ipl_message',
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🔥 Fixed Firebase path test sent!'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            icon: const Icon(Icons.cloud),
            label: const Text('🔥 TEST FIXED FIREBASE PATH'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ),
          
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green[100],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.green),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🔧 What was fixed:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  '• Removed fallback to cached channels',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  '• Custom sounds ALWAYS use forced approach',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  '• No more try/catch that falls back to broken method',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  '• Direct method now works like nuclear method',
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}