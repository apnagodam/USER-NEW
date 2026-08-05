import 'dart:convert';
import 'package:apnagodam/core/constants/constants.dart';
import 'package:http/http.dart' as http;

/// Fetches live market data from the Apna Godam backend
/// (including WBT, SBT product list, SBT buyer/seller, and SbtLiveBidData)
/// and formats it as a plain text summary for AI context.
class MarketDataFetcher {
  /// Fetches all live market rates and returns a structured summary.
  static Future<String> fetchLiveMarketSummary({
    String? authToken,
  }) async {
    final buffer = StringBuffer();

    try {
      // 1. Fetch SbtLiveBidData (POST Endpoint)
      final liveBidData = await _fetchSbtLiveBidData();
      if (liveBidData.isNotEmpty) {
        buffer.writeln(liveBidData);
        buffer.writeln();
      }

      // 2. Fetch WBT market rates (sell_buy_list)
      final wbtData = await _fetchWbt(authToken: authToken);
      if (wbtData.isNotEmpty) {
        buffer.writeln('=== WBT Market Rates (Warehouse Based Trading) ===');
        buffer.writeln(wbtData);
        buffer.writeln();
      }

      // 3. Fetch SBT commodity rates
      final sbtData = await _fetchSbt();
      if (sbtData.isNotEmpty) {
        buffer.writeln('=== SBT Market Rates (Stock Based Trading) ===');
        buffer.writeln(sbtData);
        buffer.writeln();
      }

      // 4. Fetch Mandi Bhav
      final mandiBhav = await _fetchMandiBhav();
      if (mandiBhav.isNotEmpty) {
        buffer.writeln('=== Mandi Bhav (Spot Rates) ===');
        buffer.writeln(mandiBhav);
      }
    } catch (e) {
      buffer.writeln('Note: Could not fetch some market data.');
    }

    final result = buffer.toString().trim();
    return result.isEmpty
        ? 'No live market data available at this time.'
        : result;
  }

  /// POST Request to SbtLiveBidData endpoint
  static Future<String> _fetchSbtLiveBidData() async {
    try {
      final uri = Uri.parse('https://demoaws.apnagodam.com/sbt_api/SbtLiveBidData');
      final response = await http.post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({}),
      ).timeout(const Duration(seconds: 8));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['status'] == '1' || data['status'] == 1) {
          final bidData = data['BidData'];
          if (bidData != null && bidData is Map) {
            final sb = StringBuffer();
            sb.writeln('=== SbtLiveBidData (Live Bids) ===');

            final buyList = bidData['buy'] as List?;
            if (buyList != null && buyList.isNotEmpty) {
              for (final b in buyList) {
                final c = b['commodity'] ?? '';
                final p = b['price'] ?? 0;
                final district = b['districtName'] ?? '';
                final pin = b['Pincode'] ?? '';
                if (c.toString().isNotEmpty) {
                  sb.writeln('फसल: $c | भाव: ₹$p | जिला: $district | पिनकोड: $pin | प्रकार: Buy');
                }
              }
            }

            final sellList = bidData['sell'] as List?;
            if (sellList != null && sellList.isNotEmpty) {
              for (final s in sellList) {
                final c = s['commodity'] ?? '';
                final p = s['price'] ?? 0;
                final district = s['districtName'] ?? '';
                final pin = s['Pincode'] ?? '';
                if (c.toString().isNotEmpty) {
                  sb.writeln('फसल: $c | भाव: ₹$p | जिला: $district | पिनकोड: $pin | प्रकार: Sell');
                }
              }
            }
            return sb.toString();
          }
        }
      }
    } catch (_) {}
    return '';
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
              'फसल: $commodity | Warehouse: $warehouse | Best Buy: ₹$buyerPrice | Seller: ₹$sellerPrice | Bid Time: $bidTime');
        }
      }
    } catch (_) {}
    return sb.toString();
  }

  static Future<String> _fetchSbt({String? authToken}) async {
    final sb = StringBuffer();
    // 1. Fetch sbt_product_list
    try {
      final uri = Uri.parse(SBT_COMMODITY_LIST);
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
        final items = data['data'] as List?;
        if (items != null && items.isNotEmpty) {
          sb.writeln('--- SBT Product List ---');
          for (final item in items) {
            final commodity = item['commodity'] ?? item['commodity_name'] ?? '';
            final ltp = item['ltp'];
            final upper = item['upper_circuit'] ?? '';
            final lower = item['lower_circuit'] ?? '';
            final district = item['district'] ?? '';
            final date = item['date'] ?? '';
            if (commodity.toString().isNotEmpty) {
              sb.writeln(
                  'फसल: $commodity | भाव: ₹${ltp ?? 'N/A'} | सर्किट: ₹$lower - ₹$upper | स्थान: $district | समय: $date');
            }
          }
        }
      }
    } catch (_) {}

    // 2. Fetch sbt_trade_list
    try {
      final uri = Uri.parse(SBT_BUYER_SELLER);
      final response =
          await http.get(uri).timeout(const Duration(seconds: 8));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final items = data['data'] as List?;
        if (items != null && items.isNotEmpty) {
          sb.writeln('--- SBT Trade List ---');
          for (final item in items.take(15)) {
            final commodity = item['commodity_name'] ?? item['product_name'] ?? '';
            final buyerPrice = item['buyer_price'] ?? item['best_buyer_price'] ?? 0;
            final sellerPrice = item['seller_price'] ?? 0;
            final lastPrice = item['last_trade_price'] ?? 0;
            if (commodity.toString().isNotEmpty) {
              sb.writeln(
                  'फसल: $commodity | भाव: ₹$buyerPrice | विक्रेता भाव: ₹$sellerPrice | अंतिम सौदा: ₹$lastPrice');
            }
          }
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
              'फसल: $commodity | Mandi: $market | भाव: ₹$modalPrice | Min: ₹$minPrice | Max: ₹$maxPrice');
        }
      }
    } catch (_) {}
    return sb.toString();
  }
}
