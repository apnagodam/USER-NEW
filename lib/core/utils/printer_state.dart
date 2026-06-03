import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'printer_helper.dart';
import 'bluetooth_permission_helper.dart';
import 'package:thermal_printer/thermal_printer.dart';

class PrinterUiState {
  final List<dynamic> devices;
  final bool isConnected;
  final String? connectedName;
  final bool isScanning;
  final PrinterType selectedType;

  const PrinterUiState({
    this.devices = const [],
    this.isConnected = false,
    this.connectedName,
    this.isScanning = false,
    this.selectedType = PrinterType.bluetooth,
  });

  PrinterUiState copyWith({
    List<dynamic>? devices,
    bool? isConnected,
    String? connectedName,
    bool? isScanning,
    PrinterType? selectedType,
  }) {
    return PrinterUiState(
      devices: devices ?? this.devices,
      isConnected: isConnected ?? this.isConnected,
      connectedName: connectedName ?? this.connectedName,
      isScanning: isScanning ?? this.isScanning,
      selectedType: selectedType ?? this.selectedType,
    );
  }
}

class PrinterStateNotifier extends StateNotifier<PrinterUiState> {
  PrinterStateNotifier() : super(const PrinterUiState()) {
    _devicesSub = PrinterHelper.instance.devicesStream.listen((devices) {
      state = state.copyWith(
        devices: devices,
        isConnected: PrinterHelper.instance.isConnected,
        connectedName: PrinterHelper.instance.connectedName,
      );
    });
  }

  StreamSubscription<List<dynamic>>? _devicesSub;

  Future<void> startDiscovery({
    bool clearPrevious = true,
    bool isBle = false,
    PrinterType type = PrinterType.bluetooth,
  }) async {
    state = state.copyWith(isScanning: true, selectedType: type);

    if (type == PrinterType.usb) {
      await PrinterHelper.instance.startDiscovery(
        clearPrevious: clearPrevious,
        isBle: false,
        type: type,
      );
      await Future.delayed(const Duration(milliseconds: 800));
      return;
    }

    // Reset initialization to ensure fresh start for discovery
    BluetoothPermissionHelper.instance.resetInitialization();

    // Request Bluetooth permissions before starting discovery
    final hasPermissions =
        await BluetoothPermissionHelper.instance.requestBluetoothPermissions();

    if (!hasPermissions) {
      state = state.copyWith(isScanning: false);
      return;
    }

    // Give plugin time to initialize after permission grant (increased for Android 12+)
    await Future.delayed(const Duration(milliseconds: 1000));

    await PrinterHelper.instance.startDiscovery(
      clearPrevious: clearPrevious,
      isBle: isBle,
      type: type,
    );

    // Wait for initial devices to appear (increased for Android 12+ discovery)
    await Future.delayed(const Duration(milliseconds: 2000));

    // Fallback to BLE scan if classic Bluetooth finds nothing
    if (type == PrinterType.bluetooth && !isBle && state.devices.isEmpty) {
      await PrinterHelper.instance.stopDiscovery();
      await Future.delayed(const Duration(milliseconds: 400));
      await PrinterHelper.instance.startDiscovery(
        clearPrevious: false,
        isBle: true,
        type: type,
      );
      await Future.delayed(const Duration(milliseconds: 2000));
    }
  }

  Future<void> stopDiscovery() async {
    await PrinterHelper.instance.stopDiscovery();
    BluetoothPermissionHelper.instance.resetInitialization();
    state = state.copyWith(isScanning: false);
  }

  Future<bool> connect(
    dynamic device, {
    bool isBle = false,
    PrinterType type = PrinterType.bluetooth,
  }) async {
    if (type != PrinterType.usb) {
      // Ensure permissions are granted before attempting connection
      final hasPermissions =
          await BluetoothPermissionHelper.instance.hasBluetoothPermissions();
      if (!hasPermissions) {
        final granted = await BluetoothPermissionHelper.instance
            .requestBluetoothPermissions();
        if (!granted) {
          return false;
        }
      }
    }

    // Give plugin time to initialize/stabilize before connecting (increased for Android 12+)
    await Future.delayed(const Duration(milliseconds: 1200));

    final ok = await PrinterHelper.instance.connect(
      device,
      isBle: isBle,
      type: type,
    );
    state = state.copyWith(
      isConnected: PrinterHelper.instance.isConnected,
      connectedName: PrinterHelper.instance.connectedName,
      selectedType: type,
    );
    return ok;
  }

  Future<void> disconnect({PrinterType? type}) async {
    await PrinterHelper.instance.disconnect(type: type);
    state = state.copyWith(
      isConnected: PrinterHelper.instance.isConnected,
      connectedName: PrinterHelper.instance.connectedName,
    );
  }

  @override
  void dispose() {
    _devicesSub?.cancel();
    super.dispose();
  }
}

final printerStateProvider =
    StateNotifierProvider<PrinterStateNotifier, PrinterUiState>(
  (ref) {
    final notifier = PrinterStateNotifier();
    ref.onDispose(notifier.dispose);
    return notifier;
  },
);
