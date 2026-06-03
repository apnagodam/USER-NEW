import 'package:flutter/material.dart';
import 'package:apnagodam/core/utils/notification_service.dart';

class SafeIDSoundTest extends StatelessWidget {
  const SafeIDSoundTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '🛡️ SAFE ID SOUND TEST',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.blue[700],
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Uses safe 32-bit integer IDs to avoid overflow',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          
          ElevatedButton.icon(
            onPressed: () async {
              // Use a simple safe ID
              const safeId = 12345;
              
              await NotificationService.showCustomSoundNotification(
                id: safeId,
                title: '🛡️ Safe ID IPL Test',
                body: 'Testing with safe ID - should play IPL sound!',
                customSound: 'ipl_message',
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('🛡️ Safe ID test sent! Check for IPL sound.'),
                  backgroundColor: Colors.blue[700],
                ),
              );
            },
            icon: const Icon(Icons.shield),
            label: const Text('🛡️ SAFE ID TEST'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          
          const SizedBox(height: 8),
          
          ElevatedButton.icon(
            onPressed: () async {
              // Use IPL notification method directly (should use safe ID internally)
              await NotificationService.showIPLNotification(
                title: '🏏 Direct IPL Method',
                body: 'Using showIPLNotification directly',
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🏏 Direct IPL method test sent!'),
                  backgroundColor: Colors.green,
                ),
              );
            },
            icon: const Icon(Icons.sports_cricket),
            label: const Text('🏏 DIRECT IPL METHOD'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
            ),
          ),
          
          const SizedBox(height: 8),
          
          ElevatedButton.icon(
            onPressed: () async {
              // Nuclear test (already working)
              await NotificationService.nuclearFirebaseTest();
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('☢️ Nuclear test sent!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            icon: const Icon(Icons.warning),
            label: const Text('☢️ NUCLEAR TEST (WORKING)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red[700],
              foregroundColor: Colors.white,
            ),
          ),
          
          const SizedBox(height: 12),
          
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue[100],
              borderRadius: BorderRadius.circular(4),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '🔍 Test Results Expected:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  '• Nuclear test: Should work (already confirmed)',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  '• Direct IPL method: Should work (uses internal safe ID)',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  '• Safe ID test: Should work (ID = 12345)',
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