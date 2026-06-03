# 🔧 IPL Sound Troubleshooting Guide

## ❌ **Issue: Getting Default Sound Instead of ipl_message.mp3**

Let's fix this step by step:

## ✅ **Step 1: Verify File Location**

Check that your file exists in the correct location:
```
android/app/src/main/res/raw/ipl_message.mp3
```

Run this command to verify:
```bash
ls -la android/app/src/main/res/raw/ipl_message.mp3
```

## ✅ **Step 2: Test with Debug Method**

Add this to any screen in your app:
```dart
import 'package:apnagodam/widgets/ipl_sound_test_button.dart';

// In your widget build method:
const IPLSoundTestButton()
```

Or add a simple test button:
```dart
ElevatedButton(
  onPressed: () => NotificationService.testIPLSoundDebug(),
  child: Text('Test IPL Sound'),
)
```

## ✅ **Step 3: Check Debug Console**

After pressing the test button, check your debug console for:
```
🏏 Testing IPL Sound Debug:
Sound file: ipl_message.mp3
Sound constant: ipl_message
Expected path: android/app/src/main/res/raw/ipl_message.mp3
✅ IPL sound notification sent!
```

## ✅ **Step 4: Verify Android Build**

1. **Clean and rebuild:**
```bash
flutter clean
flutter pub get
flutter run
```

2. **Check if raw folder is included in build:**
```bash
# Check if the file is in the APK
unzip -l build/app/outputs/flutter-apk/app-debug.apk | grep ipl_message
```

## ✅ **Step 5: Test Different Methods**

### **Method A: Direct String Test**
```dart
NotificationService.showCustomSoundNotification(
  id: 1,
  title: 'Direct Test',
  body: 'Testing direct string',
  customSound: 'ipl_message', // Direct string
);
```

### **Method B: Constant Test**
```dart
NotificationService.showCustomSoundNotification(
  id: 2,
  title: 'Constant Test', 
  body: 'Testing with constant',
  customSound: NotificationSounds.iplMessage, // Using constant
);
```

### **Method C: IPL Method Test**
```dart
NotificationService.showIPLNotification(
  title: 'IPL Method Test',
  body: 'Testing IPL method',
);
```

## ✅ **Step 6: Check Firebase Console Testing**

Test from Firebase Console with:
```json
{
  "notification": {
    "title": "Firebase IPL Test",
    "body": "Testing from Firebase"
  },
  "data": {
    "sound": "ipl_message"
  }
}
```

## 🐛 **Common Issues & Fixes**

### **Issue 1: File Not Found**
**Symptoms:** Getting default sound
**Fix:** 
- Check file path: `android/app/src/main/res/raw/ipl_message.mp3`
- File name must be lowercase with underscores only
- No spaces or special characters

### **Issue 2: Wrong Channel**
**Symptoms:** Sound plays but wrong one
**Fix:** 
- Notification channels cache sounds
- Uninstall and reinstall app
- Or change channel ID in code

### **Issue 3: Permissions**
**Symptoms:** No sound at all
**Fix:**
- Check notification permissions
- Check device volume
- Test on physical device (not emulator)

### **Issue 4: File Format**
**Symptoms:** Default sound plays
**Fix:**
- Ensure file is valid MP3
- Try converting to different bitrate
- Test with a different MP3 file

## 🧪 **Quick Fix: Force New Channel**

If nothing works, force create a new channel:

```dart
// Add this to NotificationService
static Future<void> forceTestIPLSound() async {
  final channel = AndroidNotificationChannel(
    'ipl_test_channel_v2', // New unique channel
    'IPL Test Channel V2',
    description: 'Force test IPL sound',
    importance: Importance.max,
    sound: RawResourceAndroidNotificationSound('ipl_message'),
  );
  
  await _flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  
  await _flutterLocalNotificationsPlugin.show(
    99999,
    '🏏 Force IPL Test',
    'This should definitely play ipl_message.mp3',
    NotificationDetails(
      android: AndroidNotificationDetails(
        channel.id,
        channel.name,
        channelDescription: channel.description,
        sound: RawResourceAndroidNotificationSound('ipl_message'),
      ),
    ),
  );
}
```

## 🎯 **Expected Result**

When working correctly, you should:
1. ✅ See notification appear
2. ✅ Hear your custom ipl_message.mp3 sound
3. ✅ See debug logs showing sound selection
4. ✅ No errors in console

## 📋 **Debug Checklist**

Run through this checklist:

- [ ] File exists: `android/app/src/main/res/raw/ipl_message.mp3`
- [ ] File name is lowercase with underscores only
- [ ] App has notification permissions
- [ ] Device volume is up
- [ ] Testing on physical device
- [ ] Tried uninstall/reinstall app
- [ ] Debug logs show correct sound selection
- [ ] Tested with direct string method
- [ ] Tested with constant method
- [ ] Tried force channel method

If you're still getting default sound after all these steps, let me know what you see in the debug console! 🔍