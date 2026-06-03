## How to Use Your ipl_message.mp3 Sound

Great! You've added `ipl_message.mp3` to the `android/app/src/main/res/raw/` folder. Here's how to use it:

## 1. **Direct Usage with Custom Sound Notification**

```dart
import 'package:apnagodam/core/utils/notification_service.dart';
import 'package:apnagodam/core/constants/notification_sounds.dart';

// Use your IPL message sound directly
await NotificationService.showCustomSoundNotification(
  id: DateTime.now().millisecondsSinceEpoch,
  title: 'IPL Update',
  body: 'Match starting in 10 minutes!',
  customSound: NotificationSounds.iplMessage, // This uses your ipl_message.mp3
  payload: 'ipl_update',
);
```

## 2. **Firebase Push Notifications**

From your server, send notifications with the sound parameter:

```json
{
  "notification": {
    "title": "IPL Match Alert",
    "body": "Your favorite team is playing now!"
  },
  "data": {
    "sound": "ipl_message",
    "type": "ipl_message",
    "payload": "match_alert"
  }
}
```

The service will automatically use your `ipl_message.mp3` sound when:
- `data.sound` is set to `"ipl_message"`
- OR `data.type` is `"ipl_message"`, `"ipl"`, or `"sports"`

## 3. **Create a Dedicated IPL Notification Method**

Add this method to your `NotificationService`:

```dart
/// Show IPL-related notification with IPL sound
static Future<void> showIPLNotification({
  required String title,
  required String body,
  String? payload,
}) async {
  await showCustomSoundNotification(
    id: DateTime.now().millisecondsSinceEpoch,
    title: title,
    body: body,
    customSound: NotificationSounds.iplMessage,
    payload: payload ?? 'ipl_notification',
  );
}
```

Then use it anywhere in your app:

```dart
// Show IPL notification
await NotificationService.showIPLNotification(
  title: 'Match Started!',
  body: 'Mumbai Indians vs Chennai Super Kings',
  payload: 'match_123',
);
```

## 4. **Test Your Sound**

You can test it immediately by running this code anywhere in your app:

```dart
// Test your IPL sound
await NotificationService.showCustomSoundNotification(
  id: 1,
  title: 'Testing IPL Sound',
  body: 'This notification should play your ipl_message.mp3',
  customSound: NotificationSounds.iplMessage,
);
```

## 5. **For iOS**

Don't forget to add the iOS version! You'll need to:
1. Convert your `ipl_message.mp3` to `ipl_message.aiff` format
2. Add it to `ios/Runner/Resources/`
3. Add the file to your iOS project in Xcode

## 6. **Update Your Test Screen**

Add your IPL sound to the test screen by adding this button:

```dart
_buildQuickTestButton('IPL Message', NotificationSounds.iplMessage),
```

## 7. **Integration Examples**

### In a Sports/IPL Section:
```dart
void notifyMatchStart(String team1, String team2) {
  NotificationService.showCustomSoundNotification(
    id: DateTime.now().millisecondsSinceEpoch,
    title: 'Match Started!',
    body: '$team1 vs $team2 - Live Now!',
    customSound: NotificationSounds.iplMessage,
    payload: 'match_live',
  );
}
```

### In WebSocket/Socket.IO Handler:
```dart
socket.on('ipl_update', (data) {
  NotificationService.showCustomSoundNotification(
    id: DateTime.now().millisecondsSinceEpoch,
    title: data['title'],
    body: data['message'],
    customSound: NotificationSounds.iplMessage,
    payload: data['match_id'],
  );
});
```

Your `ipl_message.mp3` sound is now ready to use! 🏏🔔