# Custom Notification Sounds Documentation

This document explains how to implement and use custom notification sounds in your Flutter app.

## Overview

The app supports custom notification sounds for different types of notifications. You can use different sounds for orders, messages, alerts, and other notification types.

## Implementation

### 1. NotificationService
The `NotificationService` class handles all notification functionality including custom sounds.

### 2. NotificationSounds Constants
The `NotificationSounds` class contains predefined sound constants for different notification types.

### 3. Platform-Specific Sound Files

#### Android
- **Location**: `android/app/src/main/res/raw/`
- **Supported formats**: `.mp3`, `.wav`, `.ogg`
- **Naming**: Use lowercase letters and underscores only (no spaces or special characters)
- **Reference**: Use filename without extension in code

#### iOS
- **Location**: `ios/Runner/Resources/`
- **Supported formats**: `.aiff`, `.wav`, `.caf`
- **Naming**: Use lowercase letters and underscores
- **Reference**: Use full filename including extension in code
- **Note**: Files must be added to the iOS project bundle in Xcode

## Usage Examples

### 1. Show Notification with Custom Sound
```dart
import 'package:apnagodam/core/utils/notification_service.dart';
import 'package:apnagodam/core/constants/notification_sounds.dart';

// Show notification with custom sound
await NotificationService.showCustomSoundNotification(
  id: 1,
  title: 'Order Received',
  body: 'Your order has been received and is being processed',
  customSound: NotificationSounds.orderReceived,
  payload: 'order_123',
);
```

### 2. Show Notification with Default Sound
```dart
// Show notification with default system sound
await NotificationService.showDefaultNotification(
  id: 2,
  title: 'Message',
  body: 'You have a new message',
  payload: 'message_456',
);
```

### 3. Firebase Push Notifications with Custom Sound
When sending push notifications from your server, include the sound parameter in the data payload:

```json
{
  "notification": {
    "title": "Order Update",
    "body": "Your order status has changed"
  },
  "data": {
    "sound": "order_confirmed",
    "order_id": "123",
    "type": "order_update"
  }
}
```

## Available Sound Types

### Order Sounds
- `orderReceived` - When a new order is placed
- `orderConfirmed` - When an order is confirmed
- `orderDelivered` - When an order is delivered

### Market Sounds
- `priceAlert` - For price change notifications
- `marketUpdate` - For market updates

### System Sounds
- `success` - For success notifications
- `warning` - For warning notifications
- `error` - For error notifications

### General Sounds
- `customAlert` - Generic custom alert sound
- `messageSound` - For message notifications
- `urgentSound` - For urgent notifications

## Adding New Sound Files

### Step 1: Prepare Sound Files
1. **Duration**: Keep sounds short (1-3 seconds)
2. **Quality**: Use moderate quality to keep file size small
3. **Format**: 
   - Android: `.mp3` or `.wav`
   - iOS: `.aiff` or `.wav`

### Step 2: Add to Android
1. Place sound files in `android/app/src/main/res/raw/`
2. Ensure filenames use lowercase and underscores only
3. Example: `custom_notification.mp3`

### Step 3: Add to iOS
1. Place sound files in `ios/Runner/Resources/`
2. Open the iOS project in Xcode
3. Add the files to the project bundle
4. Ensure they're included in the target

### Step 4: Update Constants
Add new sound constants to `NotificationSounds` class:

```dart
class NotificationSounds {
  // Add your new sound
  static const String myCustomSound = 'my_custom_sound';
  
  // Update the methods to include the new sound
  static List<String> getAllSounds() {
    return [
      // ... existing sounds
      myCustomSound,
    ];
  }
  
  static Map<String, String> getSoundDisplayNames() {
    return {
      // ... existing sounds
      myCustomSound: 'My Custom Sound',
    };
  }
}
```

## Testing

Use the `NotificationTestScreen` to test different notification sounds:

```dart
import 'package:apnagodam/presentation/notification_test/notification_test_screen.dart';

// Navigate to test screen
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => const NotificationTestScreen()),
);
```

## Troubleshooting

### Common Issues

1. **Sound not playing on Android**
   - Check if file is in `android/app/src/main/res/raw/`
   - Verify filename uses only lowercase and underscores
   - Ensure file format is supported (.mp3, .wav, .ogg)

2. **Sound not playing on iOS**
   - Check if file is added to iOS project bundle in Xcode
   - Verify file format is supported (.aiff, .wav, .caf)
   - Check if filename includes extension in code

3. **Notification not showing**
   - Verify notification permissions are granted
   - Check if notification channel is created
   - Test with a simple notification first

### Debug Tips

1. Enable debug mode in `NotificationService` to see logs
2. Test on physical devices (emulators may not play sounds properly)
3. Check device volume and notification settings
4. Verify the sound file isn't corrupted

## Best Practices

1. **File Management**
   - Keep sound files small (under 100KB)
   - Use descriptive filenames
   - Organize sounds by category

2. **User Experience**
   - Provide sound settings in your app
   - Allow users to disable custom sounds
   - Use appropriate sounds for different notification types

3. **Performance**
   - Don't bundle too many sound files
   - Consider downloading sounds from server for large apps
   - Test memory usage with multiple sounds

## Platform Differences

| Feature | Android | iOS |
|---------|---------|-----|
| File Location | `res/raw/` | Bundle Resources |
| File Formats | .mp3, .wav, .ogg | .aiff, .wav, .caf |
| Max Duration | No limit | 30 seconds |
| Reference Method | Without extension | With extension |
| Bundle Requirement | Automatic | Manual in Xcode |

## Security Considerations

1. **File Validation**
   - Validate sound files before bundling
   - Check for malicious content
   - Test on multiple devices

2. **Permissions**
   - Request notification permissions properly
   - Handle permission denials gracefully
   - Provide fallback options

This implementation provides a flexible and extensible system for custom notification sounds that works across both Android and iOS platforms.