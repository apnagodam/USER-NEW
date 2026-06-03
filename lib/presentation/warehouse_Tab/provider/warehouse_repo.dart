import 'package:apnagodam/presentation/warehouse_Tab/provider/model/inwards_summary_model.dart';

abstract class WarehouseRepo {
  Future<InwardsSummaryModel> getinwardsSummary(
      {String search = '', int page = 0, int limit = 30});
}
