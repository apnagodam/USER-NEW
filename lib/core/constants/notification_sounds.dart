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
  static const String orderSound = 'temple_bell';
  static const String urgentSound = 'urgent_notification';
  
  // Order match sounds -> Temple Bell (Bell voice)
  static const String orderMatch = 'temple_bell';
  static const String orderReceived = 'temple_bell';
  static const String orderConfirmed = 'temple_bell';
  static const String orderDelivered = 'temple_bell';
  
  // Bid sounds -> Coin Dropping (Coin sound)
  static const String bidApply = 'coin_dropping';
  static const String bidPlaced = 'coin_dropping';
  static const String bidding = 'coin_dropping';
  
  // Market-related sounds
  static const String priceAlert = 'temple_bell';
  static const String marketUpdate = 'coin_dropping';
  
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
      orderMatch,
      urgentSound,
      orderReceived,
      orderConfirmed,
      orderDelivered,
      bidApply,
      bidPlaced,
      bidding,
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