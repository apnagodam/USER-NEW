import 'package:flutter/material.dart';
import 'package:apnagodam/core/utils/notification_service.dart';

class APNSDebugWidget extends StatefulWidget {
  const APNSDebugWidget({super.key});

  @override
  State<APNSDebugWidget> createState() => _APNSDebugWidgetState();
}

class _APNSDebugWidgetState extends State<APNSDebugWidget> {
  String _debugOutput = '';

  void _addDebugLine(String line) {
    setState(() {
      _debugOutput += '$line\n';
    });
    print('🍎 APNS DEBUG: $line');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🍎 iOS APNS Debug'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Warning about simulator
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.orange),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '⚠️ IMPORTANT:',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.orange),
                  ),
                  SizedBox(height: 4),
                  Text('• APNS tokens ONLY work on real iOS devices',
                      style: TextStyle(fontSize: 12)),
                  Text('• iOS Simulator will ALWAYS return null APNS token',
                      style: TextStyle(fontSize: 12)),
                  Text('• You need a valid Apple Developer account',
                      style: TextStyle(fontSize: 12)),
                  Text('• App must be properly code-signed',
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Test Buttons
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    _addDebugLine('🔍 Checking APNS Token...');
                    await NotificationService.debugAPNSToken();
                    _addDebugLine('✅ APNS Token check completed');
                  },
                  icon: const Icon(Icons.fingerprint),
                  label: const Text('Check APNS Token'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    _addDebugLine('📱 Testing iOS notification...');
                    await NotificationService.testIOSNotification();
                    _addDebugLine('✅ iOS notification test sent');
                  },
                  icon: const Icon(Icons.notifications_active),
                  label: const Text('Test iOS Notification'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    setState(() {
                      _debugOutput = '';
                    });
                  },
                  icon: const Icon(Icons.clear),
                  label: const Text('Clear Output'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
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
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey),
                ),
                child: SingleChildScrollView(
                  child: Text(
                    _debugOutput.isEmpty
                        ? 'Tap "Check APNS Token" to start debugging...\n\nRemember: APNS tokens only work on real iOS devices!'
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
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.blue),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '📋 Steps to Fix APNS Token Issues:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text('1. Use a REAL iOS device (not simulator)',
                      style: TextStyle(fontSize: 12)),
                  Text('2. Ensure valid Apple Developer account',
                      style: TextStyle(fontSize: 12)),
                  Text('3. Check code signing in Xcode',
                      style: TextStyle(fontSize: 12)),
                  Text('4. Verify Runner.entitlements file exists',
                      style: TextStyle(fontSize: 12)),
                  Text(
                      '5. Clean and rebuild: flutter clean && cd ios && pod install',
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
