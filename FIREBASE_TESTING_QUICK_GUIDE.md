# 🔥 Quick Firebase Console Testing Guide

## 📱 **Step 1: Get Your FCM Token**

Add this to any screen in your app:
```dart
ElevatedButton(
  onPressed: () {
    NotificationService.printFCMTokenForTesting();
  },
  child: Text('Print FCM Token'),
)
```

Or use the Firebase Testing Widget:
```dart
// Navigate to the testing screen
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => const FirebaseTestingWidget(),
  ),
);
```

## 🚀 **Step 2: Firebase Console Setup**

1. **Go to Firebase Console**: https://console.firebase.google.com
2. **Select your project**
3. **Go to Messaging** (left sidebar)
4. **Click "Send your first message"** or **"New Campaign"**

## 📝 **Step 3: Create Test Message**

### **Basic Setup:**
- **Notification title**: "Test IPL Sound"
- **Notification text**: "Testing your ipl_message.mp3"

### **Target:**
- Click **"Send test message"**
- Paste your **FCM Token**
- Click **"Test"**

## 🎵 **Step 4: Test Your Custom Sounds**

### **Test IPL Message Sound:**
**Additional Options > Custom Data:**
```
Key: type
Value: ipl_message
```

### **Test Other Sounds:**
```
Key: type, Value: order_received     (Order sound)
Key: type, Value: urgent            (Urgent sound)  
Key: type, Value: price_alert       (Price alert)
Key: sound, Value: ipl_message      (Direct sound)
```

## 🧪 **Step 5: Complete Test Examples**

### **Example 1: IPL Match Alert**
**Notification:**
```
Title: 🏏 Match Alert
Text: Mumbai Indians vs Chennai Super Kings
```
**Custom Data:**
```
type: ipl_message
match: MI vs CSK
payload: match_123
```

### **Example 2: Order Notification**
**Notification:**
```
Title: Order Received  
Text: Your order #12345 is confirmed
```
**Custom Data:**
```
type: order_received
order_id: 12345
payload: order_update
```

### **Example 3: Urgent Alert**
**Notification:**
```
Title: ⚠️ Urgent Alert
Text: Immediate attention required
```
**Custom Data:**
```
type: urgent
priority: high
payload: urgent_action
```

## ✅ **Quick Testing Checklist**

- [ ] App is running (foreground or background)
- [ ] FCM token copied from debug console
- [ ] `ipl_message.mp3` in `android/app/src/main/res/raw/`
- [ ] Notification permissions granted
- [ ] Device volume is up
- [ ] Testing on physical device (not emulator)

## 🎯 **Expected Results**

When you send the test message:
1. ✅ Notification appears on device
2. ✅ Your custom sound plays (`ipl_message.mp3`)
3. ✅ Debug console shows: "Showed notification: [title] with sound: [sound_name]"
4. ✅ Tapping notification triggers your app's notification handler

## 🐛 **Troubleshooting**

**Sound not playing?**
- Check file exists: `android/app/src/main/res/raw/ipl_message.mp3`
- Verify filename (no spaces, lowercase)
- Test device volume
- Try on physical device

**Notification not received?**
- Verify FCM token is current
- Check notification permissions
- Test with app in foreground first

**Wrong sound?**
- Check `type` value in custom data
- Verify sound mapping in code
- Check debug logs

## 🚀 **Ready to Test!**

1. **Run your app**
2. **Get FCM token** (using the button or debug console)
3. **Go to Firebase Console > Messaging**
4. **Send test message** with custom data
5. **Hear your custom sound!** 🎵

Your `ipl_message.mp3` is ready for Firebase Console testing! 🔔🏏