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
    'high_importance_channel_v3',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
    sound: const RawResourceAndroidNotificationSound('coin_dropping'),
    playSound: true,
    enableVibration: true,
  );

  ///notification channel with custom sound for coin dropping
  static final AndroidNotificationChannel _coinDroppingChannel =
      AndroidNotificationChannel(
    'coin_dropping_channel_v3',
    'Coin Dropping Notifications',
    description: 'Notifications with coin dropping sound',
    importance: Importance.max,
    sound: const RawResourceAndroidNotificationSound('coin_dropping'),
    playSound: true,
    enableVibration: true,
  );

  ///notification channel with custom sound for IPL message
  static final AndroidNotificationChannel _iplChannel =
      AndroidNotificationChannel(
    'ipl_message_channel_v3',
    'IPL Message Notifications',
    description: 'Notifications with IPL message sound',
    importance: Importance.max,
    sound: const RawResourceAndroidNotificationSound('ipl_message'),
    playSound: true,
    enableVibration: true,
  );

  ///notification channel with custom sound for temple bell
  static final AndroidNotificationChannel _templeBellChannel =
      AndroidNotificationChannel(
    'temple_bell_channel_v3',
    'Temple Bell Notifications',
    description: 'Notifications with temple bell sound',
    importance: Importance.max,
    sound: const RawResourceAndroidNotificationSound('temple_bell'),
    playSound: true,
    enableVibration: true,
  );

  ///notification channel with custom sound for android notifications
  static final AndroidNotificationChannel _androidCustomSoundChannel =
      AndroidNotificationChannel(
    'custom_sound_channel_v3',
    'Custom Sound Notifications',
    description: 'This channel is used for notifications with custom sounds.',
    importance: Importance.max,
    sound: const RawResourceAndroidNotificationSound('coin_dropping'),
    playSound: true,
    enableVibration: true,
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
  static Future<void> _requestPermission() async {
    try {
      final settings = await _messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      debugPrint('Notification authorization status: ${settings.authorizationStatus}');

      final androidPlugin = _flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>();
      await androidPlugin?.requestNotificationsPermission();
    } catch (e) {
      debugPrint('Error requesting notification permission: $e');
    }
  }

  ///setup the FCM token to receive notifications
  static Future<void> _getFCMToken() async {
    try {
      if (GetPlatform.isIOS) {
        String? apns = await _messaging.getAPNSToken();
        if (apns == null) {
          await Future.delayed(const Duration(seconds: 2));
        }
      }
      _token = await _messaging.getToken();

      ///onTokenRefresh stream allows us to listen to the token value whenever it changes
      _messaging.onTokenRefresh.listen((newValue) {
        _token = newValue;
      });

      debugPrint('═══════════════════════════════════════════════════════');
      debugPrint('🔥 FCM TOKEN: $_token');
      debugPrint('═══════════════════════════════════════════════════════');
    } catch (e) {
      debugPrint('Error getting FCM token: $e');
    }
  }

  static Future<void> _configureLocalNotificationPlugin(WidgetRef ref) async {
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

  static Future<void> _createAndroidNotificationChannel() async {
    final androidPlugin = _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
    await androidPlugin?.createNotificationChannel(_androidNotificationChannel);
    await androidPlugin?.createNotificationChannel(_iplChannel);
    await androidPlugin?.createNotificationChannel(_templeBellChannel);
    await androidPlugin?.createNotificationChannel(_coinDroppingChannel);
    await androidPlugin?.createNotificationChannel(_androidCustomSoundChannel);
  }

  /// Resolve sound filename from name/type to an existing sound file
  static String _resolveSoundFileName(String sound) {
    String cleanSound = sound.trim();
    if (cleanSound.contains('.')) {
      cleanSound = cleanSound.split('.').first;
    }
    cleanSound = cleanSound.toLowerCase();
    if (cleanSound == 'ipl_message' || cleanSound == 'ipl' || cleanSound == 'message' || cleanSound == 'chat') {
      return 'ipl_message';
    } else if (cleanSound == 'temple_bell' || cleanSound == 'bell' || cleanSound == 'price_alert' || cleanSound == 'market_update') {
      return 'temple_bell';
    } else if (cleanSound == 'coin_dropping' || cleanSound == 'coin' || cleanSound.contains('order')) {
      return 'coin_dropping';
    }
    return 'coin_dropping';
  }

  /// Determine notification sound based on message data
  static String _getNotificationSound(RemoteMessage message) {
    String? customSound = message.data['sound'];
    if (customSound != null && customSound.isNotEmpty) {
      return _resolveSoundFileName(customSound);
    }
    String? notificationType = message.data['type']?.toLowerCase();
    if (notificationType != null && notificationType.isNotEmpty) {
      return _resolveSoundFileName(notificationType);
    }
    if (message.notification?.android?.sound != null &&
        message.notification!.android!.sound!.isNotEmpty) {
      return _resolveSoundFileName(message.notification!.android!.sound!);
    }
    if (message.notification?.apple?.sound?.name != null &&
        (message.notification?.apple?.sound?.name?.isNotEmpty ?? false)) {
      return _resolveSoundFileName(message.notification!.apple!.sound!.name!);
    }
    return 'coin_dropping';
  }


  /// Get MainActivity channel ID based on sound name
  static String _getChannelIdFromSound(String sound) {
    String cleanSound = sound;
    if (cleanSound.contains('.')) {
      cleanSound = cleanSound.split('.').first;
    }

    switch (cleanSound.toLowerCase()) {
      case 'coin_dropping':
      case 'coin':
      case 'order':
      case 'order_received':
      case 'order_confirmed':
      case 'order_delivered':
      case 'order_update':
        return 'coin_dropping_channel_v3';
      case 'ipl_message':
      case 'ipl':
      case 'message':
      case 'chat':
        return 'ipl_message_channel_v3';
      case 'temple_bell':
      case 'bell':
      case 'price_alert':
      case 'market_update':
        return 'temple_bell_channel_v3';
      default:
        return 'coin_dropping_channel_v3'; // fallback to coin dropping
    }
  }

  /// Get channel display name from channel ID
  static String _getChannelNameFromId(String channelId) {
    switch (channelId) {
      case 'coin_dropping_channel_v3':
      case 'coin_dropping_channel_v2':
      case 'coin_dropping_channel':
        return 'Coin Dropping Notifications';
      case 'ipl_message_channel_v3':
      case 'ipl_message_channel_v2':
      case 'ipl_message_channel':
        return 'IPL Message Notifications';
      case 'temple_bell_channel_v3':
      case 'temple_bell_channel_v2':
      case 'temple_bell_channel':
        return 'Temple Bell Notifications';
      case 'custom_sound_channel_v3':
      case 'custom_sound_channel_v2':
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

    final title = notification?.title ?? message.data['title'] ?? 'Notification';
    final body = notification?.body ?? message.data['body'] ?? '';

    final soundFileName = _getNotificationSound(message);
    final channelId = _getChannelIdFromSound(soundFileName);

    await _flutterLocalNotificationsPlugin.show(
      _generateNotificationId(),
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          _getChannelNameFromId(channelId),
          channelDescription: 'Notification with custom sound',
          icon: 'ic_stat_notify',
          sound: RawResourceAndroidNotificationSound(soundFileName),
          playSound: true,
          enableVibration: true,
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: BigTextStyleInformation(
            body,
            contentTitle: title,
          ),
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
          sound: '$soundFileName.caf',
        ),
      ),
      payload: message.data['payload'] ?? 'firebase_foreground',
    );

    debugPrint(
        '✅ FOREGROUND: Notification sent using channel: $channelId with sound: $soundFileName');
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

        final cleanSound = _resolveSoundFileName(customSound);

        // STEP 4: Create completely fresh channel with sound
        final ultimateChannel = AndroidNotificationChannel(
          uniqueChannelId,
          'Ultimate Sound - ${cleanSound.toUpperCase()}',
          description: 'Ultimate fresh channel for $cleanSound sound',
          importance: Importance.max,
          sound: RawResourceAndroidNotificationSound(cleanSound),
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
              sound: RawResourceAndroidNotificationSound(cleanSound),
              playSound: true,
              enableVibration: true,
              priority: Priority.max,
              importance: Importance.max,
              styleInformation: BigTextStyleInformation(
                body,
                contentTitle: title,
              ),
            ),
            iOS: DarwinNotificationDetails(
              presentAlert: true,
              presentBadge: true,
              presentSound: true,
              sound: '$cleanSound.caf',
            ),
          ),
          payload: payload,
        );

        debugPrint(
            '🎵 ULTIMATE notification sent with fresh channel sound: $cleanSound');
        debugPrint('🎯 Channel: $uniqueChannelId should play: $cleanSound');
      } else {
        throw Exception('Android plugin not available');
      }
    } catch (e) {
      debugPrint('❌ ULTIMATE approach failed: $e');

      final cleanSound = _resolveSoundFileName(customSound);
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
            sound: RawResourceAndroidNotificationSound(cleanSound),
            playSound: true,
            enableVibration: true,
            priority: Priority.max,
            importance: Importance.max,
          ),
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
            sound: '$cleanSound.caf',
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

    final cleanSound = customSound != null ? _resolveSoundFileName(customSound) : null;
    final channelId = cleanSound != null ? _getChannelIdFromSound(cleanSound) : _androidNotificationChannel.id;

    debugPrint('📱 Using channel: $channelId');

    await _flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          _getChannelNameFromId(channelId),
          channelDescription: 'Notification with sound',
          icon: 'ic_stat_notify',
          largeIcon: const DrawableResourceAndroidBitmap('ic_launcher'),
          sound: useCustomSound && cleanSound != null
              ? RawResourceAndroidNotificationSound(cleanSound)
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
        iOS: useCustomSound && cleanSound != null
            ? DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
                sound: '$cleanSound.caf',
              )
            : _iOSNotificationChannel,
      ),
      payload: payload,
    );

    debugPrint(
        '📱 Standard notification shown: $title with sound: ${cleanSound ?? "default"}');
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
      await _configureLocalNotificationPlugin(ref);
      await _createAndroidNotificationChannel();
      await _requestPermission();
      await _getFCMToken();

      // Subscribe to general topic
      try {
        await _messaging.subscribeToTopic('all');
        debugPrint('✅ Subscribed to topic: all');
      } catch (e) {
        debugPrint('⚠️ Topic subscription error: $e');
      }

      /// Foreground notification handler (uses MainActivity channels directly)
      FirebaseMessaging.onMessage.listen(_showForegroundNotificationSimple);

      /// Background notification handler when app is clicked
      FirebaseMessaging.onMessageOpenedApp
          .listen(_handleBackgroundNotificationOnTap);

      /// Handle initial message when app is launched from terminated state via notification click
      RemoteMessage? initialMessage = await _messaging.getInitialMessage();
      if (initialMessage != null) {
        debugPrint('🔔 Initial FCM message found on launch: ${initialMessage.messageId}');
        _handleBackgroundNotificationOnTap(initialMessage);
      }
    } catch (e, stack) {
      debugPrint('NotificationService init error: $e');
      debugPrintStack(stackTrace: stack);
    }
  }
}
