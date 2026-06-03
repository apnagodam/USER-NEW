import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FinanceScreen extends ConsumerStatefulWidget {
  const FinanceScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends ConsumerState<FinanceScreen> {
  late InAppWebViewController _webViewController;
  double _progress = 0; // Track loading progress

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Finance",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color(0xFF12281B), // Deep green-black
                Color(0xFF275135), // Your main green
                Color(0xFF3E7251),
              ])),
        ),
        centerTitle: true,
        elevation: 2,
        backgroundColor: ColorConstant.maingreen,
      ),
      body: Column(
        children: [
          // Progress bar
          _progress < 1.0
              ? LinearProgressIndicator(
                  value: _progress,
                  minHeight: 4,
                  backgroundColor: ColorConstant.maingreen.withOpacity(0.2),
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ColorConstant.maingreen),
                )
              : const SizedBox(height: 4),

          // WebView
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                url: WebUri.uri(
                  Uri.parse('https://apnagodamfinance.com/dashboard'),
                ),
              ),
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                thirdPartyCookiesEnabled: true,
                clearCache: false,
              ),
              onWebViewCreated: (controller) {
                _webViewController = controller;
              },
              onLoadStart: (controller, url) {
                setState(() {
                  _progress = 0;
                });
              },
              onProgressChanged: (controller, progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
              onLoadStop: (controller, url) async {
                debugPrint(url.toString());
                setState(() {
                  _progress = 1.0;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
