import 'dart:convert';
import 'package:apnagodam/core/constants/constants.dart';
import 'package:http/http.dart' as http;
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Fetches live market data from the Apna Godam backend
/// and formats it as a plain text summary for Claude's context.
class MarketDataFetcher {
  /// Fetches WBT (warehouse-based trading) sell/buy rates
  /// and SBT commodity rates, then returns a human-readable summary.
  static Future<String> fetchLiveMarketSummary({
    String? authToken,
  }) async {
    final buffer = StringBuffer();

    try {
      // 1. Fetch WBT market rates (sell_buy_list)
      final wbtData = await _fetchWbt(authToken: authToken);
      if (wbtData.isNotEmpty) {
        buffer.writeln('=== WBT Market Rates (Warehouse Based Trading) ===');
        buffer.writeln(wbtData);
        buffer.writeln();
      }

      // 2. Fetch SBT commodity rates
      final sbtData = await _fetchSbt();
      if (sbtData.isNotEmpty) {
        buffer.writeln('=== SBT Market Rates (Stock Based Trading) ===');
        buffer.writeln(sbtData);
        buffer.writeln();
      }

      // 3. Fetch Mandi Bhav
      final mandiBhav = await _fetchMandiBhav();
      if (mandiBhav.isNotEmpty) {
        buffer.writeln('=== Mandi Bhav (Spot Rates) ===');
        buffer.writeln(mandiBhav);
      }
    } catch (e) {
      buffer.writeln('Note: Could not fetch some market data. Partial data may be available.');
    }

    final result = buffer.toString().trim();
    return result.isEmpty
        ? 'No live market data available at this time.'
        : result;
  }

  static Future<String> _fetchWbt({String? authToken}) async {
    try {
      final uri = Uri.parse(APNA_WAREHOUSE_LIST);
      final headers = <String, String>{
        'Content-Type': 'application/json',
        if (authToken != null && authToken.isNotEmpty)
          'Authorization': 'Bearer $authToken',
      };
      final response = await http
          .get(uri, headers: headers)
          .timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _parseWbtData(data);
      }
    } catch (_) {}
    return '';
  }

  static String _parseWbtData(dynamic data) {
    final sb = StringBuffer();
    try {
      final items = data['data'] as List?;
      if (items == null || items.isEmpty) return '';
      for (final item in items.take(20)) {
        final commodity = item['commodity_name'] ?? item['commodityName'] ?? '';
        final warehouse = item['warehouse_name'] ?? item['warehouseName'] ?? '';
        final buyerPrice = item['best_buyer_price'] ?? item['bestBuyerPrice'] ?? 0;
        final sellerPrice = item['seller_price'] ?? item['sellerPrice'] ?? 0;
        final bidTime = item['bid_time'] ?? '';
        if (commodity.toString().isNotEmpty) {
          sb.writeln(
              '$commodity | Warehouse: $warehouse | Best Buy: ₹$buyerPrice/qtl | Seller: ₹$sellerPrice/qtl | Bid Time: $bidTime');
        }
      }
    } catch (_) {}
    return sb.toString();
  }

  static Future<String> _fetchSbt() async {
    try {
      final uri = Uri.parse(SBT_BUYER_SELLER);
      final response =
          await http.get(uri).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _parseSbtData(data);
      }
    } catch (_) {}
    return '';
  }

  static String _parseSbtData(dynamic data) {
    final sb = StringBuffer();
    try {
      final items = data['data'] as List?;
      if (items == null || items.isEmpty) return '';
      for (final item in items.take(15)) {
        final commodity = item['commodity_name'] ?? item['product_name'] ?? '';
        final buyerPrice = item['buyer_price'] ?? item['best_buyer_price'] ?? 0;
        final sellerPrice = item['seller_price'] ?? 0;
        final lastPrice = item['last_trade_price'] ?? 0;
        if (commodity.toString().isNotEmpty) {
          sb.writeln(
              '$commodity | SBT Buy: ₹$buyerPrice/qtl | SBT Sell: ₹$sellerPrice/qtl | Last Trade: ₹$lastPrice/qtl');
        }
      }
    } catch (_) {}
    return sb.toString();
  }

  static Future<String> _fetchMandiBhav() async {
    try {
      final uri = Uri.parse(MANDIBHAV);
      final response =
          await http.get(uri).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return _parseMandiBhav(data);
      }
    } catch (_) {}
    return '';
  }

  static String _parseMandiBhav(dynamic data) {
    final sb = StringBuffer();
    try {
      final items = data['data'] as List?;
      if (items == null || items.isEmpty) return '';
      for (final item in items.take(15)) {
        final commodity = item['commodity'] ?? item['commodity_name'] ?? '';
        final market = item['market'] ?? item['mandi_name'] ?? '';
        final minPrice = item['min_price'] ?? item['minPrice'] ?? 0;
        final maxPrice = item['max_price'] ?? item['maxPrice'] ?? 0;
        final modalPrice = item['modal_price'] ?? item['modalPrice'] ?? 0;
        if (commodity.toString().isNotEmpty) {
          sb.writeln(
              '$commodity | Mandi: $market | Min: ₹$minPrice | Max: ₹$maxPrice | Modal: ₹$modalPrice');
        }
      }
    } catch (_) {}
    return sb.toString();
  }
}
