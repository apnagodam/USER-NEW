import 'package:apnagodam/core/constants/notification_sounds.dart';
import 'package:apnagodam/presentation/LP_list_screen/google_map_screen.dart';
import 'package:apnagodam/presentation/LP_list_screen/service/LpService.dart';
import 'package:apnagodam/presentation/dashboard/dashboard_screen.dart';
import 'package:apnagodam/presentation/market_screen/market_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class NotificationService {
  ///single instance of FCM
  static final _messaging = FirebaseMessaging.instance;

  ///To store the FCM token
  static String? _token;

  ///notification plugin initialisation
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  ///notification channel to handle android notifications
  static final AndroidNotificationChannel _androidNotificationChannel =
      AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );

  ///notification channel with custom sound for android notifications
  static final AndroidNotificationChannel _androidCustomSoundChannel =
      AndroidNotificationChannel(
    'custom_sound_channel',
    'Custom Sound Notifications',
    description: 'This channel is used for notifications with custom sounds.',
    importance: Importance.max,
  );

  /// Generate a safe notification ID that fits within 32-bit integer range
  static int _generateNotificationId() {
    // Use current time modulo to keep within 32-bit range
    // This gives us unique IDs while staying within [-2^31, 2^31 - 1]
    return (DateTime.now().millisecondsSinceEpoch % 2147483647);
  }

  ///notification channel to handle iOS notifications
  static final DarwinNotificationDetails _iOSNotificationChannel =
      DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true,
  );

  ///ask permission from the user to display notifications
  static void _requestPermission() async {
    final settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      /// User has granted the notification permission
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      /// User has only granted the provisional permission
    } else {
      /// User has discarded the permission popup or denied the notification permission
    }
  }

  ///setup the FCM token to receive notifications
  static void _getFCMToken() async {
    if (GetPlatform.isIOS) {
      _token = await _messaging.getAPNSToken();
    } else {
      _token = await _messaging.getToken();
    }

    ///onTokenRefresh stream allows us to listen to the token value whenever it changes
    _messaging.onTokenRefresh.listen((newValue) {
      _token = newValue;
    });

    debugPrint('FCM Token: $_token');
  }

  static void _configureLocalNotificationPlugin(WidgetRef ref) async {
    AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
      ),
      onDidReceiveNotificationResponse: (response) {
        final payload = response.payload?.toLowerCase();
        debugPrint("Tapped on local notification with payload: $payload");

        if (payload.toString().toLowerCase() == "wbt") {
          ref.watch(selectedTabIndex.notifier).state = 0;

          ref.watch(selectedIndex.notifier).state = 2;
        } else {
          ref.read(allBookingsProvider(status: '1').future).then((bookings) {
            if ((bookings.orders ?? []).isNotEmpty) {
              final order = bookings.orders![0];
              final shouldNavigate = (order.pricingStatus.toString() == "1" ||
                  order.weightStatus.toString() == "1");

              if (shouldNavigate) {
                Get.to(() => GooglemapScreen(
                      image: order.passportImage.toString(),
                      name: order.name.toString(),
                      lpuserId: order.lpUserId.toString(),
                    ));
              }
            }
          });
        }
        handleNotificationClick(response);
        debugPrint(response.toString());
      },
    );

    /** Update the iOS foreground notification presentation options to allow
     heads up notifications. */
    await _messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static void handleNotificationClick(NotificationResponse response) {
    Fluttertoast.showToast(msg: response.payload ?? "");
  }

  static void _createAndroidNotificationChannel() async {
    /** we have created the android notification channels which
      we had specified in the AndroidManifest.xml file earlier */
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidNotificationChannel);

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_androidCustomSoundChannel);
  }

  /// Create or get dynamic notification channel for specific sound
  static AndroidNotificationChannel _createSoundSpecificChannel(
      String soundName) {
    return AndroidNotificationChannel(
      'sound_${soundName}_channel',
      'Custom Sound - ${soundName.toUpperCase()}',
      description: 'Channel for $soundName notification sound',
      importance: Importance.max,
      // Don't set sound in channel - we'll set it in notification details instead
    );
  }

  /// Ensure sound-specific channel exists
  static Future<void> _ensureSoundChannelExists(String soundName) async {
    final channel = _createSoundSpecificChannel(soundName);

    // Force delete existing channel first to ensure sound changes take effect
    final androidPlugin =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    try {
      // Delete the channel if it exists
      await androidPlugin?.deleteNotificationChannel(channel.id);
      debugPrint('🗑️ Deleted existing channel: ${channel.id}');
    } catch (e) {
      debugPrint(
          'ℹ️ Channel ${channel.id} didn\'t exist or couldn\'t be deleted: $e');
    }

    // Create the channel with fresh sound configuration
    await androidPlugin?.createNotificationChannel(channel);
    debugPrint(
        '✅ Created notification channel: ${channel.id} with sound: $soundName');
  }

  /// Determine notification sound based on message data
  static String _getNotificationSound(RemoteMessage message) {
    // Check for explicit sound in data
    String? customSound = message.data['sound'];
    if (customSound != null && customSound.isNotEmpty) {
      // Strip file extension if present (Android raw resources don't use extensions)
      if (customSound.contains('.')) {
        customSound = customSound.split('.').first;
      }
      return customSound;
    }

    // Determine sound based on notification type
    String? notificationType = message.data['type']?.toLowerCase();
    switch (notificationType) {
      case 'order':
      case 'order_update':
        return NotificationSounds.orderSound;
      case 'order_received':
        return NotificationSounds.orderReceived;
      case 'order_confirmed':
        return NotificationSounds.orderConfirmed;
      case 'order_delivered':
        return NotificationSounds.orderDelivered;
      case 'message':
      case 'chat':
        return NotificationSounds.messageSound;
      case 'ipl_message':
      case 'ipl':
      case 'sports':
        return NotificationSounds.iplMessage;
      case 'price_alert':
      case 'market_update':
        return NotificationSounds.priceAlert;
      case 'urgent':
      case 'emergency':
        return NotificationSounds.urgentSound;
      case 'success':
        return NotificationSounds.success;
      case 'warning':
        return NotificationSounds.warning;
      case 'error':
        return NotificationSounds.error;
      default:
        return NotificationSounds.customAlert;
    }
  }

  static void _showForegroundNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    // Enhanced debugging for Firebase messages
    debugPrint('🔥 Firebase message received:');
    debugPrint('Title: ${notification?.title}');
    debugPrint('Body: ${notification?.body}');
    debugPrint('Data: ${message.data}');
    debugPrint('Has notification object: ${notification != null}');
    debugPrint('Has data: ${message.data.isNotEmpty}');

    // NUCLEAR OPTION: If data contains sound info, ignore Firebase notification entirely
    if (message.data.containsKey('sound') || message.data.containsKey('type')) {
      debugPrint(
          '🚨 NUCLEAR APPROACH: Data contains sound info - bypassing Firebase entirely');

      final title =
          message.data['title'] ?? notification?.title ?? 'Notification';
      final body = message.data['body'] ?? notification?.body ?? 'New message';
      final soundType = message.data['sound'] ?? message.data['type'] ?? '';

      debugPrint('🎯 NUCLEAR: Title: $title');
      debugPrint('🎯 NUCLEAR: Body: $body');
      debugPrint('🎯 NUCLEAR: Sound: $soundType');

      // Strip extension if present
      String cleanSound = soundType;
      if (cleanSound.contains('.')) {
        cleanSound = cleanSound.split('.').first;
      }

      debugPrint('� NUCLEAR: Clean sound: $cleanSound');

      // Force show with the exact same method that works for buttons
      await _showCustomSoundNotificationForced(
        _generateNotificationId(),
        title,
        body,
        cleanSound,
        message.data['payload'] ?? 'firebase_nuclear',
      );

      debugPrint('✅ NUCLEAR: Custom notification sent with sound: $cleanSound');
      return; // Completely skip Firebase processing
    }

    // Original Firebase processing (fallback)
    debugPrint('📱 Using standard Firebase processing');

    String notificationSound = _getNotificationSound(message);
    bool useCustomSound = notificationSound.isNotEmpty;

    debugPrint('🔊 Sound selection:');
    debugPrint('Selected sound: $notificationSound');
    debugPrint('Use custom sound: $useCustomSound');
    debugPrint('Sound from data[sound]: ${message.data['sound']}');
    debugPrint('Sound from data[type]: ${message.data['type']}');

    if (notification != null) {
      await showCustomSoundNotification(
        id: _generateNotificationId(),
        title: notification.title ?? 'Notification',
        body: notification.body ?? '',
        customSound: useCustomSound ? notificationSound : null,
        payload: message.data['payload'] ?? 'firebase_notification',
      );

      // Log for debugging
      debugPrint(
          '✅ Showed notification: ${notification.title} with sound: $notificationSound');
    } else {
      debugPrint('❌ No notification object in Firebase message');
    }
  }

  /// Get MainActivity channel ID based on sound name
  static String _getChannelIdFromSound(String sound) {
    // Clean sound name (remove extension if present)
    String cleanSound = sound;
    if (cleanSound.contains('.')) {
      cleanSound = cleanSound.split('.').first;
    }

    switch (cleanSound.toLowerCase()) {
      case 'ipl_message':
      case 'ipl':
        return 'ipl_message_channel';
      case 'temple_bell':
        return 'temple_bell_channel';
      case 'coin_dropping':
        return 'coin_dropping_channel';
      default:
        return 'custom_sound_channel'; // fallback to general custom channel
    }
  }

  /// Get channel display name from channel ID
  static String _getChannelNameFromId(String channelId) {
    switch (channelId) {
      case 'ipl_message_channel':
        return 'IPL Message Notifications';
      case 'temple_bell_channel':
        return 'Temple Bell Notifications';
      case 'coin_dropping_channel':
        return 'Coin Dropping Notifications';
      case 'custom_sound_channel':
        return 'Custom Sound Notifications';
      default:
        return 'High Importance Notifications';
    }
  }

  /// NEW SIMPLIFIED: Show foreground notification using MainActivity channels
  static void _showForegroundNotificationSimple(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;

    debugPrint('🔥 FOREGROUND: Firebase message received');
    debugPrint('Title: ${notification?.title}');
    debugPrint('Body: ${notification?.body}');
    debugPrint('Data: ${message.data}');

    if (notification != null) {
      // Use predefined MainActivity channels directly (same approach as background)
      debugPrint('🎯 FOREGROUND: Using MainActivity predefined channels');

      // Determine which channel to use from Firebase data or default
      String channelId = 'high_importance_channel'; // default fallback

      // Check for sound/type in data to determine channel
      if (message.data.containsKey('sound') ||
          message.data.containsKey('type')) {
        final soundType = message.data['sound'] ?? message.data['type'] ?? '';
        channelId = _getChannelIdFromSound(soundType);
        debugPrint(
            '🎯 FOREGROUND: Using channel from sound/type: $channelId for sound: $soundType');
      }

      // Show notification using the determined MainActivity channel
      await _flutterLocalNotificationsPlugin.show(
        _generateNotificationId(),
        notification.title ?? 'Notification',
        notification.body ?? '',
        NotificationDetails(
          android: AndroidNotificationDetails(
            channelId,
            _getChannelNameFromId(channelId),
            channelDescription: 'Foreground notification with custom sound',
            icon: 'ic_stat_notify',
            importance: Importance.high,
            priority: Priority.high,
            styleInformation: BigTextStyleInformation(
              notification.body ?? '',
              contentTitle: notification.title,
            ),
          ),
        ),
        payload: message.data['payload'] ?? 'firebase_foreground',
      );

      debugPrint(
          '✅ FOREGROUND: Notification sent using MainActivity channel: $channelId');
    } else {
      debugPrint('❌ FOREGROUND: No notification object in Firebase message');
    }
  }

  /// Show local notification with custom sound
  static Future<void> showCustomSoundNotification({
    required int id,
    required String title,
    required String body,
    String? customSound,
    String? payload,
  }) async {
    try {
      bool useCustomSound = customSound != null && customSound.isNotEmpty;

      debugPrint('🔊 showCustomSoundNotification called:');
      debugPrint('ID: $id');
      debugPrint('Title: $title');
      debugPrint('Custom Sound: $customSound');
      debugPrint('Use Custom Sound: $useCustomSound');

      if (useCustomSound) {
        // ALWAYS use forced approach for custom sounds - no fallback!
        debugPrint('🚀 Custom sound detected - using FORCED approach only');
        await _showCustomSoundNotificationForced(
            id, title, body, customSound, payload);
        return;
      }

      // Only use standard approach for default sounds
      debugPrint('📱 No custom sound - using standard approach');
      await _showStandardNotification(id, title, body, null, payload, false);
    } catch (e) {
      debugPrint('Error showing custom sound notification: $e');
      // Fallback to default notification
      await showDefaultNotification(
        id: id,
        title: title,
        body: body,
        payload: payload,
      );
    }
  }

  /// ULTIMATE forced approach - completely new channel every time
  static Future<void> _showCustomSoundNotificationForced(int id, String title,
      String body, String customSound, String? payload) async {
    debugPrint('🚀 ULTIMATE FORCED APPROACH - Guaranteed fresh channel');
    debugPrint('🎯 Sound file: $customSound');

    // STEP 1: Generate completely unique channel ID with safe timestamp
    final timestamp = DateTime.now().millisecondsSinceEpoch % 2147483647;
    final safeId = id > 2147483647 ? id % 2147483647 : id;
    final uniqueChannelId = 'ultimate_${customSound}_${timestamp}_$safeId';

    try {
      // STEP 2: Delete any potentially existing channel first
      final androidPlugin = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();

      if (androidPlugin != null) {
        try {
          await androidPlugin.deleteNotificationChannel(uniqueChannelId);
          debugPrint('🗑️ Pre-emptively deleted channel: $uniqueChannelId');
        } catch (e) {
          debugPrint(
              'ℹ️ Channel $uniqueChannelId didn\'t exist (expected): $e');
        }

        // STEP 3: Wait to ensure deletion is processed
        await Future.delayed(const Duration(milliseconds: 100));

        // STEP 4: Create completely fresh channel with sound
        final ultimateChannel = AndroidNotificationChannel(
          uniqueChannelId,
          'Ultimate Sound - ${customSound.toUpperCase()}',
          description: 'Ultimate fresh channel for $customSound sound',
          importance: Importance.max,
          sound: RawResourceAndroidNotificationSound(customSound),
          enableVibration: true,
          playSound: true,
        );

        await androidPlugin.createNotificationChannel(ultimateChannel);
        debugPrint('✅ Created ULTIMATE fresh channel: $uniqueChannelId');

        // STEP 5: Wait to ensure channel creation is processed
        await Future.delayed(const Duration(milliseconds: 200));

        // STEP 6: Show notification using the fresh channel
        await _flutterLocalNotificationsPlugin.show(
          id,
          title,
          body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              ultimateChannel.id,
              ultimateChannel.name,
              channelDescription: ultimateChannel.description,
              icon: 'ic_stat_notify',
              // Let the channel handle the sound completely
              enableVibration: true,
              priority: Priority.max,
              importance: Importance.max,
              styleInformation: BigTextStyleInformation(
                body,
                contentTitle: title,
              ),
            ),
          ),
          payload: payload,
        );

        debugPrint(
            '🎵 ULTIMATE notification sent with fresh channel sound: $customSound');
        debugPrint('🎯 Channel: $uniqueChannelId should play: $customSound');
      } else {
        throw Exception('Android plugin not available');
      }
    } catch (e) {
      debugPrint('❌ ULTIMATE approach failed: $e');

      // Last resort: Basic notification with sound in details
      debugPrint('🆘 Last resort: Basic notification with sound');

      await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            'emergency_channel',
            'Emergency Channel',
            channelDescription: 'Emergency fallback',
            icon: 'ic_stat_notify',
            sound: RawResourceAndroidNotificationSound(customSound),
            playSound: true,
            enableVibration: true,
            priority: Priority.max,
            importance: Importance.max,
          ),
        ),
        payload: payload,
      );

      debugPrint('🆘 Emergency notification sent');
    }
  }

  /// Standard approach
  static Future<void> _showStandardNotification(
      int id,
      String title,
      String body,
      String? customSound,
      String? payload,
      bool useCustomSound) async {
    debugPrint('📱 Using STANDARD notification approach');

    // Create sound-specific channel if using custom sound
    if (useCustomSound) {
      debugPrint('🎵 Creating sound-specific channel for: $customSound');
      await _ensureSoundChannelExists(customSound!);
      await Future.delayed(const Duration(milliseconds: 500));
    }

    // Get appropriate channel
    AndroidNotificationChannel channel = useCustomSound
        ? _createSoundSpecificChannel(customSound!)
        : _androidNotificationChannel;

    debugPrint('📱 Using channel: ${channel.id}');

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
          icon: 'ic_stat_notify',
          largeIcon: const DrawableResourceAndroidBitmap('ic_launcher'),
          sound: useCustomSound
              ? RawResourceAndroidNotificationSound(customSound!)
              : null,
          playSound: true,
          styleInformation: BigTextStyleInformation(
            body,
            contentTitle: title,
            summaryText: body,
          ),
          enableVibration: true,
          priority: Priority.high,
          importance: Importance.high,
        ),
        iOS: useCustomSound
            ? DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
                sound: '$customSound.aiff',
              )
            : _iOSNotificationChannel,
      ),
      payload: payload,
    );

    debugPrint(
        '📱 Standard notification shown: $title with sound: ${customSound ?? "default"}');
  }

  /// Show notification with default sound
  static Future<void> showDefaultNotification({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    try {
      await _flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _androidNotificationChannel.id,
            _androidNotificationChannel.name,
            channelDescription: _androidNotificationChannel.description,
            icon: 'ic_stat_notify',
            largeIcon: const DrawableResourceAndroidBitmap('ic_launcher'),
            styleInformation: BigTextStyleInformation(
              body,
              contentTitle: title,
              summaryText: body,
            ),
            enableVibration: true,
            priority: Priority.high,
            importance: Importance.high,
          ),
          iOS: _iOSNotificationChannel,
        ),
        payload: payload,
      );

      debugPrint('Default notification shown: $title');
    } catch (e) {
      debugPrint('Error showing default notification: $e');
    }
  }

  /// Show order-related notification with appropriate sound
  static Future<void> showOrderNotification({
    required String orderType,
    required String title,
    required String body,
    String? orderId,
  }) async {
    String sound;
    switch (orderType.toLowerCase()) {
      case 'received':
        sound = NotificationSounds.orderReceived;
        break;
      case 'confirmed':
        sound = NotificationSounds.orderConfirmed;
        break;
      case 'delivered':
        sound = NotificationSounds.orderDelivered;
        break;
      default:
        sound = NotificationSounds.orderSound;
    }

    await showCustomSoundNotification(
      id: _generateNotificationId(),
      title: title,
      body: body,
      customSound: sound,
      payload: orderId ?? 'order_notification',
    );
  }

  /// Show market-related notification
  static Future<void> showMarketNotification({
    required String title,
    required String body,
    bool isPriceAlert = false,
    String? payload,
  }) async {
    await showCustomSoundNotification(
      id: _generateNotificationId(),
      title: title,
      body: body,
      customSound: isPriceAlert
          ? NotificationSounds.priceAlert
          : NotificationSounds.marketUpdate,
      payload: payload ?? 'market_notification',
    );
  }

  /// Show urgent notification
  static Future<void> showUrgentNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await showCustomSoundNotification(
      id: _generateNotificationId(),
      title: title,
      body: body,
      customSound: NotificationSounds.urgentSound,
      payload: payload ?? 'urgent_notification',
    );
  }

  /// Show IPL-related notification with IPL message sound
  static Future<void> showIPLNotification({
    required String title,
    required String body,
    String? payload,
  }) async {
    await showCustomSoundNotification(
      id: _generateNotificationId(),
      title: title,
      body: body,
      customSound: NotificationSounds.iplMessage,
      payload: payload ?? 'ipl_notification',
    );
  }

  /// Clear all custom notification channels (for testing/debugging)
  static Future<void> clearAllNotificationChannels() async {
    final androidPlugin =
        _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      // List of sound types to clear channels for
      final soundTypes = NotificationSounds.getAllSounds();

      for (String sound in soundTypes) {
        try {
          await androidPlugin
              .deleteNotificationChannel('sound_${sound}_channel');
          debugPrint('🗑️ Cleared channel for sound: $sound');
        } catch (e) {
          debugPrint('ℹ️ Channel for $sound didn\'t exist: $e');
        }
      }

      debugPrint('✅ All notification channels cleared!');
    }
  }

  /// Get current FCM token
  static String? get fcmToken => _token;

  /// Print FCM token for Firebase Console testing
  static void printFCMTokenForTesting() {
    debugPrint('🔔 FCM Token for Firebase Console Testing:');
    debugPrint('Token: $_token');
    debugPrint(
        'Copy this token and use it in Firebase Console > Messaging > Send test message');

    // Also print without prefix for easy copying
    if (_token != null) {
      print(_token);
    }
  }

  /// Test IPL sound specifically - use this to debug sound issues
  static Future<void> testIPLSoundDebug() async {
    debugPrint('🏏 Testing IPL Sound Debug:');
    debugPrint('Sound file: ipl_message.mp3');
    debugPrint('Sound constant: ${NotificationSounds.iplMessage}');
    debugPrint('Expected path: android/app/src/main/res/raw/ipl_message.mp3');

    // First clear channels to ensure fresh start
    await clearAllNotificationChannels();
    await Future.delayed(const Duration(milliseconds: 500));

    await showCustomSoundNotification(
      id: 999999, // Unique ID for testing
      title: '🏏 IPL Sound Test',
      body: 'Testing ipl_message.mp3 - Check if you hear the custom sound!',
      customSound: NotificationSounds.iplMessage,
      payload: 'ipl_sound_test',
    );

    debugPrint('✅ IPL sound notification sent!');
  }

  /// Force sound test with multiple approaches
  static Future<void> forceTestCustomSound() async {
    debugPrint('🚨 FORCE TESTING CUSTOM SOUND - MULTIPLE APPROACHES');

    // Clear all channels first
    await clearAllNotificationChannels();
    await Future.delayed(const Duration(seconds: 1));

    // Test different approaches
    final testApproaches = [
      'ipl_message',
      'ipl_message.mp3',
      NotificationSounds.iplMessage,
    ];

    for (int i = 0; i < testApproaches.length; i++) {
      final soundName = testApproaches[i];
      debugPrint('🧪 Testing approach ${i + 1}: "$soundName"');

      try {
        await showCustomSoundNotification(
          id: 800000 + i,
          title: 'Force Test ${i + 1}',
          body: 'Testing: $soundName',
          customSound: soundName,
        );
        debugPrint('✅ Approach ${i + 1} sent successfully');
      } catch (e) {
        debugPrint('❌ Approach ${i + 1} failed: $e');
      }

      await Future.delayed(const Duration(seconds: 2));
    }

    debugPrint('🏁 Force test completed - check your notifications!');
  }

  /// Ultimate nuclear test - simulates Firebase data message exactly like what works locally
  static Future<void> nuclearFirebaseTest() async {
    debugPrint('☢️ NUCLEAR FIREBASE TEST - Simulating Firebase data message');

    // Create fake Firebase message that mimics your payload
    final fakeMessage = RemoteMessage(
      data: {
        'title': 'Nuclear IPL Test',
        'body': 'This should work exactly like local notifications',
        'sound': 'ipl_message',
        'type': 'ipl_message',
      },
    );

    debugPrint('☢️ Calling Firebase handler with fake message...');
    _showForegroundNotificationSimple(fakeMessage);

    debugPrint('☢️ Nuclear test sent - this should work!');
  }

  /// Test Firebase notification path with custom message
  static Future<void> testFirebaseNotificationPath({
    required String title,
    required String body,
    String? sound,
    String? type,
    Map<String, String>? additionalData,
  }) async {
    debugPrint('🧪 Testing Firebase notification path:');
    debugPrint('Title: $title');
    debugPrint('Body: $body');
    debugPrint('Sound: $sound');
    debugPrint('Type: $type');

    // Create fake Firebase message
    final data = <String, String>{};
    if (sound != null) data['sound'] = sound;
    if (type != null) data['type'] = type;
    if (additionalData != null) data.addAll(additionalData);

    final fakeMessage = RemoteMessage(
      notification: RemoteNotification(title: title, body: body),
      data: data,
    );

    // Process through the same path as real Firebase messages
    _showForegroundNotificationSimple(fakeMessage);

    debugPrint('✅ Firebase path test completed');
  }

  /// Cancel notification by ID
  static Future<void> cancelNotification(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  /// Cancel all notifications
  static Future<void> cancelAllNotifications() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }

  static void _handleBackgroundNotificationOnTap(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification != null) {
      debugPrint('Notification clicked: ${message.data}');
    }
  }

  /// Debug APNS token for iOS
  static Future<void> debugAPNSToken() async {
    try {
      debugPrint('🍎 Checking iOS APNS Token...');

      // Get APNS token
      String? apnsToken = await _messaging.getAPNSToken();
      debugPrint('🍎 APNS Token: $apnsToken');

      // Get FCM token
      String? fcmToken = await _messaging.getToken();
      debugPrint('🔥 FCM Token: $fcmToken');

      if (apnsToken == null) {
        debugPrint('❌ APNS Token is null - iOS troubleshooting:');
        debugPrint(
            '1. ⚠️  Are you running on iOS Simulator? APNS only works on real devices!');
        debugPrint('2. 🔑 Check Apple Developer account setup');
        debugPrint('3. 📝 Check ios/Runner/Runner.entitlements file');
        debugPrint('4. ⚙️  Check ios/Runner/Info.plist permissions');
        debugPrint('5. 🔧 Check code signing in Xcode');
        debugPrint(
            '6. 🔄 Try: flutter clean && cd ios && pod install && cd .. && flutter run');
      } else {
        debugPrint('✅ APNS Token retrieved successfully!');
        debugPrint('📱 Token length: ${apnsToken.length} characters');
      }
    } catch (e) {
      debugPrint('❌ Error getting APNS token: $e');
    }
  }

  /// Test iOS notification specifically
  static Future<void> testIOSNotification() async {
    debugPrint('🍎 Testing iOS notification...');

    try {
      await _flutterLocalNotificationsPlugin.show(
        88888,
        '🍎 iOS Test Notification',
        'Testing iOS custom sound notification',
        const NotificationDetails(
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound:
                'default', // Use default for now, will add custom sounds later
          ),
        ),
        payload: 'ios_test',
      );
      debugPrint('✅ iOS test notification sent');
    } catch (e) {
      debugPrint('❌ iOS test notification failed: $e');
    }
  }

  /// Test foreground notifications with custom sounds (simulates Firebase foreground)
  static Future<void> testForegroundNotificationSounds() async {
    debugPrint('🧪 Testing FOREGROUND notifications with custom sounds...');

    // Test IPL foreground notification
    final iplMessage = RemoteMessage(
        notification: RemoteNotification(
            title: '🏏 Foreground IPL Test',
            body: 'Testing IPL sound in foreground'),
        data: {'sound': 'ipl_message', 'type': 'ipl'});
    _showForegroundNotificationSimple(iplMessage);

    await Future.delayed(const Duration(seconds: 2));

    // Test Temple Bell foreground notification
    final templeBellMessage = RemoteMessage(
        notification: RemoteNotification(
            title: '🔔 Foreground Temple Bell Test',
            body: 'Testing temple bell sound in foreground'),
        data: {'sound': 'temple_bell', 'type': 'temple_bell'});
    _showForegroundNotificationSimple(templeBellMessage);

    await Future.delayed(const Duration(seconds: 2));

    // Test Coin Dropping foreground notification
    final coinMessage = RemoteMessage(
        notification: RemoteNotification(
            title: '💰 Foreground Coin Test',
            body: 'Testing coin dropping sound in foreground'),
        data: {'sound': 'coin_dropping', 'type': 'coin_dropping'});
    _showForegroundNotificationSimple(coinMessage);

    debugPrint('✅ All foreground notification tests sent!');
    debugPrint(
        '🎵 Check if you hear custom sounds for foreground notifications');
  }

  /// Test predefined channels created by MainActivity
  static Future<void> testPredefinedChannels() async {
    debugPrint('🧪 Testing MainActivity predefined channels...');

    // Test IPL channel
    await _flutterLocalNotificationsPlugin.show(
      88888,
      '🏏 IPL Channel Test',
      'Testing predefined ipl_message_channel from MainActivity',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'ipl_message_channel', // Use the exact channel ID from MainActivity
          'IPL Message Notifications',
          channelDescription: 'Testing predefined IPL channel',
          icon: 'ic_stat_notify',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: 'ipl_channel_test',
    );

    // Test Temple Bell channel
    await _flutterLocalNotificationsPlugin.show(
      88889,
      '🔔 Temple Bell Channel Test',
      'Testing predefined temple_bell_channel from MainActivity',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'temple_bell_channel', // Use the exact channel ID from MainActivity
          'Temple Bell Notifications',
          channelDescription: 'Testing predefined temple bell channel',
          icon: 'ic_stat_notify',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: 'temple_bell_channel_test',
    );

    // Test Coin Dropping channel
    await _flutterLocalNotificationsPlugin.show(
      88890,
      '💰 Coin Dropping Channel Test',
      'Testing predefined coin_dropping_channel from MainActivity',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'coin_dropping_channel', // Use the exact channel ID from MainActivity
          'Coin Dropping Notifications',
          channelDescription: 'Testing predefined coin dropping channel',
          icon: 'ic_stat_notify',
          importance: Importance.high,
          priority: Priority.high,
        ),
      ),
      payload: 'coin_dropping_channel_test',
    );

    debugPrint('✅ All predefined channel tests sent!');
    debugPrint(
        '🎵 Check if you hear the custom sounds from MainActivity channels');
  }

  static Future<void> init(WidgetRef ref) async {
    try {
      // DON'T clear all channels - preserve MainActivity predefined channels!
      // clearAllNotificationChannels(); // REMOVED
      _requestPermission();
      _getFCMToken();
      _configureLocalNotificationPlugin(ref);
      _createAndroidNotificationChannel();

      /// Foreground notification handler (NEW: uses MainActivity channels directly)
      FirebaseMessaging.onMessage.listen(_showForegroundNotificationSimple);

      /// Background notification handler
      FirebaseMessaging.onMessageOpenedApp
          .listen(_handleBackgroundNotificationOnTap);
    } catch (e, stack) {
      debugPrint(e.toString());
      debugPrintStack(stackTrace: stack);
    }
  }
}
