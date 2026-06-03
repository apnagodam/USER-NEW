# 🔥 Firebase Console - IPL Sound Testing Guide

## ❌ **Issue: Firebase notifications not using custom sound**

Since your local buttons work but Firebase doesn't, the issue is with the Firebase message format.

## ✅ **Step 1: Get Your FCM Token**

Add this button to test and get your token:
```dart
ElevatedButton(
  onPressed: () {
    NotificationService.printFCMTokenForTesting();
    print('Token: ${NotificationService.fcmToken}'); // Easy to copy from console
  },
  child: Text('Get FCM Token'),
)
```

## ✅ **Step 2: Firebase Console - CORRECT FORMAT**

### **🎯 Method A: Using `sound` parameter (Recommended)**

**Firebase Console Setup:**
1. Go to Firebase Console > Messaging
2. Click "Send test message"
3. Fill in:

**Notification:**
```
Title: IPL Sound Test
Text: Testing your ipl_message.mp3 from Firebase
```

**Target:**
```
FCM registration token: [Your token from Step 1]
```

**Additional Options > Custom Data:**
```
Key: sound
Value: ipl_message
```

### **🎯 Method B: Using `type` parameter**

**Custom Data:**
```
Key: type
Value: ipl_message
```

### **🎯 Method C: Complete Test Message**

**Custom Data (Add all of these):**
```
sound: ipl_message
type: ipl_message  
payload: firebase_test
test: true
```

## ✅ **Step 3: Alternative - Composer Method**

If "Send test message" doesn't work, use "New Campaign":

1. **Create Campaign > Notifications**
2. **Notification:**
   - Title: "IPL Test"
   - Text: "Testing custom sound"
3. **Target > User Segment:**
   - Create new segment
   - Add condition: "User in audience" > "All users"
4. **Additional Options > Custom Data:**
   ```
   sound: ipl_message
   type: ipl_message
   ```

## ✅ **Step 4: Test Different Formats**

Try these different message formats:

### **Format 1: Direct Sound**
```json
{
  "notification": {
    "title": "IPL Direct Test",
    "body": "Direct sound test"
  },
  "data": {
    "sound": "ipl_message"
  }
}
```

### **Format 2: Type-based**
```json
{
  "notification": {
    "title": "IPL Type Test", 
    "body": "Type-based sound test"
  },
  "data": {
    "type": "ipl_message"
  }
}
```

### **Format 3: Both Parameters**
```json
{
  "notification": {
    "title": "IPL Complete Test",
    "body": "Complete test with both params"
  },
  "data": {
    "sound": "ipl_message",
    "type": "ipl_message",
    "payload": "test_123"
  }
}
```

## ✅ **Step 5: Check Debug Console**

After sending Firebase message, check debug console for:

```
🔥 Firebase message received:
Title: IPL Sound Test
Body: Testing your ipl_message.mp3 from Firebase
Data: {sound: ipl_message, type: ipl_message}
🔊 Sound selection:
Selected sound: ipl_message
Use custom sound: true
Sound from data[sound]: ipl_message
Sound from data[type]: ipl_message
✅ Showed notification: IPL Sound Test with sound: ipl_message
```

## 🐛 **Common Firebase Issues**

### **Issue 1: No Custom Data**
**Problem:** Forgot to add custom data
**Fix:** Always add `sound: ipl_message` in Additional Options

### **Issue 2: Wrong Key Names**
**Problem:** Using wrong keys like `audio` or `notification_sound`
**Fix:** Use exactly `sound` or `type`

### **Issue 3: App State**
**Problem:** Firebase behaves differently when app is foreground vs background
**Fix:** Test with app in foreground first

### **Issue 4: Channel Caching**
**Problem:** Firebase creates its own channels
**Fix:** Our code handles this automatically now

## 🧪 **Debug Method - Add to Your App**

Add this button to debug Firebase messages:
```dart
ElevatedButton(
  onPressed: () {
    // This will trigger the same path as Firebase
    final fakeMessage = RemoteMessage(
      notification: RemoteNotification(
        title: 'Fake Firebase Test',
        body: 'Testing Firebase path locally',
      ),
      data: {
        'sound': 'ipl_message',
        'type': 'ipl_message',
        'payload': 'fake_test',
      },
    );
    
    NotificationService._showForegroundNotification(fakeMessage);
  },
  child: Text('Debug Firebase Path'),
)
```

## 📱 **Testing Checklist**

Before sending Firebase message:
- [ ] App is running and has notification permissions
- [ ] FCM token is current (not from previous app install)
- [ ] Added `sound: ipl_message` in Custom Data
- [ ] Testing with app in foreground first
- [ ] Debug console is open to see logs

## 🎯 **Expected Success**

When working correctly:
1. ✅ See debug logs showing Firebase message received
2. ✅ See sound selection logs showing "ipl_message"
3. ✅ Hear your custom ipl_message.mp3 sound
4. ✅ Notification appears with correct title/body

## 🚨 **Quick Fix - Manual Firebase Test**

If Firebase Console is not working, use this curl command:

```bash
curl -X POST https://fcm.googleapis.com/fcm/send \
  -H "Authorization: key=YOUR_SERVER_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "to": "YOUR_FCM_TOKEN",
    "notification": {
      "title": "IPL Curl Test",
      "body": "Testing with curl command"
    },
    "data": {
      "sound": "ipl_message",
      "type": "ipl_message"
    }
  }'
```

The key is making sure you include the `data` section with either `sound` or `type` parameters! 🔥