import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class UltimateSoundTest extends StatefulWidget {
  const UltimateSoundTest({super.key});

  @override
  State<UltimateSoundTest> createState() => _UltimateSoundTestState();
}

class _UltimateSoundTestState extends State<UltimateSoundTest> {
  String _testResults = '';

  void _addResult(String result) {
    setState(() {
      _testResults += '$result\n';
    });
    print('🧪 TEST: $result');
  }

  Future<void> _runUltimateTest() async {
    setState(() {
      _testResults = '';
    });

    _addResult('🔬 Starting ultimate sound file test...');

    // Test 1: Direct flutter_local_notifications call with minimal setup
    _addResult('Test 1: Raw flutter_local_notifications call');

    try {
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      // Create a very simple channel
      const simpleChannel = AndroidNotificationChannel(
        'test_raw_channel',
        'Test Raw Channel',
        description: 'Testing raw notification',
        importance: Importance.max,
      );

      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(simpleChannel);

      _addResult('✅ Test 1: Simple channel created');

      // Show notification with raw sound
      await flutterLocalNotificationsPlugin.show(
        99999,
        'Raw Test',
        'Testing raw notification',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'test_raw_channel',
            'Test Raw Channel',
            channelDescription: 'Testing raw notification',
            icon: 'ic_stat_notify',
            sound: RawResourceAndroidNotificationSound('ipl_message'),
            playSound: true,
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );

      _addResult('✅ Test 1: Raw notification sent');
    } catch (e) {
      _addResult('❌ Test 1 failed: $e');
    }

    await Future.delayed(const Duration(seconds: 2));

    // Test 2: Test with default notification sound
    _addResult('Test 2: Default sound test');

    try {
      final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      await flutterLocalNotificationsPlugin.show(
        99998,
        'Default Sound Test',
        'This should use default sound',
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'test_raw_channel',
            'Test Raw Channel',
            icon: 'ic_stat_notify',
            importance: Importance.max,
            priority: Priority.high,
          ),
        ),
      );

      _addResult('✅ Test 2: Default sound notification sent');
    } catch (e) {
      _addResult('❌ Test 2 failed: $e');
    }

    await Future.delayed(const Duration(seconds: 2));

    // Test 3: Test with different sound file names
    _addResult('Test 3: Testing different sound names');

    final soundNames = ['ipl_message', 'notification', 'default'];

    for (int i = 0; i < soundNames.length; i++) {
      final soundName = soundNames[i];
      _addResult('Testing sound: $soundName');

      try {
        final flutterLocalNotificationsPlugin =
            FlutterLocalNotificationsPlugin();

        await flutterLocalNotificationsPlugin.show(
          99990 + i,
          'Sound Test ${i + 1}',
          'Testing: $soundName',
          NotificationDetails(
            android: AndroidNotificationDetails(
              'test_raw_channel',
              'Test Raw Channel',
              icon: 'ic_stat_notify',
              sound: RawResourceAndroidNotificationSound(soundName),
              playSound: true,
              importance: Importance.max,
              priority: Priority.high,
            ),
          ),
        );

        _addResult('✅ Sound $soundName: notification sent');
      } catch (e) {
        _addResult('❌ Sound $soundName failed: $e');
      }

      await Future.delayed(const Duration(seconds: 1));
    }

    _addResult('🏁 Ultimate test completed!');
    _addResult('📋 Check which notifications played sound');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🔬 Ultimate Sound Test'),
        backgroundColor: Colors.purple[700],
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🔬 Ultimate Sound File Test',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'This bypasses all our custom logic and tests flutter_local_notifications directly',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: _runUltimateTest,
              icon: const Icon(Icons.science),
              label: const Text('🔬 RUN ULTIMATE TEST'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple[700],
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Test Results:',
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
                    _testResults.isEmpty
                        ? 'Tap "RUN ULTIMATE TEST" to start...'
                        : _testResults,
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
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.purple[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.purple),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '🎯 What this test does:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('• Bypasses all NotificationService logic',
                      style: TextStyle(fontSize: 12)),
                  Text('• Tests flutter_local_notifications directly',
                      style: TextStyle(fontSize: 12)),
                  Text('• Tests if ipl_message.mp3 file is accessible',
                      style: TextStyle(fontSize: 12)),
                  Text('• Compares with default sound',
                      style: TextStyle(fontSize: 12)),
                  Text('• Identifies if issue is file vs code vs system',
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
