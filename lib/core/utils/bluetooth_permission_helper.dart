import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:thermal_printer/thermal_printer.dart';
import 'dart:io';

/// Helper class to manage Bluetooth permissions for thermal printer
class BluetoothPermissionHelper {
  BluetoothPermissionHelper._internal();
  static final BluetoothPermissionHelper instance =
      BluetoothPermissionHelper._internal();

  bool _initialized = false;

  /// Reset initialization flag to allow re-initialization if needed
  void resetInitialization() {
    _initialized = false;
    debugPrint('BluetoothPermissionHelper: Initialization flag reset');
  }

  /// Request all necessary Bluetooth permissions
  /// Returns true if all permissions are granted, false otherwise
  Future<bool> requestBluetoothPermissions() async {
    if (!Platform.isAndroid) {
      // iOS and other platforms handle permissions differently
      return true;
    }

    try {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      debugPrint('BluetoothPermissionHelper: Requesting Bluetooth permissions');

      // List of permissions needed for Bluetooth and thermal printer
      // For Android 12+, we need to request these runtime permissions
      final permissions = [
        Permission.bluetooth,
        Permission.bluetoothScan,
        Permission.bluetoothConnect,
        Permission.bluetoothAdvertise,
        Permission.locationWhenInUse,
      ];

      // Request all permissions at once
      final statuses = await permissions.request();

      // Check if all critical permissions are granted
      final criticalPermissions = sdkInt >= 31
          ? [
              Permission.bluetoothScan,
              Permission.bluetoothConnect,
            ]
          : [
              Permission.bluetooth,
              Permission.bluetoothScan,
              Permission.bluetoothConnect,
              Permission.locationWhenInUse,
            ];

      for (final permission in criticalPermissions) {
        final status = statuses[permission];
        debugPrint(
            'BluetoothPermissionHelper: Permission $permission status: $status');
        if (status != PermissionStatus.granted) {
          debugPrint(
              'BluetoothPermissionHelper: Required permission $permission not granted');
          return false;
        }
      }

      // Initialize thermal printer plugin after permissions granted
      await _initializeThermalPrinter();

      debugPrint('BluetoothPermissionHelper: All permissions granted');
      return true;
    } catch (e) {
      debugPrint('BluetoothPermissionHelper: Error requesting permissions: $e');
      return false;
    }
  }

  /// Initialize the thermal printer plugin
  /// This ensures the native bluetoothService is properly initialized
  Future<void> _initializeThermalPrinter() async {
    if (_initialized) {
      debugPrint(
          'BluetoothPermissionHelper: Thermal printer already initialized');
      return;
    }

    try {
      debugPrint(
          'BluetoothPermissionHelper: Initializing thermal printer plugin...');

      // Give the plugin time to initialize its native services
      await Future.delayed(const Duration(milliseconds: 500));

      // Try to get the printer manager to trigger initialization
      try {
        // This call ensures the plugin is initialized
        final _ = PrinterManager.instance;
        _initialized = true;
        debugPrint(
            'BluetoothPermissionHelper: Thermal printer plugin initialized successfully');
      } catch (e) {
        debugPrint(
            'BluetoothPermissionHelper: Warning during plugin access: $e');
        // Even if there's an error, mark as initialized to avoid repeated attempts
        _initialized = true;
      }
    } catch (e) {
      debugPrint(
          'BluetoothPermissionHelper: Error initializing thermal printer: $e');
    }
  }

  /// Check if Bluetooth permissions are already granted
  Future<bool> hasBluetoothPermissions() async {
    if (!Platform.isAndroid) {
      return true;
    }

    try {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      final sdkInt = androidInfo.version.sdkInt;
      final hasBluetoothPerm = await Permission.bluetooth.isGranted;
      final hasBluetoothScan = await Permission.bluetoothScan.isGranted;
      final hasBluetoothConnect = await Permission.bluetoothConnect.isGranted;
      final hasBluetoothAdvertise =
          await Permission.bluetoothAdvertise.isGranted;
      final hasLocation = await Permission.locationWhenInUse.isGranted;

      debugPrint(
          'BluetoothPermissionHelper: Current permissions - bluetooth: $hasBluetoothPerm, scan: $hasBluetoothScan, connect: $hasBluetoothConnect, advertise: $hasBluetoothAdvertise');

      // For Android 12+, scan/connect are required; for older, bluetooth+location
      if (sdkInt >= 31) {
        return hasBluetoothScan && hasBluetoothConnect;
      }

      return hasBluetoothPerm &&
          hasBluetoothScan &&
          hasBluetoothConnect &&
          hasLocation;
    } catch (e) {
      debugPrint('BluetoothPermissionHelper: Error checking permissions: $e');
      return false;
    }
  }

  /// Open app settings if permissions were denied
  Future<void> openAppSettings() async {
    try {
      await openAppSettings();
    } catch (e) {
      debugPrint('BluetoothPermissionHelper: Error opening app settings: $e');
    }
  }
}
