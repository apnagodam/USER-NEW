import 'package:flutter/material.dart';
import 'package:apnagodam/core/utils/notification_service.dart';
import 'package:apnagodam/core/constants/notification_sounds.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationDebugger extends StatefulWidget {
  const NotificationDebugger({super.key});

  @override
  State<NotificationDebugger> createState() => _NotificationDebuggerState();
}

class _NotificationDebuggerState extends State<NotificationDebugger> {
  String _debugOutput = '';

  void _addDebugLine(String line) {
    setState(() {
      _debugOutput += '$line\n';
    });
    print('🐛 DEBUG: $line');
  }

  Future<void> _runComprehensiveTest() async {
    setState(() {
      _debugOutput = '';
    });

    _addDebugLine('🔍 Starting comprehensive notification sound test...');

    // Test 1: Check if sound constant is correct
    _addDebugLine('Test 1: Sound constants');
    _addDebugLine(
        'NotificationSounds.iplMessage = "${NotificationSounds.iplMessage}"');

    // Test 2: Clear all channels first
    _addDebugLine('Test 2: Clearing all notification channels...');
    await NotificationService.clearAllNotificationChannels();
    await Future.delayed(const Duration(seconds: 1));

    // Test 3: Test local notification with IPL sound
    _addDebugLine('Test 3: Testing local IPL notification...');
    await NotificationService.showIPLNotification(
      title: '🏏 Local IPL Test',
      body: 'This should play ipl_message sound',
    );
    await Future.delayed(const Duration(seconds: 2));

    // Test 4: Test direct custom sound notification
    _addDebugLine('Test 4: Testing direct custom sound notification...');
    await NotificationService.showCustomSoundNotification(
      id: 12345,
      title: '🔊 Direct Sound Test',
      body: 'Testing ipl_message directly',
      customSound: 'ipl_message',
    );
    await Future.delayed(const Duration(seconds: 2));

    // Test 5: Test Firebase path simulation
    _addDebugLine('Test 5: Simulating Firebase message...');
    await NotificationService.testFirebaseNotificationPath(
      title: '🔥 Firebase Simulation',
      body: 'Simulating Firebase with IPL sound',
      sound: 'ipl_message',
      type: 'ipl_message',
    );

    _addDebugLine('✅ All tests completed! Check your notifications and sound.');

    Fluttertoast.showToast(
      msg: 'Debug test completed - check console logs!',
      toastLength: Toast.LENGTH_LONG,
    );
  }

  Future<void> _testDifferentSoundFormats() async {
    _addDebugLine('🧪 Testing different sound formats...');

    final testCases = [
      'ipl_message',
      'ipl_message.mp3',
      '@raw/ipl_message',
      'android.resource://your.package.name/raw/ipl_message',
    ];

    for (int i = 0; i < testCases.length; i++) {
      final soundFormat = testCases[i];
      _addDebugLine('Testing format $i: "$soundFormat"');

      try {
        await NotificationService.showCustomSoundNotification(
          id: 50000 + i,
          title: 'Format Test ${i + 1}',
          body: 'Testing: $soundFormat',
          customSound: soundFormat,
        );
        _addDebugLine('✅ Format $i sent successfully');
      } catch (e) {
        _addDebugLine('❌ Format $i failed: $e');
      }

      await Future.delayed(const Duration(seconds: 1));
    }

    _addDebugLine('🏁 Sound format testing completed');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🐛 Notification Sound Debugger'),
        backgroundColor: Colors.red[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🚨 Notification Sound Debug Tools',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Test Buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _runComprehensiveTest,
                  icon: const Icon(Icons.bug_report),
                  label: const Text('Run Full Test'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _testDifferentSoundFormats,
                  icon: const Icon(Icons.audiotrack),
                  label: const Text('Test Sound Formats'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await NotificationService.clearAllNotificationChannels();
                    _addDebugLine('🗑️ All channels cleared');
                  },
                  icon: const Icon(Icons.clear_all),
                  label: const Text('Clear Channels'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    _addDebugLine(
                        '🧪 Testing MainActivity predefined channels...');
                    await NotificationService.testPredefinedChannels();
                    _addDebugLine('✅ Predefined channel tests sent!');
                    _addDebugLine('🎵 Check if you hear custom sounds');
                  },
                  icon: const Icon(Icons.settings_applications),
                  label: const Text('Test MainActivity Channels'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    _addDebugLine('🔥 Testing FOREGROUND notifications...');
                    await NotificationService
                        .testForegroundNotificationSounds();
                    _addDebugLine('✅ Foreground notification tests sent!');
                    _addDebugLine(
                        '🎵 These should work the same as background now');
                  },
                  icon: const Icon(Icons.notifications_active),
                  label: const Text('Test Foreground Sounds'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    _addDebugLine('🍎 Checking iOS APNS token...');
                    await NotificationService.debugAPNSToken();
                    _addDebugLine(
                        '✅ APNS check completed - see console for details');
                  },
                  icon: const Icon(Icons.phone_iphone),
                  label: const Text('Check iOS APNS'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Debug Output
            const Text(
              'Debug Output:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _debugOutput.isEmpty
                        ? 'Tap "Run Full Test" to start debugging...'
                        : _debugOutput,
                    style: const TextStyle(
                      color: Colors.green,
                      fontFamily: 'monospace',
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Instructions
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.amber),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📋 Instructions:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('1. Make sure your device volume is UP',
                      style: TextStyle(fontSize: 12)),
                  Text('2. Run "Full Test" and listen for different sounds',
                      style: TextStyle(fontSize: 12)),
                  Text('3. Check console output in IDE for error messages',
                      style: TextStyle(fontSize: 12)),
                  Text('4. If no custom sound plays, try "Test Sound Formats"',
                      style: TextStyle(fontSize: 12)),
                  Text('5. Restart app after clearing channels',
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
