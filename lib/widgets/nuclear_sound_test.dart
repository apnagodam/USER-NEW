import 'package:flutter/material.dart';
import 'package:apnagodam/core/utils/notification_service.dart';

class NuclearSoundTest extends StatelessWidget {
  const NuclearSoundTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[900]?.withOpacity(0.1),
        border: Border.all(color: Colors.red[900]!, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.warning, color: Colors.red[900], size: 20),
              const SizedBox(width: 8),
              Text(
                '☢️ NUCLEAR TEST',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red[900],
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.warning, color: Colors.red[900], size: 20),
            ],
          ),
          const SizedBox(height: 8),
          const Text(
            'This bypasses Firebase entirely and uses the exact same method as working buttons',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          
          // Nuclear Firebase Test
          ElevatedButton.icon(
            onPressed: () async {
              await NotificationService.nuclearFirebaseTest();
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('☢️ Nuclear Firebase test sent! This should work like buttons.'),
                  backgroundColor: Colors.red[900],
                ),
              );
            },
            icon: const Icon(Icons.bug_report),
            label: const Text('☢️ NUCLEAR FIREBASE TEST'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[900],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Direct forced test
          ElevatedButton.icon(
            onPressed: () async {
              // Use the exact forced method that should work
              await NotificationService.showCustomSoundNotification(
                id: DateTime.now().millisecondsSinceEpoch,
                title: '🔥 Direct Test',
                body: 'Direct call - should work like button',
                customSound: 'ipl_message',
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🔥 Direct test sent! Should work exactly like buttons.'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
            icon: const Icon(Icons.rocket_launch),
            label: const Text('🔥 DIRECT METHOD TEST'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
          ),
          
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.amber),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🧪 Test Logic:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  '• Nuclear test simulates Firebase message processing',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  '• Direct test uses exact same method as working buttons',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  '• If neither works, it\'s a system/file issue',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  '• If direct works but nuclear doesn\'t, it\'s Firebase processing',
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