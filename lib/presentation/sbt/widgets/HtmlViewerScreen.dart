import 'dart:io';

import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:dio/dio.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:file_saver/file_saver.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HtmlViewerScreen extends ConsumerStatefulWidget {
  final String? htmlContent;
  final String? pdfUrl;
  final String? authToken;
  final String title;

  const HtmlViewerScreen({
    super.key,
    this.htmlContent,
    this.pdfUrl,
    this.authToken,
    this.title = 'PDF View',
  });

  @override
  ConsumerState<HtmlViewerScreen> createState() => _HtmlViewerScreenState();
}

class _HtmlViewerScreenState extends ConsumerState<HtmlViewerScreen> {
  late WebViewController _webViewController;
  double progress = 0;
  String? _loadError;
  bool _hasSource = false;
  String? _authToken;
  final Set<String> _authorizedUrls = {};
  bool _downloadingPdf = false;
  double _downloadProgress = 0.0;
  Future<PDFDocument?>? _pdfFuture;
  File? _downloadedPdfFile;

  @override
  void initState() {
    super.initState();
    _authToken = widget.authToken ?? ref.read(sharedUtilityProvider).getToken();
    debugPrint('WebView auth token length: ${_authToken?.length ?? 0}');
    _hasSource = widget.pdfUrl != null || widget.htmlContent != null;
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onNavigationRequest: (request) {
            debugPrint('WebView nav: ${request.url}');
            if (_authToken != null && _authToken!.isNotEmpty) {
              final url = request.url;
              if (url.isNotEmpty && !_authorizedUrls.contains(url)) {
                _authorizedUrls.add(url);
                _webViewController.loadRequest(
                  Uri.parse(url),
                  headers: {'Authorization': _authToken!},
                );
                return NavigationDecision.prevent;
              }
            }
            return NavigationDecision.navigate;
          },
          onUrlChange: (change) {
            debugPrint('WebView url change: ${change.url}');
          },
          onProgress: (value) {
            setState(() {
              progress = value / 100;
            });
          },
          onPageStarted: (_) {
            setState(() {
              progress = 0;
              _loadError = null;
            });
          },
          onPageFinished: (_) {
            setState(() {
              progress = 1.0;
            });
          },
          onWebResourceError: (error) {
            setState(() {
              _loadError = 'Load error: ${error.description}';
            });
          },
        ),
      );

    _loadInitialContent();

    if (!_hasSource) {
      _loadError = 'No URL or HTML content provided.';
    }
  }

  Future<void> _loadInitialContent() async {
    if (widget.htmlContent != null) {
      _webViewController.loadHtmlString(widget.htmlContent!);
      return;
    }
    if (widget.pdfUrl != null) {
      final headers = (_authToken != null && _authToken!.isNotEmpty)
          ? {'Authorization': _authToken!}
          : <String, String>{};
      final url = widget.pdfUrl!;
      debugPrint('WebView initial url: $url');
      debugPrint(
          'WebView auth header set: ${headers.containsKey('Authorization')}');

      setState(() {
        _loadError = null;
      });

      _pdfFuture = _downloadPdfToTemp(url, headers);
    }
  }

  Future<PDFDocument?> _downloadPdfToTemp(
    String url,
    Map<String, String> headers,
  ) async {
    if (headers.isEmpty) {
      setState(() {
        _loadError = 'Missing authorization token.';
      });
      return null;
    }
    setState(() {
      _downloadingPdf = true;
      _downloadProgress = 0.0;
      _loadError = null;
    });
    try {
      // Get the external storage directory for Android or documents directory for iOS
      Directory? directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      if (directory == null) {
        throw Exception('Could not access storage directory');
      }

      // Create Documents folder if it doesn't exist
      final documentsDir = Directory('${directory.path}/Documents');
      if (!await documentsDir.exists()) {
        await documentsDir.create(recursive: true);
      }

      final file = File(
        '${documentsDir.path}/order_${DateTime.now().millisecondsSinceEpoch}.pdf',
      );
      final dio = Dio();
      await dio.download(
        url,
        file.path,
        options: Options(headers: headers),
        onReceiveProgress: (received, total) {
          if (total > 0) {
            setState(() {
              _downloadProgress = received / total;
            });
          }
        },
      );

      setState(() {
        _downloadedPdfFile = file;
      });

      return PDFDocument.fromFile(file);
    } catch (e) {
      setState(() {
        _loadError = 'PDF download failed: $e';
      });
      return null;
    } finally {
      if (mounted) {
        setState(() {
          _downloadingPdf = false;
        });
      }
    }
  }

 Future<void> _savePdfToDownloads() async {
  if (_downloadedPdfFile == null || !await _downloadedPdfFile!.exists()) {
    Fluttertoast.showToast(
      msg: "PDF file not found",
      toastLength: Toast.LENGTH_SHORT,
    );
    return;
  }

  try {
    // Copy to Downloads folder (works on Android without file_saver)
    final downloadsDir = Directory('/storage/emulated/0/Download');
    if (!await downloadsDir.exists()) {
      await downloadsDir.create(recursive: true);
    }

    final fileName = 'order_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final destFile = File('${downloadsDir.path}/$fileName');
    await _downloadedPdfFile!.copy(destFile.path);

    Fluttertoast.showToast(
      msg: "PDF saved to Downloads/$fileName",
      toastLength: Toast.LENGTH_LONG,
    );
  } catch (e) {
    Fluttertoast.showToast(
      msg: "Error saving PDF: $e",
      toastLength: Toast.LENGTH_LONG,
    );
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (widget.pdfUrl != null && _downloadedPdfFile != null)
            IconButton(
              icon: const Icon(Icons.download),
              onPressed: _savePdfToDownloads,
              tooltip: 'Save to Downloads',
            ),
        ],
      ),
      body: Column(
        children: [
          if (progress < 1.0)
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          Expanded(
            child: _hasSource
                ? (widget.pdfUrl != null
                    ? FutureBuilder<PDFDocument?>(
                        future: _pdfFuture,
                        builder: (context, snapshot) {
                          if (_downloadingPdf) {
                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(32.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 120,
                                      height: 120,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          SizedBox(
                                            width: 120,
                                            height: 120,
                                            child: CircularProgressIndicator(
                                              value: _downloadProgress > 0
                                                  ? _downloadProgress
                                                  : null,
                                              strokeWidth: 8,
                                              backgroundColor: Colors.grey[200],
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Colors.green,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            _downloadProgress > 0
                                                ? '${(100 * _downloadProgress).toStringAsFixed(0)}%'
                                                : '0%',
                                            style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 24),
                                    Text(
                                      'Downloading PDF...',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    if (_downloadProgress > 0)
                                      LinearProgressIndicator(
                                        value: _downloadProgress,
                                        backgroundColor: Colors.grey[200],
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Colors.green,
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }
                          if (snapshot.connectionState !=
                              ConnectionState.done) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasError || snapshot.data == null) {
                            return Center(
                              child: Text(
                                _loadError ?? 'Failed to load PDF.',
                                textAlign: TextAlign.center,
                              ),
                            );
                          }
                          return PDFViewer(document: snapshot.data!);
                        },
                      )
                    : WebViewWidget(controller: _webViewController))
                : Center(
                    child: Text(
                      _loadError ?? 'Nothing to load.',
                      textAlign: TextAlign.center,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
