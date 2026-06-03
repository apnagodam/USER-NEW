import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:apnagodam/l10n/app_localizations.dart';

final grnRequestListProvider = Provider<List<Map<String, dynamic>>>((ref) {
  // Replace this with the actual provider logic to fetch data
  return [];
});

class GRNRequestListScreen extends ConsumerWidget {
  const GRNRequestListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final grnRequestList = ref.watch(grnRequestListProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.msgGrnRequestList),
      ),
      body: grnRequestList.isEmpty
          ? Center(child: Text(AppLocalizations.of(context)!.msgNoDataFound))
          : ListView.builder(
              itemCount: grnRequestList.length,
              itemBuilder: (context, index) {
                final item = grnRequestList[index];
                return Card(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            "${AppLocalizations.of(context)!.msgOrderId}: ${item['order_id']}",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(
                            "${AppLocalizations.of(context)!.msgRequestDate}: ${item['request_date']}"),
                        Text(
                            "${AppLocalizations.of(context)!.msgSalesStatus}: ${item['sales_status']}"),
                        Text(
                            "${AppLocalizations.of(context)!.msgWeight}: ${item['weight']}"),
                        Text(
                            "${AppLocalizations.of(context)!.msgVehicleNumber}: ${item['vehicle_number']}"),
                        Text(
                            "${AppLocalizations.of(context)!.msgDriverNumber}: ${item['driver_number']}"),
                        SizedBox(height: 10),
                        if (item['kanta_parchi'] != null)
                          _buildLink(
                              AppLocalizations.of(context)!.msgKantaParchi,
                              item['kanta_parchi']),
                        if (item['billty'] != null)
                          _buildLink(AppLocalizations.of(context)!.msgBillty,
                              item['billty']),
                        if (item['draft_invoice_copy'] != null)
                          _buildLink(
                              AppLocalizations.of(context)!.msgDraftInvoice,
                              item['draft_invoice_copy']),
                        if (item['invoice_copy'] != null)
                          _buildLink(
                              AppLocalizations.of(context)!.msgInvoiceCopy,
                              item['invoice_copy']),
                        if (item['grn'] != null)
                          _buildLink(AppLocalizations.of(context)!.msgGrn,
                              item['grn']),
                        if (item['receving_kanta_parchi'] != null)
                          _buildLink(
                              AppLocalizations.of(context)!
                                  .msgReceivingKantaParchi,
                              item['receving_kanta_parchi']),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildLink(String label, String url) {
    return InkWell(
      onTap: () async {
        if (await canLaunch(url)) {
          await launch(url);
        }
      },
      child: Text(
        label,
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
