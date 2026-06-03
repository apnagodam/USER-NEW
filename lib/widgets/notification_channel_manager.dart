import 'package:flutter/material.dart';
import 'package:apnagodam/core/utils/notification_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class NotificationChannelManager extends StatelessWidget {
  const NotificationChannelManager({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '🔧 Notification Channel Manager',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          const Text(
            'If custom sounds aren\'t working, clear channels first:',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await NotificationService.clearAllNotificationChannels();
                    Fluttertoast.showToast(
                      msg: 'All notification channels cleared!',
                      toastLength: Toast.LENGTH_SHORT,
                      backgroundColor: Colors.orange,
                    );
                  },
                  icon: const Icon(Icons.delete_sweep),
                  label: Text(AppLocalizations.of(context)!.clearAllChannels),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await NotificationService.showIPLNotification(
                      title: 'Test IPL Sound',
                      body: 'Testing ipl_message.mp3 after clearing channels',
                    );
                    Fluttertoast.showToast(
                      msg: 'IPL notification sent!',
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  },
                  icon: const Icon(Icons.music_note),
                  label: Text(AppLocalizations.of(context)!.testIplSound),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.amber[50],
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: Colors.amber),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '💡 How to fix sound issues:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                ),
                const SizedBox(height: 4),
                const Text(
                  '1. Tap "Clear All Channels" button above',
                  style: TextStyle(fontSize: 11),
                ),
                const Text(
                  '2. Test with "Test IPL Sound" button',
                  style: TextStyle(fontSize: 11),
                ),
                const Text(
                  '3. Send Firebase message again',
                  style: TextStyle(fontSize: 11),
                ),
                const Text(
                  '4. If still not working, restart the app',
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
