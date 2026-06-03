import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class Webview extends StatefulWidget {
  var url;
  Webview({super.key, required this.url});

  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> {
  late InAppWebViewController _webViewController;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: InAppWebView(
          initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.url))),
          onWebViewCreated: (InAppWebViewController controller) {
            _webViewController = controller;
          },
          onLoadStart: (InAppWebViewController controller, url) {
            setState(() {
              widget.url = url.toString();
            });
          },
          onLoadStop: (InAppWebViewController controller, url) async {
            setState(() {
              widget.url = url.toString();
            });
          },
          onProgressChanged: (InAppWebViewController controller, int progress) {
            setState(() {
              this.progress = progress / 100;
            });
          },
        ),
      ),
    );
  }
}
