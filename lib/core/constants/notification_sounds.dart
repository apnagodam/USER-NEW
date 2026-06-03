/// Custom notification sounds configuration
/// 
/// This class contains constants for different notification sounds
/// that can be used throughout the app.
class NotificationSounds {
  // Default notification sound (uses system default)
  static const String defaultSound = '';
  
  // Custom notification sounds
  static const String customAlert = 'custom_notification';
  static const String messageSound = 'message_notification';
  static const String iplMessage = 'ipl_message';
  static const String templeBell = 'temple_bell';
  static const String coinDropping = 'coin_dropping';
  static const String orderSound = 'order_notification';
  static const String urgentSound = 'urgent_notification';
  
  // Order-related sounds
  static const String orderReceived = 'order_received';
  static const String orderConfirmed = 'order_confirmed';
  static const String orderDelivered = 'order_delivered';
  
  // Market-related sounds
  static const String priceAlert = 'price_alert';
  static const String marketUpdate = 'market_update';
  
  // System sounds
  static const String success = 'success_notification';
  static const String warning = 'warning_notification';
  static const String error = 'error_notification';
  
  /// Get all available notification sounds
  static List<String> getAllSounds() {
    return [
      defaultSound,
      customAlert,
      messageSound,
      iplMessage,
      templeBell,
      coinDropping,
      orderSound,
      urgentSound,
      orderReceived,
      orderConfirmed,
      orderDelivered,
      priceAlert,
      marketUpdate,
      success,
      warning,
      error,
    ];
  }
  
  /// Get sound display names for UI
  static Map<String, String> getSoundDisplayNames() {
    return {
      defaultSound: 'Default',
      customAlert: 'Custom Alert',
      messageSound: 'Message',
      iplMessage: 'IPL Message',
      templeBell: 'Temple Bell',
      coinDropping: 'Coin Dropping',
      orderSound: 'Order',
      urgentSound: 'Urgent',
      orderReceived: 'Order Received',
      orderConfirmed: 'Order Confirmed',
      orderDelivered: 'Order Delivered',
      priceAlert: 'Price Alert',
      marketUpdate: 'Market Update',
      success: 'Success',
      warning: 'Warning',
      error: 'Error',
    };
  }
}