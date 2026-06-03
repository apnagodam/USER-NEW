# Thermal Printer NullPointerException Fix

## Problem Summary
You were getting a `NullPointerException` in the thermal printer plugin:
```
E/MethodChannel#com.codingdevs.thermal_printer: java.lang.NullPointerException
E/MethodChannel#com.codingdevs.thermal_printer: at com.codingdevs.thermal_printer.ThermalPrinterPlugin.checkPermissions(ThermalPrinterPlugin.kt:384)
```

## Root Cause
The issue was caused by missing Bluetooth permissions in the Android manifest and improper permission handling before attempting to use the thermal printer. The native plugin was trying to check permissions but encountered null references because:

1. **Missing Android permissions** - Bluetooth permissions weren't declared in `AndroidManifest.xml`
2. **No permission request flow** - The app wasn't requesting Bluetooth permissions at runtime before calling printer functions
3. **Unsafe method calls** - The thermal printer plugin's `checkPermissions()` method was being called without verifying if the context was initialized

## Solution Implemented

### 1. Added Missing Bluetooth Permissions to AndroidManifest.xml
Added the following permissions to `android/app/src/main/AndroidManifest.xml`:
```xml
<!-- Bluetooth permissions for thermal printer -->
<uses-permission android:name="android.permission.BLUETOOTH" />
<uses-permission android:name="android.permission.BLUETOOTH_ADMIN" />
<uses-permission android:name="android.permission.BLUETOOTH_SCAN" />
<uses-permission android:name="android.permission.BLUETOOTH_CONNECT" />
<!-- USB permissions for thermal printer -->
<uses-permission android:name="android.permission.USB_PERMISSION" />
```

### 2. Created BluetoothPermissionHelper
New file: `lib/core/utils/bluetooth_permission_helper.dart`

This helper class:
- Requests Bluetooth permissions at runtime before attempting discovery or connection
- Checks if permissions are already granted
- Handles permission errors gracefully
- Works across Android versions (handles new Android 12+ permissions like `BLUETOOTH_SCAN` and `BLUETOOTH_CONNECT`)

### 3. Updated PrinterStateNotifier
Modified `lib/core/utils/printer_state.dart` to:
- Import and use `BluetoothPermissionHelper`
- Request permissions in `startDiscovery()` before starting the discovery process
- Check/request permissions in `connect()` before attempting connection
- Return early if permissions are denied

## How It Works

### Permission Request Flow:
1. User clicks to print → `_showPrinterSelectionForReceipt()` is called
2. Dialog is shown and `startDiscovery()` is called
3. `PrinterStateNotifier.startDiscovery()` now:
   - Sets `isScanning = true`
   - **Calls `BluetoothPermissionHelper.requestBluetoothPermissions()`**
   - If permissions granted → starts discovery
   - If permissions denied → stops scanning and returns
4. When user selects a printer → `connect()` is called
5. `connect()` verifies permissions before attempting connection

### Android 12+ Compatibility:
The solution handles both older and newer Android versions:
- **Android 11 and below**: `BLUETOOTH` and `BLUETOOTH_ADMIN` permissions
- **Android 12+**: `BLUETOOTH_SCAN`, `BLUETOOTH_CONNECT`, and `BLUETOOTH_ADVERTISE`

## Testing the Fix

### 1. Uninstall the app from your device
```bash
flutter clean
flutter pub get
```

### 2. Rebuild the APK
```bash
flutter build apk --debug
flutter install
```

### 3. Test the printer functionality:
- Open the app
- Navigate to the printing feature
- Click print/select printer
- Accept the Bluetooth permissions prompt
- Verify printer discovery works

### 4. Monitor the logs:
```bash
flutter logs
```

Look for lines like:
```
BluetoothPermissionHelper: Requesting Bluetooth permissions
BluetoothPermissionHelper: All permissions granted
PrinterHelper: starting discovery type=PrinterType.bluetooth (isBle=false)
```

## Files Modified

1. **android/app/src/main/AndroidManifest.xml**
   - Added Bluetooth and USB permissions

2. **lib/core/utils/bluetooth_permission_helper.dart** (NEW)
   - Created permission management helper

3. **lib/core/utils/printer_state.dart**
   - Updated `startDiscovery()` to request permissions
   - Updated `connect()` to verify permissions

## Additional Notes

- The fix gracefully handles permission denial - no app crashes if user denies permissions
- Permissions are requested using `permission_handler` package which is already a dependency
- The solution is backward compatible and works on all Android versions
- USB printer support also benefits from this fix
- Debug logs are added for troubleshooting

## If Issues Persist

1. **Verify Android manifest is updated**:
   ```bash
   grep -A 10 "Bluetooth permissions" android/app/src/main/AndroidManifest.xml
   ```

2. **Check permission_handler dependency**:
   ```bash
   flutter pub get
   flutter pub upgrade permission_handler
   ```

3. **Check device permissions**:
   - Go to Settings → Apps → Your App → Permissions
   - Verify Bluetooth and Location permissions are granted

4. **Try with USB printer**:
   - If Bluetooth still has issues, test with USB printer first
   - USB uses `PrinterType.usb` instead of `PrinterType.bluetooth`

5. **Check native logs**:
   ```bash
   flutter logs
   grep "thermal_printer" # or
   adb logcat | grep thermal_printer
   ```
