import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/widgets/invoice.dart';

import 'package:apnagodam/presentation/sbt/ContractNotes/service/SbtContractNotesService.dart';
import 'package:apnagodam/presentation/sbt/service/SbtService.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:easy_pdf_viewer/easy_pdf_viewer.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

class Sbtmybuy extends ConsumerStatefulWidget {
  const Sbtmybuy({super.key});

  @override
  ConsumerState<Sbtmybuy> createState() => _SbtmybuyState();
}

class _SbtmybuyState extends ConsumerState<Sbtmybuy> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(authProvider).when(
        data: (data) => data == AuthStatus.loggedOut
            ? SizedBox(
                height: Get.height * .50,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset('assets/images/mainlogopng.png',
                          height: 150, width: 150),
                      simpleButton(
                          text: "Login to view contract notes",
                          callback: () {
                            showLoginBottomsheet(context);
                          }),
                    ],
                  ),
                ),
              )
            : ref.watch(sbtContactNoteProvider).when(
                  data: (data) {
                    var buyerList = data.data
                        ?.where(
                            (element) => element.type.toLowerCase() == "buyer")
                        .toList();

                    if ((buyerList ?? []).isEmpty) return noStockData(context);

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildHeaderRow(),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: buyerList?.length,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) => _buildItemRow(
                                context, buyerList![index], index)),
                      ],
                    );
                  },
                  error: (e, s) => noDataFoundOrders(context),
                  loading: () => listSkeleton(context),
                ),
        error: (e, s) => Container(),
        loading: () => Container());
  }

  Widget _buildHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: ColorConstant.maingreen,
      child: Row(
        children: [
          _buildHeaderCell(AppLocalizations.of(context)!.dealId),
          _verticalDivider(),
          _buildHeaderCell(AppLocalizations.of(context)!.msgCommodityy),
          _verticalDivider(),
          _buildHeaderCell(AppLocalizations.of(context)!.msgDistrict),
          _verticalDivider(),
          _buildHeaderCell(AppLocalizations.of(context)!.action),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
          title,
          style: AppStyle.wallatmoneylist.copyWith(
            fontSize: Adaptive.sp(16),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildItemRow(BuildContext context, dynamic item, int index) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: index % 2 == 0 ? Colors.white : Colors.grey.withOpacity(0.3),
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildCell(item.orderId ?? "N/A"),
            _verticalDivider(),
            _buildCell(item.commodityName ?? "N/A"),
            _verticalDivider(),
            _buildCell(item.districtName ?? "N/A"),
            _verticalDivider(),
            _buildActionCell(context, item),
          ],
        ),
      ),
    );
  }

  Widget _buildCell(String value) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
          value,
          textAlign: TextAlign.center,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: Adaptive.sp(16),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _verticalDivider() {
    return Container(
      width: 1,
      color: Colors.grey.shade300,
      margin: const EdgeInsets.symmetric(vertical: 8),
    );
  }

  Widget _buildActionCell(BuildContext context, dynamic item) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            style: AppStyle.buttonStyle.copyWith(
              padding: WidgetStatePropertyAll(Pad(all: 8)),
              backgroundColor: WidgetStateProperty.all(ColorConstant.maingreen),
            ),
            onPressed: () => _handleDownload(context, item),
            child: Text(
              AppLocalizations.of(context)!.msgNote,
              textAlign: TextAlign.center,
              style: AppStyle.lblnote.copyWith(fontSize: Adaptive.sp(16)),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _handleDownload(BuildContext context, dynamic item) async {
    try {
      final contractNote = await ref.watch(buyerContractNoteProvider(
              orderId: item.orderId.toString(), type: "Buyer")
          .future);

      final file = await settlementPdf(contractNote, "222", "2222", ref);
      if (file != null) {
        await FileSaver.instance
            .saveAs(
                name: 'buyer_sbt_contract_note',
                file: file,
                mimeType: MimeType.pdf,
                ext: '.pdf')
            .then((value) {
          OpenFile.open(value);
        });

        Fluttertoast.showToast(
          msg: 'File saved successfully!',
          toastLength: Toast.LENGTH_LONG,
          backgroundColor: ColorConstant.maingreen,
        );

        final doc = await PDFDocument.fromFile(file);

        Get.bottomSheet(
          Stack(
            children: [
              PDFViewer(document: doc),
              Padding(
                padding: Pad(all: 10),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ElevatedButton(
                    style: AppStyle.buttonStyle,
                    onPressed: () {}, // Optional download action
                    child: Text(
                      'Download',
                      style: TextStyle(
                        fontSize: Adaptive.sp(16),
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          isScrollControlled: true,
        );
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
