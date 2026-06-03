import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:apnagodam/presentation/spot_order_booking_screen/service/spot_orders_response_model.dart';
import 'package:apnagodam/presentation/sbt/service/model/MatchOrderPrintModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bluetooth_printer/flutter_bluetooth_printer.dart'
    as fbp;

    
import 'package:flutter_thermal_printer/flutter_thermal_printer.dart' as ftp;
import 'package:flutter_thermal_printer/utils/printer.dart' as ftp_models;
import 'package:thermal_printer/esc_pos_utils_platform/src/capability_profile.dart';
import 'package:thermal_printer/esc_pos_utils_platform/src/enums.dart';
import 'package:thermal_printer/esc_pos_utils_platform/src/generator.dart';
import 'package:thermal_printer/esc_pos_utils_platform/src/pos_column.dart';
import 'package:thermal_printer/esc_pos_utils_platform/src/pos_styles.dart';
import 'package:thermal_printer/thermal_printer.dart';

/// Simple singleton helper to manage printer discovery, permissions and connection.
class PrinterHelper {
  PrinterHelper._internal();
  static final PrinterHelper instance = PrinterHelper._internal();

  StreamSubscription? _discoverySub;
  StreamSubscription<List<ftp_models.Printer>>? _flutterDevicesSub;
  StreamSubscription<dynamic>? _fbpDiscoverySub;
  final List<dynamic> _devices = [];
  PrinterType? _discoveryType;

  /// Exposes a read-only list of discovered devices.
  List<dynamic> get devices => List.unmodifiable(_devices);

  /// Stream controller to emit device list updates.
  final StreamController<List<dynamic>> _devicesController =
      StreamController.broadcast();

  Stream<List<dynamic>> get devicesStream => _devicesController.stream;

  bool _isConnected = false;
  String? _connectedName;
  PrinterType? _connectedType;
  dynamic _connectedDevice;

  bool get isConnected => _isConnected;

  /// Name/address of the currently connected printer, if any.
  String? get connectedName => _connectedName;

  /// Type of the currently connected printer, if any.
  PrinterType? get connectedType => _connectedType;

  String _deviceKey(dynamic device) {
    final address = device.address;
    if (address != null) return address.toString();
    final vendorId = device.vendorId?.toString() ?? '';
    final productId = device.productId?.toString() ?? '';
    final name = device.name?.toString() ?? '';
    return '$name|$vendorId|$productId';
  }

  /// Start discovery. If [clearPrevious] is true, clears previous devices list.
  /// Set [isBle] to false to use classic Bluetooth discovery (non-BLE).
  Future<void> startDiscovery({
    bool clearPrevious = true,
    bool isBle = false,
    PrinterType type = PrinterType.bluetooth,
  }) async {
    if (_discoverySub != null) {
      if (_discoveryType == type) return;
      await stopDiscovery();
    }

    if (clearPrevious) {
      _devices.clear();
      _devicesController.add(devices);
    }

    _discoveryType = type;
    if (type == PrinterType.usb) {
      debugPrint(
          'PrinterHelper: starting USB discovery via flutter_thermal_printer');
      await ftp.FlutterThermalPrinter.instance.getPrinters(
        connectionTypes: const [ftp_models.ConnectionType.USB],
      );
      await _flutterDevicesSub?.cancel();
      _flutterDevicesSub =
          ftp.FlutterThermalPrinter.instance.devicesStream.listen((devices) {
        for (final device in devices) {
          if (device.connectionType == ftp_models.ConnectionType.USB) {
            _addDevice(device);
          }
        }
      }, onError: (e) {
        debugPrint('PrinterHelper: USB discovery error: $e');
      });
      return;
    }

    debugPrint('PrinterHelper: starting discovery type=$type (isBle=$isBle)');
    _discoverySub =
        PrinterManager.instance.discovery(type: type, isBle: isBle).listen(
      (device) {
        try {
          debugPrint(
            'PrinterHelper: discovered device name=${device.name} address=${device.address}',
          );
          _addDevice(device);
        } catch (e) {
          debugPrint('PrinterHelper: discovery item handling error: $e');
        }
      },
      onError: (e) {
        debugPrint('PrinterHelper: discovery error: $e');
      },
    );

    // Also fetch paired devices directly (helps when scan stream is empty)
    if (type == PrinterType.bluetooth) {
      try {
        await _fbpDiscoverySub?.cancel();
        _fbpDiscoverySub =
            fbp.FlutterBluetoothPrinter.discovery.listen((state) {
          if (state is fbp.DiscoveryResult) {
            for (final device in state.devices) {
              _addDevice(device);
            }
          }
        }, onError: (e) {
          debugPrint('PrinterHelper: fbp discovery error: $e');
        });

        final discovered =
            await BluetoothPrinterConnector.discoverPrinters(isBle: isBle);
        for (final item in discovered) {
          final device = PrinterDevice(
            name: item.name,
            address: item.detail.address,
          );
          _addDevice(device);
        }
      } catch (e) {
        debugPrint('PrinterHelper: direct discover error: $e');
      }
    }
  }

  void _addDevice(dynamic device) {
    final key = _deviceKey(device);
    final exists = _devices.any((d) => _deviceKey(d) == key);
    if (!exists) {
      _devices.add(device);
      _devicesController.add(devices);
    }
  }

  Future<bool> sendBytesToPrint(
      List<int> bytes, PrinterType type, Datum? data) async {
    debugPrint('PrinterHelper: sendBytesToPrint called, bytes=${bytes.length}');
    if (_connectedDevice is ftp_models.Printer) {
      try {
        await ftp.FlutterThermalPrinter.instance
            .printData(_connectedDevice as ftp_models.Printer, bytes);
        debugPrint(
            'PrinterHelper: flutter_thermal_printer printData succeeded');
        return true;
      } catch (e) {
        debugPrint(
            'PrinterHelper: flutter_thermal_printer printData error: $e');
        return false;
      }
    }
    if (_connectedDevice is fbp.BluetoothDevice) {
      try {
        final device = _connectedDevice as fbp.BluetoothDevice;
        final ok = await fbp.FlutterBluetoothPrinter.printBytes(
          address: device.address,
          data: Uint8List.fromList(bytes),
          keepConnected: true,
        );
        debugPrint('PrinterHelper: fbp printBytes result: $ok');
        return ok;
      } catch (e) {
        debugPrint('PrinterHelper: fbp printBytes error: $e');
        return false;
      }
    }
    if (!_isConnected) {
      debugPrint(
        'PrinterHelper: sendBytesToPrint called but no printer connected',
      );
      // Try to send anyway and catch errors from platform.
      try {
        await PrinterManager.instance.send(type: type, bytes: bytes);
        debugPrint(
          'PrinterHelper: sendBytesToPrint succeeded (no _isConnected)',
        );
        return true;
      } catch (e) {
        debugPrint('PrinterHelper: error sending bytes (no _isConnected): $e');
        return false;
      }
    }

    try {
      await PrinterManager.instance.send(type: type, bytes: bytes);
      debugPrint('PrinterHelper: sendBytesToPrint succeeded');
      return true;
    } catch (e) {
      debugPrint('PrinterHelper: error sending bytes: $e');
      return false;
    }
  }

  /// Convenience: generate a test ticket and send it to the connected printer.
  Future<bool> printTestTicket({
    PrinterType type = PrinterType.bluetooth,
  }) async {
    return await printTestTicketWithPaper(
      type: type,
      paperSize: PaperSize.mm80,
    );
  }

  /// Helper to print with a specified [paperSize]. Returns true on success.
  Future<bool> printTestTicketWithPaper(
      {PrinterType type = PrinterType.bluetooth,
      required PaperSize paperSize,
      Datum? data}) async {
    try {
      final bytes = await testTicket(paperSize: paperSize, data: data);
      debugPrint(
        'PrinterHelper: printTestTicket - sending ${bytes.length} bytes (paperSize=$paperSize)',
      );
      final ok = await sendBytesToPrint(bytes, type, data);
      debugPrint('PrinterHelper: printTestTicket result: $ok');
      if (ok) return true;

      // Fallback: many portable 58mm printers work better with plain text
      // payloads and extra linefeeds. Try a simple UTF-8 text fallback.
      debugPrint('PrinterHelper: attempting raw-text fallback print');
      final fallbackText = 'Test Print\n\n\n\n\n\n';
      final fallbackBytes = utf8.encode(fallbackText);
      final fallbackOk = await sendBytesToPrint(fallbackBytes, type, data);
      debugPrint('PrinterHelper: fallback result: $fallbackOk');
      return fallbackOk;
    } catch (e) {
      debugPrint('PrinterHelper: printTestTicket error: $e');
      return false;
    }
  }

  /// Helper to print receipt with a specified [paperSize]. Returns true on success.
  Future<bool> printReceiptWithPaper(
      {PrinterType type = PrinterType.bluetooth,
      required PaperSize paperSize,
      required MatchOrderPrintModel printData}) async {
    try {
      final bytes =
          await receiptTicket(paperSize: paperSize, printData: printData);
      debugPrint(
        'PrinterHelper: printReceipt - sending ${bytes.length} bytes (paperSize=$paperSize)',
      );
      final ok = await sendBytesToPrint(bytes, type, null);
      debugPrint('PrinterHelper: printReceipt result: $ok');
      if (ok) return true;

      // Fallback: try a simple UTF-8 text fallback
      debugPrint('PrinterHelper: attempting raw-text fallback print');
      final fallbackText = _buildReceiptText(printData);
      final fallbackBytes = utf8.encode(fallbackText);
      final fallbackOk = await sendBytesToPrint(fallbackBytes, type, null);
      debugPrint('PrinterHelper: fallback result: $fallbackOk');
      return fallbackOk;
    } catch (e) {
      debugPrint('PrinterHelper: printReceipt error: $e');
      return false;
    }
  }

  String _buildReceiptText(MatchOrderPrintModel printData) {
    final tradeData = printData.tradeOrderData;
    if (tradeData == null) return 'No data available\n\n\n\n\n\n';

    return '''
APNA GODAM
MATCH ORDER RECEIPT
================================
Note No: ${tradeData.noteNo ?? 'N/A'}
Order Date: ${tradeData.omDate ?? 'N/A'}
Expiry Date: ${tradeData.expDate ?? 'N/A'}
================================
BUYER DETAILS
Name: ${tradeData.buyerName ?? 'N/A'}
Address: ${tradeData.buyerAdd ?? 'N/A'}
================================
SELLER DETAILS
Name: ${tradeData.sellerName ?? 'N/A'}
Address: ${tradeData.sellerAdd ?? 'N/A'}
================================
PRODUCT DETAILS
Product: ${tradeData.product ?? 'N/A'}
Rate: Rs. ${tradeData.rate ?? 0}
Quantity: ${tradeData.quantity ?? 0} Qtl.
Delivered: ${tradeData.deliverdQty ?? 0} Qtl.
Pending: ${(double.tryParse(tradeData.quantity ?? '0') ?? 0) - (double.tryParse(tradeData.deliverdQty ?? '0') ?? 0)} Qtl.
================================
Total Amount: Rs. ${((double.tryParse(tradeData.rate?.toString() ?? '0') ?? 0) * (double.tryParse(tradeData.quantity ?? '0') ?? 0)).toStringAsFixed(2)}
================================





''';
  }

  Future<void> stopDiscovery() async {
    await _discoverySub?.cancel();
    _discoverySub = null;
    await _flutterDevicesSub?.cancel();
    _flutterDevicesSub = null;
    await _fbpDiscoverySub?.cancel();
    _fbpDiscoverySub = null;
    try {
      await ftp.FlutterThermalPrinter.instance.stopScan();
    } catch (e) {
      debugPrint('PrinterHelper: stopScan error: $e');
    }
    _discoveryType = null;
  }

  Future<List<int>> testTicket(
      {PaperSize paperSize = PaperSize.mm80, Datum? data}) async {
    // Using default profile
    final profile = await CapabilityProfile.load();
    final generator = Generator(paperSize, profile);
    List<int> bytes = [];

    bytes += generator.text(
      'Apna Godam',
      styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size1,
          width: PosTextSize.size1),
      linesAfter: 1,
    );

    // Some mobile printers (58mm) may have limited cut support; keep cut but
    // callers can fallback to raw text if needed.
    bytes += generator.row([
      PosColumn(
        text: 'Buyer Name',
        width: 6,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: '',
        width: 3,
        styles: PosStyles(
            align: PosAlign.center, underline: true, height: PosTextSize.size2),
      ),
      PosColumn(
        text: '${data?.buyerUserId ?? 'N/A'}',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: 'Seller Name',
        width: 6,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: '',
        width: 3,
        styles: PosStyles(
            align: PosAlign.center, underline: true, height: PosTextSize.size2),
      ),
      PosColumn(
        text: '${data?.sellerUserId ?? 'N/A'}',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: 'Product',
        width: 6,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: '',
        width: 3,
        styles: PosStyles(
            align: PosAlign.center, underline: true, height: PosTextSize.size2),
      ),
      PosColumn(
        text: '${data?.inventory?.category?.category ?? 'N/A'}',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: 'Quantity',
        width: 6,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: '',
        width: 3,
        styles: PosStyles(
            align: PosAlign.center, underline: true, height: PosTextSize.size2),
      ),
      PosColumn(
        text: '${data?.inventory?.quantity ?? 'N/A'}',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: 'Rate',
        width: 3,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: '',
        width: 3,
        styles: PosStyles(
            align: PosAlign.center, underline: true, height: PosTextSize.size2),
      ),
      PosColumn(
        text: '${data?.inventory?.price ?? 'N/A'} / Qtl.',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);
    bytes += generator.row([
      PosColumn(
        text: 'Total Amount',
        width: 6,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: '',
        width: 3,
        styles: PosStyles(
            align: PosAlign.center, underline: true, height: PosTextSize.size2),
      ),
      PosColumn(
        text:
            '${num.parse("${data?.inventory?.price ?? '0'}") * num.parse("${data?.inventory?.quantity ?? '0'}")}',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Date of Order',
        width: 6,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: '',
        width: 3,
        styles: PosStyles(
            align: PosAlign.center, underline: true, height: PosTextSize.size2),
      ),
      PosColumn(
        text: '${data?.acceptTime ?? '0'}',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Order Expiry \nDate',
        width: 8,
        styles: PosStyles(align: PosAlign.left, underline: true),
      ),
      PosColumn(
        text: '',
        width: 1,
        styles: PosStyles(
            align: PosAlign.center, underline: true, height: PosTextSize.size2),
      ),
      PosColumn(
        text: '${data?.intentionExpiryDate ?? '0'}',
        width: 3,
        styles: PosStyles(align: PosAlign.right, underline: true),
      ),
    ]);
    bytes += generator.cut();
    return bytes;
  }

  Future<List<int>> receiptTicket(
      {PaperSize paperSize = PaperSize.mm58,
      required MatchOrderPrintModel printData}) async {
    final profile = await CapabilityProfile.load();
    final generator = Generator(paperSize, profile);
    List<int> bytes = [];

    final tradeData = printData.tradeOrderData;
    if (tradeData == null) {
      bytes += generator.text('No data available', linesAfter: 5);
      bytes += generator.cut();
      return bytes;
    }

    // Header
    bytes += generator.text(
      'Sauda Bahi',
      styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size2,
          width: PosTextSize.size2,
          bold: true),
      linesAfter: 1,
    );

    bytes += generator.text(
      'ORDER MATCH RECEIPT',
      styles: PosStyles(
          align: PosAlign.center,
          height: PosTextSize.size1,
          width: PosTextSize.size1,
          bold: true),
      linesAfter: 1,
    );

    bytes += generator.hr();

    // Order Info
    bytes += generator.row([
      PosColumn(
        text: 'Note No:',
        width: 4,
        styles: PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        text: '${tradeData.noteNo ?? 'N/A'}',
        width: 8,
        styles: PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Order Date:',
        width: 6,
        styles: PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        text: '${tradeData.omDate ?? 'N/A'}',
        width: 6,
        styles: PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Expiry Date:',
        width: 6,
        styles: PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        text: '${tradeData.expDate ?? 'N/A'}',
        width: 6,
        styles: PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.hr();

    // Buyer Details
    bytes += generator.text(
      'BUYER DETAILS',
      styles: PosStyles(align: PosAlign.left, bold: true, underline: true),
      linesAfter: 1,
    );

    bytes += generator.text(
      'Name: ${tradeData.buyerName ?? 'N/A'}',
      styles: PosStyles(align: PosAlign.left),
    );

    bytes += generator.text(
      'Address: ${tradeData.buyerAdd ?? 'N/A'}',
      styles: PosStyles(align: PosAlign.left),
      linesAfter: 1,
    );

    bytes += generator.hr();

    // Seller Details
    bytes += generator.text(
      'SELLER DETAILS',
      styles: PosStyles(align: PosAlign.left, bold: true, underline: true),
      linesAfter: 1,
    );

    bytes += generator.text(
      'Name: ${tradeData.sellerName ?? 'N/A'}',
      styles: PosStyles(align: PosAlign.left),
    );

    bytes += generator.text(
      'Address: ${tradeData.sellerAdd ?? 'N/A'}',
      styles: PosStyles(align: PosAlign.left),
      linesAfter: 1,
    );

    bytes += generator.hr();

    // Product Details
    bytes += generator.text(
      'PRODUCT DETAILS',
      styles: PosStyles(align: PosAlign.left, bold: true, underline: true),
      linesAfter: 1,
    );

    bytes += generator.text(
      'Product: ${tradeData.product ?? 'N/A'}',
      styles: PosStyles(align: PosAlign.left),
    );

    bytes += generator.row([
      PosColumn(
        text: 'Rate:',
        width: 6,
        styles: PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        text: 'Rs. ${tradeData.rate ?? 0} /Qtl.',
        width: 6,
        styles: PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Quantity:',
        width: 6,
        styles: PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        text: '${tradeData.quantity ?? 0} Qtl.',
        width: 6,
        styles: PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.row([
      PosColumn(
        text: 'Delivered:',
        width: 6,
        styles: PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        text: '${tradeData.deliverdQty ?? 0} Qtl.',
        width: 6,
        styles: PosStyles(align: PosAlign.right),
      ),
    ]);

    final pendingQty = (double.tryParse(tradeData.quantity ?? '0') ?? 0) -
        (double.tryParse(tradeData.deliverdQty ?? '0') ?? 0);
    bytes += generator.row([
      PosColumn(
        text: 'Pending:',
        width: 6,
        styles: PosStyles(align: PosAlign.left, bold: true),
      ),
      PosColumn(
        text: '${pendingQty.toStringAsFixed(2)} Qtl.',
        width: 6,
        styles: PosStyles(align: PosAlign.right),
      ),
    ]);

    bytes += generator.hr();

    // Total
    final totalAmount =
        ((double.tryParse(tradeData.rate?.toString() ?? '0') ?? 0) *
                (double.tryParse(tradeData.quantity ?? '0') ?? 0))
            .toStringAsFixed(2);
    bytes += generator.row([
      PosColumn(
        text: 'Total Amount:',
        width: 6,
        styles: PosStyles(
          align: PosAlign.left,
          bold: true,
        ),
      ),
      PosColumn(
        text: 'Rs. $totalAmount',
        width: 6,
        styles: PosStyles(
          align: PosAlign.right,
          bold: true,
        ),
      ),
    ]);

    bytes += generator.hr();
    bytes += generator.text('Thank you!',
        styles: PosStyles(align: PosAlign.center), linesAfter: 2);

    bytes += generator.cut();
    return bytes;
  }

  Future<bool> connect(
    dynamic device, {
    bool isBle = true,
    PrinterType type = PrinterType.bluetooth,
  }) async {
    if (device == null) return false;
    try {
      debugPrint(
        'PrinterHelper: attempting connect to ${device.name ?? device.address} type=$type isBle=$isBle',
      );
      if (device is ftp_models.Printer) {
        final ok = await ftp.FlutterThermalPrinter.instance.connect(device);
        _isConnected = ok;
        _connectedName = device.name ?? device.address;
        _connectedType = type;
        _connectedDevice = device;
        debugPrint('PrinterHelper: flutter_thermal_printer connect => $ok');
        return ok;
      }
      if (device is fbp.BluetoothDevice) {
        final ok = await fbp.FlutterBluetoothPrinter.connect(device.address);
        _isConnected = ok;
        _connectedName = device.name ?? device.address;
        _connectedType = type;
        _connectedDevice = device;
        debugPrint('PrinterHelper: fbp connect => $ok');
        return ok;
      }
      if (type == PrinterType.bluetooth) {
        if (device.address == null) return false;
        await PrinterManager.instance.connect(
          type: PrinterType.bluetooth,
          model: BluetoothPrinterInput(
            name: device.name,
            address: device.address,
            isBle: isBle,
            autoConnect: true,
          ),
        );
      } else if (type == PrinterType.usb) {
        if (Platform.isAndroid &&
            (device.vendorId == null || device.productId == null)) {
          debugPrint('PrinterHelper: USB device missing vendor/product id');
          return false;
        }
        if (Platform.isWindows && (device.name == null)) {
          debugPrint('PrinterHelper: USB device missing name on Windows');
          return false;
        }
        await PrinterManager.instance.connect(
          type: PrinterType.usb,
          model: UsbPrinterInput(
            name: device.name,
            vendorId: device.vendorId?.toString(),
            productId: device.productId?.toString(),
          ),
        );
      } else {
        debugPrint('PrinterHelper: unsupported printer type $type');
        return false;
      }
      debugPrint('PrinterHelper: connect call returned');
      _isConnected = true;
      _connectedName = device.name ?? device.address;
      _connectedType = type;
      _connectedDevice = device;
      debugPrint('PrinterHelper: marked connected => $_connectedName');
      return true;
    } catch (e) {
      debugPrint('PrinterHelper: connect error $e');
      return false;
    }
  }

  Future<void> disconnect({PrinterType? type}) async {
    try {
      debugPrint('PrinterHelper: disconnecting');
      if (_connectedDevice is fbp.BluetoothDevice) {
        final device = _connectedDevice as fbp.BluetoothDevice;
        await fbp.FlutterBluetoothPrinter.disconnect(device.address);
      }
      if (_connectedDevice is ftp_models.Printer) {
        await ftp.FlutterThermalPrinter.instance
            .disconnect(_connectedDevice as ftp_models.Printer);
      } else {
        await PrinterManager.instance.disconnect(
          type: type ?? _connectedType ?? PrinterType.bluetooth,
        );
      }
    } catch (e) {
      debugPrint('PrinterHelper: disconnect error $e');
    }
    _isConnected = false;
    _connectedName = null;
    _connectedType = null;
    _connectedDevice = null;
  }

  void dispose() {
    _devicesController.close();
    _discoverySub?.cancel();
    _discoverySub = null;
  }
}
