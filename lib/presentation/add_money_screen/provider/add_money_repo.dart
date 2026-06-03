import 'package:apnagodam/presentation/add_money_screen/provider/add_money_summary_model.dart';

abstract class AddMoneyRepo {
  Stream<AddMoneySummaryModel> getSummary();
}
