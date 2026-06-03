## Updated Notification Service - Usage Guide

Your `NotificationService` has been enhanced with comprehensive custom sound support. Here's how to use it effectively in your app:

## Key Features Added:

### ✅ **Automatic Sound Detection**
- The service now automatically detects notification types from Firebase messages
- Maps notification types to appropriate sounds
- Falls back to custom alert sound for unknown types

### ✅ **Enhanced Methods**
- `showCustomSoundNotification()` - For notifications with specific sounds
- `showOrderNotification()` - Specialized for order-related notifications
- `showMarketNotification()` - For market and price alerts
- `showUrgentNotification()` - For urgent/emergency notifications
- `cancelNotification()` - Cancel specific notification
- `cancelAllNotifications()` - Clear all notifications

### ✅ **Improved Error Handling**
- Graceful fallbacks when custom sounds fail
- Better logging for debugging
- Safe notification display with error recovery

## How to Use in Your App:

### 1. **Order Notifications**
```dart
// When an order is received
await NotificationService.showOrderNotification(
  orderType: 'received',
  title: 'New Order',
  body: 'Order #${orderId} has been received',
  orderId: orderId,
);

// When an order is confirmed
await NotificationService.showOrderNotification(
  orderType: 'confirmed',
  title: 'Order Confirmed',
  body: 'Your order is being prepared',
  orderId: orderId,
);

// When an order is delivered
await NotificationService.showOrderNotification(
  orderType: 'delivered',
  title: 'Order Delivered',
  body: 'Your order has been delivered successfully',
  orderId: orderId,
);
```

### 2. **Market & Price Notifications**
```dart
// Price alerts
await NotificationService.showMarketNotification(
  title: 'Price Alert',
  body: 'Wheat price increased by 5%',
  isPriceAlert: true,
  payload: 'price_alert_wheat',
);

// Market updates
await NotificationService.showMarketNotification(
  title: 'Market Update',
  body: 'Daily market report is now available',
  isPriceAlert: false,
  payload: 'market_report',
);
```

### 3. **Urgent Notifications**
```dart
// Emergency or urgent notifications
await NotificationService.showUrgentNotification(
  title: 'Urgent: Action Required',
  body: 'Your immediate attention is needed',
  payload: 'urgent_action',
);
```

### 4. **Custom Sound Notifications**
```dart
// Any notification with specific sound
await NotificationService.showCustomSoundNotification(
  id: DateTime.now().millisecondsSinceEpoch,
  title: 'Custom Notification',
  body: 'This has a custom sound',
  customSound: NotificationSounds.success,
  payload: 'custom_payload',
);
```

### 5. **Firebase Push Notifications**
Your server can now send notifications with automatic sound detection:

```json
{
  "notification": {
    "title": "Order Update",
    "body": "Your order status has changed"
  },
  "data": {
    "type": "order_confirmed",
    "order_id": "12345",
    "payload": "order_payload"
  }
}
```

The service will automatically use `NotificationSounds.orderConfirmed` sound.

### 6. **Integration with Existing Code**

Replace your existing notification calls:

**Before:**
```dart
// Old way
_flutterLocalNotificationsPlugin.show(id, title, body, details);
```

**After:**
```dart
// New way with automatic sound selection
await NotificationService.showCustomSoundNotification(
  id: id,
  title: title,
  body: body,
  customSound: NotificationSounds.orderSound, // or appropriate sound
);
```

## Firebase Message Types Supported:

The service automatically detects these types from `message.data['type']`:

- `order` → Order sound
- `order_received` → Order received sound
- `order_confirmed` → Order confirmed sound
- `order_delivered` → Order delivered sound
- `message` / `chat` → Message sound
- `price_alert` / `market_update` → Price alert sound
- `urgent` / `emergency` → Urgent sound
- `success` → Success sound
- `warning` → Warning sound
- `error` → Error sound

## Testing Your Notifications:

1. **Use the Example Screen:**
```dart
import 'package:apnagodam/presentation/notification_examples/notification_examples.dart';

// Navigate to test all notification types
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const NotificationExamples()),
);
```

2. **Test Firebase Notifications:**
   - Send test messages from Firebase Console
   - Include `type` in the data payload
   - Monitor debug logs for sound selection

3. **Debug Mode:**
   - Check console logs for notification details
   - Verify sound file names match your assets
   - Test on both Android and iOS devices

## Common Integration Points:

### In Order Processing:
```dart
// When order status changes
void updateOrderStatus(String orderId, String status) {
  // ... your existing code ...
  
  // Add notification
  NotificationService.showOrderNotification(
    orderType: status.toLowerCase(),
    title: 'Order Update',
    body: 'Order #$orderId is now $status',
    orderId: orderId,
  );
}
```

### In Market Data Updates:
```dart
// When price changes significantly
void onPriceAlert(String commodity, double changePercent) {
  // ... your existing code ...
  
  // Add notification
  NotificationService.showMarketNotification(
    title: 'Price Alert',
    body: '$commodity price changed by ${changePercent.toStringAsFixed(1)}%',
    isPriceAlert: true,
    payload: 'price_$commodity',
  );
}
```

### In WebSocket/Socket.IO Handlers:
```dart
// When receiving real-time updates
socket.on('order_update', (data) {
  // ... handle data ...
  
  // Show notification
  NotificationService.showOrderNotification(
    orderType: data['status'],
    title: 'Real-time Update',
    body: data['message'],
    orderId: data['order_id'],
  );
});
```

Your notification system is now ready for production use with comprehensive sound support! 🔔✨