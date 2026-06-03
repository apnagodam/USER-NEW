# Testing Custom Notification Sounds from Firebase Console

Here's a complete guide to test your custom notification sounds (including your `ipl_message.mp3`) directly from the Firebase Console.

## 🚀 **Step-by-Step Firebase Console Testing**

### **Step 1: Get Your FCM Token**

First, add this method to get your device's FCM token for testing:

```dart
// Add this method to your NotificationService or any widget
static void printFCMToken() {
  debugPrint('FCM Token for testing: ${NotificationService.fcmToken}');
  // Also print to console for easy copying
  print('FCM Token: ${NotificationService.fcmToken}');
}
```

Run this in your app to get the token, then copy it for Firebase Console testing.

### **Step 2: Access Firebase Console**

1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project
3. Navigate to **Messaging** in the left sidebar
4. Click **"Send your first message"** or **"New Campaign"**

### **Step 3: Basic Message Setup**

**Notification Tab:**
- **Notification title**: "Test IPL Sound"
- **Notification text**: "Testing your custom ipl_message.mp3 sound"
- **Notification image**: (optional)

### **Step 4: Target Your Device**

**Target Tab:**
- Select **"Send test message"**
- Paste your **FCM Token** (from Step 1)
- Click **"Test"**

### **Step 5: Test Different Custom Sounds**

To test your custom sounds, you need to add **Additional Options**:

#### **Option A: Test IPL Message Sound**
**Additional Options > Custom Data:**
```
Key: type
Value: ipl_message
```

#### **Option B: Test with Direct Sound**
**Additional Options > Custom Data:**
```
Key: sound  
Value: ipl_message
```

#### **Option C: Test Other Sound Types**
```
Key: type
Value: order_received
```
```
Key: type
Value: urgent
```
```
Key: type
Value: price_alert
```

### **Step 6: Advanced Testing Scenarios**

#### **Test 1: IPL Notification with Payload**
**Custom Data:**
```
type: ipl_message
payload: match_123
match_id: mumbai_vs_chennai
```

#### **Test 2: Order Notification**
**Custom Data:**
```
type: order_received
order_id: order_12345
payload: order_notification
```

#### **Test 3: Market Alert**
**Custom Data:**
```
type: price_alert
commodity: wheat
price_change: +5%
payload: price_wheat
```

#### **Test 4: Urgent Notification**
**Custom Data:**
```
type: urgent
priority: high
payload: urgent_alert
```

## 📱 **Testing from Firebase Console - Complete Example**

### **Firebase Console Message Configuration:**

**Notification:**
```
Title: IPL Match Alert
Text: Mumbai Indians vs Chennai Super Kings - Live Now!
```

**Target:**
```
FCM Registration Token: [Your device token]
```

**Additional Options > Custom Data:**
```
type: ipl_message
match_teams: MI vs CSK
match_status: live
payload: match_live_123
```

**Additional Options > Advanced Options:**
```
Android Notification Channel: high_importance_channel
```

## 🔧 **Quick Testing Methods**

### **Method 1: Quick Test Button (Add to your app)**

```dart
ElevatedButton(
  onPressed: () {
    // Print FCM token for Firebase Console testing
    debugPrint('FCM Token: ${NotificationService.fcmToken}');
    
    // Also show in a dialog for easy copying
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('FCM Token for Testing'),
        content: SelectableText(
          NotificationService.fcmToken ?? 'Token not available',
          style: TextStyle(fontSize: 12),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  },
  child: Text('Get FCM Token for Testing'),
)
```

### **Method 2: Test Different Sound Types**

Create test buttons for each sound type:

```dart
// Test IPL Sound
ElevatedButton(
  onPressed: () async {
    await NotificationService.showIPLNotification(
      title: 'Test IPL Sound',
      body: 'This should play ipl_message.mp3',
    );
  },
  child: Text('Test IPL Sound'),
)

// Test Order Sound  
ElevatedButton(
  onPressed: () async {
    await NotificationService.showOrderNotification(
      orderType: 'received',
      title: 'Test Order Sound',
      body: 'New order received',
    );
  },
  child: Text('Test Order Sound'),
)
```

## 📋 **Firebase Console Testing Checklist**

### ✅ **Before Testing:**
- [ ] App is running and in background/foreground
- [ ] FCM token is copied from debug console
- [ ] `ipl_message.mp3` is in `android/app/src/main/res/raw/`
- [ ] Notification permissions are granted

### ✅ **Test These Scenarios:**
- [ ] Default notification (no custom data)
- [ ] IPL sound (`type: ipl_message`)
- [ ] Direct sound (`sound: ipl_message`)
- [ ] Order sound (`type: order_received`)
- [ ] Urgent sound (`type: urgent`)
- [ ] Price alert (`type: price_alert`)

### ✅ **Verify Results:**
- [ ] Notification appears
- [ ] Correct sound plays
- [ ] Payload data is received (check debug logs)
- [ ] Notification click handling works

## 🐛 **Troubleshooting**

### **Sound Not Playing?**
1. Check if `ipl_message.mp3` exists in `android/app/src/main/res/raw/`
2. Verify filename has no spaces or special characters
3. Test with device volume up
4. Try on physical device (not emulator)

### **Notification Not Received?**
1. Verify FCM token is correct
2. Check if app has notification permissions
3. Test with app in foreground first
4. Check Firebase Console for delivery status

### **Wrong Sound Playing?**
1. Check the `type` value in custom data
2. Verify the sound mapping in `_getNotificationSound` method
3. Check debug logs for sound selection

## 🎯 **Example Firebase Console Messages**

### **Example 1: IPL Alert**
```json
{
  "notification": {
    "title": "🏏 IPL Live",
    "body": "MI vs CSK - Over 19.5, Need 12 runs!"
  },
  "data": {
    "type": "ipl_message",
    "match_id": "mi_vs_csk_2025",
    "payload": "live_score"
  }
}
```

### **Example 2: Order Update**
```json
{
  "notification": {
    "title": "Order Confirmed",
    "body": "Your order #12345 has been confirmed"
  },
  "data": {
    "type": "order_confirmed", 
    "order_id": "12345",
    "payload": "order_update"
  }
}
```

### **Example 3: Price Alert**
```json
{
  "notification": {
    "title": "Price Alert",
    "body": "Wheat price increased by 8%"
  },
  "data": {
    "type": "price_alert",
    "commodity": "wheat",
    "change": "+8%",
    "payload": "price_wheat"
  }
}
```

Now you can test all your custom notification sounds directly from Firebase Console! 🔔✨