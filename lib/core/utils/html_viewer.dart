import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/presentation/commodity_finance/service/commodity_finance_service.dart';
import 'package:apnagodam/presentation/login_screen/LoginBottomsheet.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_service.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

import '../../widgets/dailogs/error.dart';

class HtmlDataViewer extends ConsumerStatefulWidget {
  HtmlDataViewer({
    super.key,
    required this.htmlData,
    required this.bankId,
    required this.amount,
    required this.dailog,
  });

  final String? htmlData;
  final String? bankId;
  final String? amount;
  final String? dailog;

  @override
  ConsumerState<HtmlDataViewer> createState() => _HtmlDataViewerState();
}

class _HtmlDataViewerState extends ConsumerState<HtmlDataViewer> {
  var isChecked = StateProvider((ref) => false);
  InAppWebViewController? webView;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.close, size: 32),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: InAppWebView(
                  initialData: InAppWebViewInitialData(
                    data: buildHtmlContent(),
                    baseUrl: WebUri.uri(Uri.parse("about:blank")),
                    mimeType: "text/html",
                    encoding: "utf-8",
                  ),
                  onWebViewCreated: (controller) {
                    webView = controller;
                  },
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  activeColor: ColorConstant.maingreen,
                  value: ref.watch(isChecked),
                  onChanged: (bool? newbool) {
                    ref.watch(isChecked.notifier).state = newbool ?? false;
                  },
                  checkColor: Colors.white,
                  // controlAffinity: ListTileControlAffinity.leading,
                ),
                Expanded(
                  child: Text(
                    AppLocalizations.of(context)!.msgTermCon,
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                    maxLines: 2,
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(18.0),
              child: InkWell(
                onTap: () async {
                  if (ref.watch(isChecked) == false) {
                    Get.rawSnackbar(
                      message: "Please agree to our term and conditions",
                      duration: const Duration(seconds: 2),
                      backgroundColor: ColorConstant.red500,
                    );
                  } else {
                    ref
                        .watch(
                          applySenctionLimitProvider(
                            bankId: widget.bankId,
                            requestedAmount: widget.amount,
                          ).future,
                        )
                        .then((value) async {
                          Get.rawSnackbar(
                            message: value.message,
                            duration: const Duration(seconds: 2),
                            backgroundColor: ColorConstant.maingreen,
                          );
                          if (value.status == "3") {
                            showBottomSheet(
                              context: context,
                              builder:
                                  (bottomsheetContext) =>
                                      ElevarmDraggableBottomSheet(
                                        title: "Login to Continue",
                                        onPressedClose: () => Get.back(),
                                        children: [LoginBottomSheet()],
                                      ),
                            );
                          } else {
                            ref.invalidate(myStockProvider);
                            Get.close(2);
                          }
                        })
                        .onError((e, s) {
                          errorBottomSheet(context, "$e");
                        });
                  }
                },
                child: Container(
                  height: 38,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: ColorConstant.maingreen,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                  ),
                  child: Center(
                    child: Text(
                      AppLocalizations.of(context)!.msgSubmit,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String buildHtmlContent() {
    return '''
      <!DOCTYPE html>
      <html>
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
        </head>
        <body>
          ${widget.htmlData}
          <!-- Example HTML content -->
       
        </body>
      </html>
    ''';
  }
}
