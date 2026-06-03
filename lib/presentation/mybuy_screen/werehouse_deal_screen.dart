import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/no_data_found_widget.dart';
import 'package:apnagodam/core/utils/theme/app_style.dart';
import 'package:apnagodam/presentation/dashboard/service/dashboard_service.dart';
import 'package:apnagodam/presentation/mybuy_screen/service/contract_note_service.dart';
import 'package:apnagodam/widgets/invoice.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../core/utils/color_constant.dart';
import '../../core/utils/string.dart';
import '../../widgets/GlobalBottomSheet.dart';
import '../../widgets/dailogs/eyeCommandailogwarehouse.dart';
import '../dashboard/model/wahouse_deal_model.dart';
import 'package:path/path.dart' as path;
import 'package:apnagodam/l10n/app_localizations.dart';

class WarehouseDeal extends ConsumerStatefulWidget {
  const WarehouseDeal({super.key, required this.buySellType});
  final String buySellType;
  @override
  ConsumerState<WarehouseDeal> createState() => _WarehouseDealState();
}

class _WarehouseDealState extends ConsumerState<WarehouseDeal> {
  var selectedTabIndexProvider = StateProvider((ref) => 0);

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {
        "label": AppLocalizations.of(context)!.msgGatepass,
        "index": 0,
        "icon": Icons.qr_code_2,
      },
      {
        "label": AppLocalizations.of(context)!.stacks,
        "index": 1,
        "icon": Icons.layers,
      },
    ];

    return ref
        .watch(authProvider)
        .when(
          data:
              (data) => Column(
                children: [
                  Padding(
                    padding: Pad(all: 10),
                    child: Wrap(
                      spacing: 8,
                      children: List.generate(tabs.length, (i) {
                        final tab = tabs[i];
                        final isSelected =
                            ref.watch(selectedTabIndexProvider) == tab['index'];

                        return InkWell(
                          onTap: () {
                            ref
                                .read(selectedTabIndexProvider.notifier)
                                .state = int.parse(tab['index'].toString());
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 250),
                            padding: Pad(
                              left: 12,
                              right: 12,
                              top: 8,
                              bottom: 8,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? ColorConstant.maingreen
                                      : Colors.white,
                              borderRadius: BorderRadius.circular(5.0),
                              border: Border.all(
                                color: ColorConstant.maingreen,
                                width: 1.5,
                              ),
                              boxShadow:
                                  isSelected
                                      ? [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                        ),
                                      ]
                                      : [],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  tab['icon'] as IconData,
                                  size: 16,
                                  color:
                                      isSelected
                                          ? Colors.white
                                          : ColorConstant.maingreen,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  tab['label'] as String,
                                  style: TextStyle(
                                    fontWeight:
                                        isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                    color:
                                        isSelected
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  ref.watch(selectedTabIndexProvider) == 0
                      ? data == AuthStatus.loggedOut
                          ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Image.asset(
                                  'assets/images/mainlogopng.png',
                                  height: 150,
                                  width: 150,
                                ),
                                simpleButton(
                                  text: "Login to view contract notes",
                                  callback: () {
                                    showLoginBottomsheet(context);
                                  },
                                ),
                              ],
                            ),
                          )
                          : ref
                              .watch(
                                warehouseDealDataProvider(
                                  type: widget.buySellType,
                                ),
                              )
                              .when(
                                data: (data) {
                                  final inventoryList =
                                      data.inventories?.data ?? [];

                                  if (inventoryList.isEmpty)
                                    return noStockData(context);

                                  return Column(
                                    children: [
                                      _buildHeaderRow(),
                                      ...inventoryList.map(
                                        (item) => _buildItemCard(context, item),
                                      ),
                                    ],
                                  );
                                },
                                error:
                                    (e, s) => Center(
                                      child: Text("Error: ${e.toString()}"),
                                    ),
                                loading: () => listSkeleton(context),
                              )
                      : data == AuthStatus.loggedOut
                      ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              'assets/images/mainlogopng.png',
                              height: 150,
                              width: 150,
                            ),
                            simpleButton(
                              text: "Login to view contract notes",
                              callback: () {
                                showLoginBottomsheet(context);
                              },
                            ),
                          ],
                        ),
                      )
                      : ref
                          .watch(
                            stackBuySellListProvider(type: widget.buySellType),
                          )
                          .when(
                            data: (data) {
                              return data['data'].isEmpty
                                  ? Container(
                                    height: Get.height / 2,
                                    child: noStockData(context),
                                    alignment: Alignment.center,
                                  )
                                  : Column(
                                    children: [
                                      _buildHeaderRowStack(),
                                      ...data['data']
                                          .map(
                                            (item) => _buildItemCardStack(
                                              context,
                                              item,
                                            ),
                                          )
                                          .toList(),
                                    ],
                                  );
                            },
                            error:
                                (e, s) => Center(
                                  child: Text("Error: ${e.toString()}"),
                                ),
                            loading: () => listSkeleton(context),
                          ),
                ],
              ),
          error: (e, s) => Container(),
          loading: () => Container(),
        );
  }

  Widget _buildHeaderRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: ColorConstant.maingreen,
      child: Row(
        children: [
          _buildHeaderCell(AppLocalizations.of(context)!.msgGatepastwo),
          _verticalDivider(),
          _buildHeaderCell(AppLocalizations.of(context)!.msgCommodityy),
          _verticalDivider(),
          _buildHeaderCell(
            widget.buySellType == "buy"
                ? AppLocalizations.of(context)!.seller
                : AppLocalizations.of(context)!.buyer,
          ),
          _verticalDivider(),
          _buildHeaderCell(AppLocalizations.of(context)!.msgAction),
        ],
      ),
    );
  }

  Widget _buildHeaderRowStack() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      color: ColorConstant.maingreen,
      child: Row(
        children: [
          _buildHeaderCell(AppLocalizations.of(context)!.warehouse),
          _verticalDivider(),
          _buildHeaderCell(AppLocalizations.of(context)!.stackNo4),
          _verticalDivider(),
          _buildHeaderCell(AppLocalizations.of(context)!.msgCommodityy),
          _verticalDivider(),
          _buildHeaderCell(
            widget.buySellType == "buy"
                ? AppLocalizations.of(context)!.seller
                : AppLocalizations.of(context)!.buyer,
          ),
          _verticalDivider(),
          _buildHeaderCell(AppLocalizations.of(context)!.msgAction),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(String title) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Text.rich(
          TextSpan(text: title),
          style: TextStyle(
            fontSize: Adaptive.sp(15),
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _buildItemCard(BuildContext context, dynamic item) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildCell(item.gatePassWr ?? "N/A"),
            _verticalDivider(),
            _buildCell(item.category ?? "N/A"),
            _verticalDivider(),
            _buildCell(item.fname ?? "N/A"),
            _verticalDivider(),
            _buildActionCell(context, item),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCardStack(BuildContext context, Map<String, dynamic> item) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            _buildCell(item['warehouse'] ?? "N/A"),
            _verticalDivider(),
            _buildCell(item['stack_no'] ?? "N/A"),
            _verticalDivider(),
            _buildCell(item['commodity'] ?? "N/A"),
            _verticalDivider(),
            _buildCell(item['name'] ?? "N/A"),
            _verticalDivider(),
            _buildActionCellStack(context, item),
          ],
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

  Widget _buildCell(String value) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Text(
          value,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Adaptive.sp(15),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildActionCell(BuildContext context, InventoryDatum item) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => _showEyeDialog(context, item),
            child: Icon(
              Icons.remove_red_eye,
              color: ColorConstant.maingreen,
              size: Adaptive.sp(24),
            ),
          ),
          const SizedBox(height: 6),
          ElevatedButton(
            style: AppStyle.buttonStyle.copyWith(
              padding: WidgetStatePropertyAll(Pad(all: 8)),
              backgroundColor: WidgetStateProperty.all(ColorConstant.maingreen),
            ),
            onPressed: () => _showContractNote(context, item.id?.toString()),
            child: Text(
              AppLocalizations.of(context)!.msgNote,
              style: AppStyle.lblnote.copyWith(fontSize: Adaptive.sp(16)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCellStack(
    BuildContext context,
    Map<String, dynamic> item,
  ) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () => _showEyeDialogStack(context, item),
            child: Icon(
              Icons.remove_red_eye,
              color: ColorConstant.maingreen,
              size: Adaptive.sp(24),
            ),
          ),
          const SizedBox(height: 6),
          ElevatedButton(
            style: AppStyle.buttonStyle.copyWith(
              padding: WidgetStatePropertyAll(Pad(all: 8)),
              backgroundColor: WidgetStateProperty.all(ColorConstant.maingreen),
            ),
            onPressed:
                () => _showContractNoteStack(context, item['id']?.toString()),
            child: Text(
              AppLocalizations.of(context)!.msgNote,
              style: AppStyle.lblnote.copyWith(fontSize: Adaptive.sp(15)),
            ),
          ),
        ],
      ),
    );
  }

  void _showEyeDialog(BuildContext context, InventoryDatum item) {
    EycCommanDialogwarehouse(
      item.gatePassWr ?? "N/A",
      item.fname ?? "N/A",
      item.name ?? "N/A",
      item.location ?? "N/A",
      item.category ?? "N/A",
      item.quantity ?? "N/A",
      "N/A",
      item.price ?? "N/A",
      "N/A",
      DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.parse(item.updatedAt ?? DateTime.now().toString())),
      context,
      widget.buySellType,
    );
  }

  void _showEyeDialogStack(BuildContext context, Map<String, dynamic> item) {
    EycCommanDialogStack(
      item['stack_no'] ?? "N/A",
      item['name'] ?? "N/A",
      item['warehouse'] ?? "N/A",
      item['location'] ?? "N/A",
      item['commodity'] ?? "N/A",
      item['quantity'] ?? "N/A",
      "N/A",
      item['price'] ?? "N/A",
      "N/A",
      DateFormat(
        'dd/MM/yyyy',
      ).format(DateTime.parse(item['date'] ?? DateTime.now().toString())),
      context,
      widget.buySellType,
    );
  }

  void _showContractNote(BuildContext context, String? dealId) {
    if (dealId == null) return;

    ref.read(contractNotesProvider(dealId: dealId).future).then((value) {
      GlobalBottomSheet.show(
        context,
        content: Text(AppLocalizations.of(context)!.yourBottomSheetContent),
        contractNote: value,
        callback: (dynamic result) {
          if (result == true) Get.back();
        },
      );
    });
  }

  void _showContractNoteStack(BuildContext context, String? dealId) {
    if (dealId == null) return;

    ref.read(stackContractNoteProvider(id: dealId).future).then((value) async {
      if (widget.buySellType == "buy") {
        stackContractNotePdf(value, ref, widget.buySellType).then((file) async {
          await FileSaver.instance
              .saveAs(
                name: 'buyer_stack_contract_note',
                file: file,
                mimeType: MimeType.pdf,
                ext: '.pdf',
              )
              .then((value) {
                OpenFile.open(value);
              });
          Fluttertoast.showToast(
            msg: 'File saved successfully!',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: ColorConstant.maingreen,
          );
        });
      } else {
        stackContractNotePdfSeller(value, ref, widget.buySellType).then((
          file,
        ) async {
          await FileSaver.instance
              .saveAs(
                name: 'seller_stack_contract_note',
                file: file,
                mimeType: MimeType.pdf,
                ext: '.pdf',
              )
              .then((value) {
                OpenFile.open(value);
              });
          Fluttertoast.showToast(
            msg: 'File saved successfully!',
            toastLength: Toast.LENGTH_LONG,
            backgroundColor: ColorConstant.maingreen,
          );
        });
      }
    });
  }
}

var warehouseDealSearchProvider = StateProvider((ref) => '');
