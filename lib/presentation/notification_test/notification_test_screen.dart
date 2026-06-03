import 'package:flutter/material.dart';
import 'package:apnagodam/core/utils/notification_service.dart';
import 'package:apnagodam/core/constants/notification_sounds.dart';

class NotificationTestScreen extends StatefulWidget {
  const NotificationTestScreen({super.key});

  @override
  State<NotificationTestScreen> createState() => _NotificationTestScreenState();
}

class _NotificationTestScreenState extends State<NotificationTestScreen> {
  String selectedSound = NotificationSounds.defaultSound;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = 'Test Notification';
    bodyController.text = 'This is a test notification with custom sound';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Sound Test'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Test Custom Notification Sounds',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // Title input
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Notification Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Body input
            TextField(
              controller: bodyController,
              decoration: const InputDecoration(
                labelText: 'Notification Body',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),

            // Sound selection
            const Text(
              'Select Notification Sound:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            DropdownButtonFormField<String>(
              value: selectedSound,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Sound',
              ),
              items: NotificationSounds.getSoundDisplayNames()
                  .entries
                  .map((entry) => DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedSound = newValue;
                  });
                }
              },
            ),
            const SizedBox(height: 24),

            // Test buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showTestNotification();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Test Notification',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showDefaultNotification();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    child: const Text(
                      'Default Sound',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Quick test buttons for different sound types
            const Text(
              'Quick Test Sounds:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildQuickTestButton(
                    'Order Alert', NotificationSounds.orderSound),
                _buildQuickTestButton(
                    'Message', NotificationSounds.messageSound),
                _buildQuickTestButton('Urgent', NotificationSounds.urgentSound),
                _buildQuickTestButton('Success', NotificationSounds.success),
                _buildQuickTestButton('Warning', NotificationSounds.warning),
                _buildQuickTestButton(
                    'Price Alert', NotificationSounds.priceAlert),
              ],
            ),

            const SizedBox(height: 24),

            // Instructions
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'How to add custom sounds:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Android:'),
                  Text(
                      '• Add .mp3/.wav files to android/app/src/main/res/raw/'),
                  Text(
                      '• File names should use lowercase and underscores only'),
                  SizedBox(height: 8),
                  Text('iOS:'),
                  Text('• Add .aiff/.wav files to ios/Runner/Resources/'),
                  Text('• Add files to iOS project bundle in Xcode'),
                  SizedBox(height: 8),
                  Text('• Sounds should be short (1-3 seconds)'),
                  Text('• Test on both platforms after adding sounds'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickTestButton(String label, String sound) {
    return ElevatedButton(
      onPressed: () {
        NotificationService.showCustomSoundNotification(
          id: DateTime.now().millisecondsSinceEpoch,
          title: label,
          body: 'Testing $label sound',
          customSound: sound.isEmpty ? null : sound,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      child: Text(label),
    );
  }

  void _showTestNotification() {
    NotificationService.showCustomSoundNotification(
      id: DateTime.now().millisecondsSinceEpoch,
      title: titleController.text,
      body: bodyController.text,
      customSound: selectedSound.isEmpty ? null : selectedSound,
      payload: 'test_notification_payload',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(selectedSound.isEmpty
            ? 'Notification sent with default sound'
            : 'Notification sent with sound: $selectedSound'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showDefaultNotification() {
    NotificationService.showDefaultNotification(
      id: DateTime.now().millisecondsSinceEpoch,
      title: titleController.text,
      body: bodyController.text,
      payload: 'default_notification_payload',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Default notification sent'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    bodyController.dispose();
    super.dispose();
  }
}
