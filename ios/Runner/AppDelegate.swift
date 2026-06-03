import UIKit
import Flutter
import Firebase
import GoogleMaps
import UserNotifications

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    
    // Configure Google Maps with proper API key
    GMSServices.provideAPIKey("AIzaSyDsvSi53LPj_Gdu-RyfR0r0MoaEw-HFMt4")
    
    // Configure Firebase
    FirebaseApp.configure()
    
    // Register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)
    
    // Request notification permissions
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
      
      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: { granted, error in
          print("📱 iOS Notification permission granted: \(granted)")
          if let error = error {
            print("❌ Notification permission error: \(error.localizedDescription)")
          }
        })
    } else {
      let settings: UIUserNotificationSettings =
      UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
      application.registerUserNotificationSettings(settings)
    }
    
    // Register for remote notifications
    application.registerForRemoteNotifications()
    print("📱 iOS: Registered for remote notifications")

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // Called when APNs successfully registers the app and provides the device token
  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    print("✅ iOS APNS Token registered successfully!")
    print("📱 APNS Device Token: \(deviceToken.map { String(format: "%02.2hhx", $0) }.joined())")
    
    // Pass the device token to Firebase Messaging
    Messaging.messaging().apnsToken = deviceToken
    print("🔥 APNS token passed to Firebase Messaging")
  }

  // Called when APNs fails to register the app
  override func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    print("❌ Failed to register for remote notifications: \(error.localizedDescription)")
    print("💡 APNS Registration Failed - Troubleshooting Guide:")
    print("   🔍 Error Details: \(error)")
    
    if error.localizedDescription.contains("aps-environment") {
      print("   🎯 ENTITLEMENTS ISSUE DETECTED!")
      print("   📝 Solution Steps:")
      print("      1. Open ios/Runner.xcworkspace in Xcode")
      print("      2. Select 'Runner' target")
      print("      3. Go to 'Signing & Capabilities' tab")
      print("      4. Click '+' and add 'Push Notifications' capability")
      print("      5. Verify entitlements file path:")
      print("         Debug: Runner/Runner.entitlements")
      print("         Release: Runner/Release.entitlements")
      print("      6. Clean and rebuild")
    } else {
      print("   • Running on iOS Simulator? (APNS doesn't work on simulator)")
      print("   • Missing Apple Developer account?")
      print("   • Incorrect code signing?")
      print("   • Check Xcode project capabilities")
    }
    print("   ⚠️  Remember: APNS only works on REAL iOS devices!")
  }
  
  // Handle notification received in foreground
  override func userNotificationCenter(_ center: UNUserNotificationCenter,
                                     willPresent notification: UNNotification,
                                     withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    print("📱 iOS: Notification received in foreground")
    completionHandler([[.alert, .sound, .badge]])
  }
}
