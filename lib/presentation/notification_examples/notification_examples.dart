import 'package:flutter/material.dart';
import 'package:apnagodam/core/utils/notification_service.dart';
import 'package:apnagodam/core/constants/notification_sounds.dart';

/// Example widget showing how to use custom notification sounds
class NotificationExamples extends StatelessWidget {
  const NotificationExamples({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Examples'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Notification Sound Examples',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Order Notifications
            _buildSectionTitle('Order Notifications'),
            _buildNotificationButton(
              'Order Received',
              'New order #12345 has been received',
              () => NotificationService.showOrderNotification(
                orderType: 'received',
                title: 'Order Received',
                body: 'New order #12345 has been received',
                orderId: 'order_12345',
              ),
              Colors.blue,
            ),
            _buildNotificationButton(
              'Order Confirmed',
              'Order #12345 has been confirmed',
              () => NotificationService.showOrderNotification(
                orderType: 'confirmed',
                title: 'Order Confirmed',
                body: 'Order #12345 has been confirmed',
                orderId: 'order_12345',
              ),
              Colors.green,
            ),
            _buildNotificationButton(
              'Order Delivered',
              'Order #12345 has been delivered',
              () => NotificationService.showOrderNotification(
                orderType: 'delivered',
                title: 'Order Delivered',
                body: 'Order #12345 has been delivered',
                orderId: 'order_12345',
              ),
              Colors.purple,
            ),

            const SizedBox(height: 20),

            // Market Notifications
            _buildSectionTitle('Market Notifications'),
            _buildNotificationButton(
              'Price Alert',
              'Wheat price increased by 5%',
              () => NotificationService.showMarketNotification(
                title: 'Price Alert',
                body: 'Wheat price increased by 5%',
                isPriceAlert: true,
                payload: 'price_alert_wheat',
              ),
              Colors.orange,
            ),
            _buildNotificationButton(
              'Market Update',
              'Daily market report is available',
              () => NotificationService.showMarketNotification(
                title: 'Market Update',
                body: 'Daily market report is available',
                isPriceAlert: false,
                payload: 'market_report',
              ),
              Colors.teal,
            ),

            const SizedBox(height: 20),

            // Special Notifications
            _buildSectionTitle('Special Notifications'),
            _buildNotificationButton(
              'Urgent Alert',
              'Immediate attention required!',
              () => NotificationService.showUrgentNotification(
                title: 'Urgent Alert',
                body: 'Immediate attention required!',
                payload: 'urgent_alert',
              ),
              Colors.red,
            ),
            _buildNotificationButton(
              'Custom Sound',
              'Test with custom sound',
              () => NotificationService.showCustomSoundNotification(
                id: DateTime.now().millisecondsSinceEpoch,
                title: 'Custom Sound Test',
                body: 'This notification uses a custom sound',
                customSound: NotificationSounds.customAlert,
                payload: 'custom_test',
              ),
              Colors.indigo,
            ),

            const Spacer(),

            // Clear notifications button
            ElevatedButton(
              onPressed: () {
                NotificationService.cancelAllNotifications();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All notifications cleared'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: const Text(
                'Clear All Notifications',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget _buildNotificationButton(
    String title,
    String subtitle,
    VoidCallback onPressed,
    Color color,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
