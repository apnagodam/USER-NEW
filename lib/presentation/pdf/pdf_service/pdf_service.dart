import 'dart:convert';

import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/pdf/pdf_service/pdf_model_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pdf_service.g.dart';

@riverpod
Future<PdfResponseModel> getPdfData(GetPdfDataRef ref, {String? invId}) async {
  var response = await ref
      .watch(dioProvider)
      .get('user_api/apna_u_get_pdf', queryParameters: {'inv_id': invId});
  return pdfResponseModelFromMap(jsonEncode(response.data));
}
