import 'package:flutter/material.dart';
import 'package:apnagodam/core/utils/notification_service.dart';

class QuickSoundTest extends StatelessWidget {
  const QuickSoundTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '🚨 EMERGENCY SOUND TEST',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.red,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This will force create a new channel each time to bypass Android caching',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12),
          ElevatedButton.icon(
            onPressed: () async {
              // Test with the forced approach
              await NotificationService.showCustomSoundNotification(
                id: DateTime.now().millisecondsSinceEpoch,
                title: '🚨 FORCED IPL SOUND TEST',
                body: 'This uses forced channel creation - you SHOULD hear ipl_message.mp3!',
                customSound: 'ipl_message',
              );
              
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('🎵 Forced sound test sent! Check if you hear the IPL sound.'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            icon: const Icon(Icons.volume_up),
            label: const Text('🚨 FORCE TEST IPL SOUND'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            '💡 If this doesn\'t work, the sound file might not be properly placed',
            style: TextStyle(fontSize: 10, color: Colors.grey),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}