import 'package:apnagodam/presentation/withdraw_money_screen/wallet_impl/withdrawl_model.dart';

abstract class WalletRepo {
  Stream<WalletWithdrawlModel> getWalletList();
}
