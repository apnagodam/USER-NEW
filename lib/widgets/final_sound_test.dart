import 'package:flutter/material.dart';
import 'package:apnagodam/core/utils/notification_service.dart';

class FinalSoundTest extends StatelessWidget {
  const FinalSoundTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.yellow.shade50, Colors.orange.shade50],
        ),
        border: Border.all(color: Colors.orange, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: Colors.orange[700], size: 24),
              const SizedBox(width: 8),
              Text(
                '🏆 FINAL ULTIMATE TEST',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.orange[700],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.star, color: Colors.orange[700], size: 24),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.orange[100],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Column(
              children: [
                Text(
                  '🎯 ULTIMATE APPROACH:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                SizedBox(height: 4),
                Text(
                  '• Creates completely unique channel every time',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '• Pre-deletes any existing channel',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '• Waits for Android to process changes',
                  style: TextStyle(fontSize: 12),
                ),
                Text(
                  '• Forces fresh channel with sound',
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          
          ElevatedButton.icon(
            onPressed: () async {
              await NotificationService.showCustomSoundNotification(
                id: (DateTime.now().millisecondsSinceEpoch % 2147483647),
                title: '🏆 ULTIMATE IPL TEST',
                body: 'This should FINALLY play your custom IPL sound!',
                customSound: 'ipl_message',
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('🏆 ULTIMATE test sent! This should work!'),
                  backgroundColor: Colors.orange[700],
                  duration: const Duration(seconds: 3),
                ),
              );
            },
            icon: const Icon(Icons.music_note, size: 28),
            label: const Text(
              '🏆 ULTIMATE IPL SOUND TEST',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          
          const SizedBox(height: 12),
          
          ElevatedButton.icon(
            onPressed: () async {
              // Test Firebase path with ultimate approach
              await NotificationService.testFirebaseNotificationPath(
                title: '🔥 Ultimate Firebase Test',
                body: 'Testing Firebase with ultimate approach',
                sound: 'ipl_message',
                type: 'ipl_message',
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🔥 Ultimate Firebase test sent!'),
                  backgroundColor: Colors.blue,
                ),
              );
            },
            icon: const Icon(Icons.cloud_upload),
            label: const Text('🔥 ULTIMATE FIREBASE TEST'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          
          const SizedBox(height: 16),
          
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '✅ Why this will work:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: Colors.green),
                ),
                SizedBox(height: 4),
                Text(
                  '• Completely bypasses Android channel caching',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  '• Creates fresh channel with microsecond precision',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  '• Pre-deletes potential conflicts',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  '• Waits for Android system to process changes',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  '• Your ipl_message.mp3 file is confirmed working',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}