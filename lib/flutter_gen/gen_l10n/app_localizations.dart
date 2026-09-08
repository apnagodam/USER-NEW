import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_kn.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
    Locale('kn'),
  ];

  /// No description provided for @msgOnborderingFirst.
  ///
  /// In en, this message translates to:
  /// **'Apna Godam offers an online trading platform in various agri commodities wherein farmers, traders,processors, exporters, importers, can buy/sell in a transparent manner.'**
  String get msgOnborderingFirst;

  /// No description provided for @msgFinance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get msgFinance;

  /// No description provided for @msgOnborderingSecond.
  ///
  /// In en, this message translates to:
  /// **'Though our NBFC firm, Apna Godam provides loans to farmers against warehouse receipts on low interest. Fastest Loan processing. Get easy finance on warehouse stocks.'**
  String get msgOnborderingSecond;

  /// No description provided for @msgLoging.
  ///
  /// In en, this message translates to:
  /// **'Log In'**
  String get msgLoging;

  /// No description provided for @msgWarehousing.
  ///
  /// In en, this message translates to:
  /// **'Warehousing'**
  String get msgWarehousing;

  /// No description provided for @msgOnborderingTherd.
  ///
  /// In en, this message translates to:
  /// **'We provides state-of-the-art storage through an integrated and Pan India warehousing network to maximize efficiency and reduce post harvest losses.'**
  String get msgOnborderingTherd;

  /// No description provided for @msgLogistics.
  ///
  /// In en, this message translates to:
  /// **'Logistics'**
  String get msgLogistics;

  /// No description provided for @msgOnborderingFor.
  ///
  /// In en, this message translates to:
  /// **'Online tracking logistics to track drivers, shipment of goods, vehicles and client’s operations.'**
  String get msgOnborderingFor;

  /// No description provided for @msgSignup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get msgSignup;

  /// No description provided for @msgEnterYourEmails.
  ///
  /// In en, this message translates to:
  /// **'Please enter your mobile number'**
  String get msgEnterYourEmails;

  /// No description provided for @msgEnterYourCredentials.
  ///
  /// In en, this message translates to:
  /// **'Enter your credentials to continue'**
  String get msgEnterYourCredentials;

  /// No description provided for @lableEmail.
  ///
  /// In en, this message translates to:
  /// **'Email '**
  String get lableEmail;

  /// No description provided for @lableUsername.
  ///
  /// In en, this message translates to:
  /// **'Enter your name '**
  String get lableUsername;

  /// No description provided for @lablePassword.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get lablePassword;

  /// No description provided for @lableForgotPass.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get lableForgotPass;

  /// No description provided for @msgDontHaveAn.
  ///
  /// In en, this message translates to:
  /// **'Don’t have an account? '**
  String get msgDontHaveAn;

  /// No description provided for @msgAlreadyHaveAn.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? '**
  String get msgAlreadyHaveAn;

  /// No description provided for @msgByContinuing.
  ///
  /// In en, this message translates to:
  /// **'By continuing you agree to our'**
  String get msgByContinuing;

  /// No description provided for @msgVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Please type verification code sent to :-'**
  String get msgVerificationCode;

  /// No description provided for @msgReceiveCode.
  ///
  /// In en, this message translates to:
  /// **'If your did not receive a code.'**
  String get msgReceiveCode;

  /// No description provided for @msgFenugreek.
  ///
  /// In en, this message translates to:
  /// **'Fenugreek'**
  String get msgFenugreek;

  /// No description provided for @msgJaipur.
  ///
  /// In en, this message translates to:
  /// **'jaipur(12365)01-02-2023'**
  String get msgJaipur;

  /// No description provided for @msgAddmoney.
  ///
  /// In en, this message translates to:
  /// **'Add Money'**
  String get msgAddmoney;

  /// No description provided for @msgWithdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw Money'**
  String get msgWithdraw;

  /// No description provided for @msgStatement.
  ///
  /// In en, this message translates to:
  /// **'Wallet Statement'**
  String get msgStatement;

  /// No description provided for @msgAccountDetail.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get msgAccountDetail;

  /// No description provided for @msgHoldersname.
  ///
  /// In en, this message translates to:
  /// **'Holder Name : '**
  String get msgHoldersname;

  /// No description provided for @msgHoldersnameDetail.
  ///
  /// In en, this message translates to:
  /// **'Singodwala Warehouseing and Logistics Pvt Ltd'**
  String get msgHoldersnameDetail;

  /// No description provided for @msgAccontNo.
  ///
  /// In en, this message translates to:
  /// **'Account Number : '**
  String get msgAccontNo;

  /// No description provided for @msgBankName.
  ///
  /// In en, this message translates to:
  /// **'Bank Name : '**
  String get msgBankName;

  /// No description provided for @msgIFSC.
  ///
  /// In en, this message translates to:
  /// **'IFSC Code : '**
  String get msgIFSC;

  /// No description provided for @msgPaymentMode.
  ///
  /// In en, this message translates to:
  /// **'Payment Mode*'**
  String get msgPaymentMode;

  /// No description provided for @msgUpiUtr.
  ///
  /// In en, this message translates to:
  /// **'UPI-ID/UTR/Cheque Serial No.*'**
  String get msgUpiUtr;

  /// No description provided for @msgBankSlip.
  ///
  /// In en, this message translates to:
  /// **'Bank Slip / Cheque Photo*'**
  String get msgBankSlip;

  /// No description provided for @msgAppliedAmount.
  ///
  /// In en, this message translates to:
  /// **'Applied Amount (INR)*'**
  String get msgAppliedAmount;

  /// No description provided for @msgWalletAmount.
  ///
  /// In en, this message translates to:
  /// **'Wallet Amount : '**
  String get msgWalletAmount;

  /// No description provided for @msgFromDate.
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get msgFromDate;

  /// No description provided for @msgToDate.
  ///
  /// In en, this message translates to:
  /// **'To Date'**
  String get msgToDate;

  /// No description provided for @msgView.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get msgView;

  /// No description provided for @msgOpeningBalance.
  ///
  /// In en, this message translates to:
  /// **'Opening Balance'**
  String get msgOpeningBalance;

  /// No description provided for @msgTermAnd.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get msgTermAnd;

  /// No description provided for @msgWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Warehouse Deal'**
  String get msgWarehouse;

  /// No description provided for @msgLPSpot.
  ///
  /// In en, this message translates to:
  /// **'LP Spot Deal'**
  String get msgLPSpot;

  /// No description provided for @msgFaceDeal.
  ///
  /// In en, this message translates to:
  /// **'Face to Face Deal'**
  String get msgFaceDeal;

  /// No description provided for @msgChosse.
  ///
  /// In en, this message translates to:
  /// **'Choose'**
  String get msgChosse;

  /// No description provided for @msgLanuage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get msgLanuage;

  /// No description provided for @msgProductby.
  ///
  /// In en, this message translates to:
  /// **'Buy Commodity'**
  String get msgProductby;

  /// No description provided for @msgProductsell.
  ///
  /// In en, this message translates to:
  /// **'Sell Commodity'**
  String get msgProductsell;

  /// No description provided for @msgChooseoption.
  ///
  /// In en, this message translates to:
  /// **'Choose Option'**
  String get msgChooseoption;

  /// No description provided for @msgDelivery.
  ///
  /// In en, this message translates to:
  /// **'Delivery'**
  String get msgDelivery;

  /// No description provided for @msgLying.
  ///
  /// In en, this message translates to:
  /// **'Lying at Warehouse'**
  String get msgLying;

  /// No description provided for @msgFaceto.
  ///
  /// In en, this message translates to:
  /// **'Face to Face'**
  String get msgFaceto;

  /// No description provided for @msgKisasni.
  ///
  /// In en, this message translates to:
  /// **'Kissani'**
  String get msgKisasni;

  /// No description provided for @msgLyingatfarm.
  ///
  /// In en, this message translates to:
  /// **'Lying at Farm'**
  String get msgLyingatfarm;

  /// No description provided for @msgLyingatwarehouse.
  ///
  /// In en, this message translates to:
  /// **'Lying at Warehouse'**
  String get msgLyingatwarehouse;

  /// No description provided for @msgManditaxpaid.
  ///
  /// In en, this message translates to:
  /// **'Mandi Tax paid'**
  String get msgManditaxpaid;

  /// No description provided for @msgLatestonlinemandi.
  ///
  /// In en, this message translates to:
  /// **'APMC Price'**
  String get msgLatestonlinemandi;

  /// No description provided for @msgLatestmandiprice.
  ///
  /// In en, this message translates to:
  /// **'Latest Mandi Price'**
  String get msgLatestmandiprice;

  /// No description provided for @msgOrder.
  ///
  /// In en, this message translates to:
  /// **'Order List'**
  String get msgOrder;

  /// No description provided for @msgPurchase.
  ///
  /// In en, this message translates to:
  /// **'My Purchase'**
  String get msgPurchase;

  /// No description provided for @msgRepayment.
  ///
  /// In en, this message translates to:
  /// **'Repayment'**
  String get msgRepayment;

  /// No description provided for @msgMandiBhav.
  ///
  /// In en, this message translates to:
  /// **'Online Mandi Bhav '**
  String get msgMandiBhav;

  /// No description provided for @msgLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get msgLocation;

  /// No description provided for @msgPreviouspage.
  ///
  /// In en, this message translates to:
  /// **'Previous Page'**
  String get msgPreviouspage;

  /// No description provided for @msgNextpage.
  ///
  /// In en, this message translates to:
  /// **'Next Page'**
  String get msgNextpage;

  /// No description provided for @msgBluetooth.
  ///
  /// In en, this message translates to:
  /// **'Bluetooth Printer'**
  String get msgBluetooth;

  /// No description provided for @msgOtherprint.
  ///
  /// In en, this message translates to:
  /// **'Other Print'**
  String get msgOtherprint;

  /// No description provided for @msgMycommdodity.
  ///
  /// In en, this message translates to:
  /// **'My Commodity'**
  String get msgMycommdodity;

  /// No description provided for @msgTerminalname.
  ///
  /// In en, this message translates to:
  /// **'Terminal Name '**
  String get msgTerminalname;

  /// No description provided for @msgCommodity.
  ///
  /// In en, this message translates to:
  /// **'Commodity : '**
  String get msgCommodity;

  /// No description provided for @msgCommodityy.
  ///
  /// In en, this message translates to:
  /// **'Commodity'**
  String get msgCommodityy;

  /// No description provided for @msgApplyloan.
  ///
  /// In en, this message translates to:
  /// **'Apply For Loan'**
  String get msgApplyloan;

  /// No description provided for @msgKycupdate.
  ///
  /// In en, this message translates to:
  /// **'Profile Update'**
  String get msgKycupdate;

  /// No description provided for @msgName.
  ///
  /// In en, this message translates to:
  /// **'Name :- '**
  String get msgName;

  /// No description provided for @msgWalletBalance.
  ///
  /// In en, this message translates to:
  /// **'Wallet Balance :- '**
  String get msgWalletBalance;

  /// No description provided for @msgVersion.
  ///
  /// In en, this message translates to:
  /// **'Version : '**
  String get msgVersion;

  /// No description provided for @msgMyorders.
  ///
  /// In en, this message translates to:
  /// **'My Orders'**
  String get msgMyorders;

  /// No description provided for @msgSpotorder.
  ///
  /// In en, this message translates to:
  /// **'Spot Order Booking'**
  String get msgSpotorder;

  /// No description provided for @msgTrip.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get msgTrip;

  /// No description provided for @msgWarehousefacility.
  ///
  /// In en, this message translates to:
  /// **'Warehouse Facility'**
  String get msgWarehousefacility;

  /// No description provided for @msgCredit.
  ///
  /// In en, this message translates to:
  /// **'Credit Amount'**
  String get msgCredit;

  /// No description provided for @msgBnpl.
  ///
  /// In en, this message translates to:
  /// **'BNPL'**
  String get msgBnpl;

  /// No description provided for @msgLoan.
  ///
  /// In en, this message translates to:
  /// **'Loan'**
  String get msgLoan;

  /// No description provided for @msgAlert.
  ///
  /// In en, this message translates to:
  /// **'Alert'**
  String get msgAlert;

  /// No description provided for @msgYouarenot.
  ///
  /// In en, this message translates to:
  /// **'You are not Verified. Call or IVR'**
  String get msgYouarenot;

  /// No description provided for @msgCallforhelp.
  ///
  /// In en, this message translates to:
  /// **'CALL FOR HELP'**
  String get msgCallforhelp;

  /// No description provided for @msgOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get msgOk;

  /// No description provided for @msgCommodityFinance.
  ///
  /// In en, this message translates to:
  /// **'Commodity Finance'**
  String get msgCommodityFinance;

  /// No description provided for @msgOnlineMandiBhav.
  ///
  /// In en, this message translates to:
  /// **'Online Mandi Bhav'**
  String get msgOnlineMandiBhav;

  /// No description provided for @msgReferEarn.
  ///
  /// In en, this message translates to:
  /// **'Refer & Earn'**
  String get msgReferEarn;

  /// No description provided for @aboutUs.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get aboutUs;

  /// No description provided for @msgLogout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get msgLogout;

  /// No description provided for @msgBuy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get msgBuy;

  /// No description provided for @msgSell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get msgSell;

  /// No description provided for @msgMandi.
  ///
  /// In en, this message translates to:
  /// **'Mandi : '**
  String get msgMandi;

  /// No description provided for @msgPrice.
  ///
  /// In en, this message translates to:
  /// **'Price(Qtl.)'**
  String get msgPrice;

  /// No description provided for @msgPriceorder.
  ///
  /// In en, this message translates to:
  /// **'Price(/Qtl.) : '**
  String get msgPriceorder;

  /// No description provided for @msgEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get msgEdit;

  /// No description provided for @msgDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get msgDelete;

  /// No description provided for @msgOrderid.
  ///
  /// In en, this message translates to:
  /// **'Order ID : '**
  String get msgOrderid;

  /// No description provided for @msgTotalquantity.
  ///
  /// In en, this message translates to:
  /// **'Total Quantity(Qtl.) : '**
  String get msgTotalquantity;

  /// No description provided for @msgRemainingquantity.
  ///
  /// In en, this message translates to:
  /// **'Remaining Quantity(Qtl.) : '**
  String get msgRemainingquantity;

  /// No description provided for @msgDate.
  ///
  /// In en, this message translates to:
  /// **'Date : '**
  String get msgDate;

  /// No description provided for @msgHelp.
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get msgHelp;

  /// No description provided for @msgWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Whats App'**
  String get msgWhatsapp;

  /// No description provided for @msgCallforHelp.
  ///
  /// In en, this message translates to:
  /// **'Call For Help'**
  String get msgCallforHelp;

  /// No description provided for @msgSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get msgSummary;

  /// No description provided for @msgGatepass.
  ///
  /// In en, this message translates to:
  /// **'Gate Pass : '**
  String get msgGatepass;

  /// No description provided for @msgGatepastwo.
  ///
  /// In en, this message translates to:
  /// **'Gate Pass'**
  String get msgGatepastwo;

  /// No description provided for @msgWeightt.
  ///
  /// In en, this message translates to:
  /// **'Weight(Qtl) : '**
  String get msgWeightt;

  /// No description provided for @msgWeightwithqtl.
  ///
  /// In en, this message translates to:
  /// **'Weight(Qtl)'**
  String get msgWeightwithqtl;

  /// No description provided for @msgBags.
  ///
  /// In en, this message translates to:
  /// **'Bags'**
  String get msgBags;

  /// No description provided for @msgStackno.
  ///
  /// In en, this message translates to:
  /// **'Stack No :- '**
  String get msgStackno;

  /// No description provided for @msgRent.
  ///
  /// In en, this message translates to:
  /// **'Rent : '**
  String get msgRent;

  /// No description provided for @msgExpirydate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date : '**
  String get msgExpirydate;

  /// No description provided for @msgViewgraph.
  ///
  /// In en, this message translates to:
  /// **'View Graph'**
  String get msgViewgraph;

  /// No description provided for @msgApply.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get msgApply;

  /// No description provided for @msgWanttosell.
  ///
  /// In en, this message translates to:
  /// **'Want To Sell'**
  String get msgWanttosell;

  /// No description provided for @msgChoosebank.
  ///
  /// In en, this message translates to:
  /// **'Choose Bank'**
  String get msgChoosebank;

  /// No description provided for @msgBankname.
  ///
  /// In en, this message translates to:
  /// **'Bank Name : '**
  String get msgBankname;

  /// No description provided for @msgProcessing.
  ///
  /// In en, this message translates to:
  /// **'Processing Fees(%) :'**
  String get msgProcessing;

  /// No description provided for @msgLoanpertotal.
  ///
  /// In en, this message translates to:
  /// **'Loan per total amount(%):'**
  String get msgLoanpertotal;

  /// No description provided for @msgApr.
  ///
  /// In en, this message translates to:
  /// **'A.P.R :'**
  String get msgApr;

  /// No description provided for @msgGeneratorname.
  ///
  /// In en, this message translates to:
  /// **'Generator Name:'**
  String get msgGeneratorname;

  /// No description provided for @msgTenor.
  ///
  /// In en, this message translates to:
  /// **'Tenor(Month):'**
  String get msgTenor;

  /// No description provided for @msgRequestlist.
  ///
  /// In en, this message translates to:
  /// **'Request List'**
  String get msgRequestlist;

  /// No description provided for @msgRequestamount.
  ///
  /// In en, this message translates to:
  /// **'Request Amount : '**
  String get msgRequestamount;

  /// No description provided for @msgApprovedamount.
  ///
  /// In en, this message translates to:
  /// **'Approved Amount : '**
  String get msgApprovedamount;

  /// No description provided for @msgCommodityfinance.
  ///
  /// In en, this message translates to:
  /// **'Apply for Commodity Finance'**
  String get msgCommodityfinance;

  /// No description provided for @msgInterestrate.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate(%) :'**
  String get msgInterestrate;

  /// No description provided for @msgDisbursement.
  ///
  /// In en, this message translates to:
  /// **'Disbursement Days :'**
  String get msgDisbursement;

  /// No description provided for @msgSanctioned.
  ///
  /// In en, this message translates to:
  /// **'Sanctioned Amount :'**
  String get msgSanctioned;

  /// No description provided for @msgGuaranteecommiss.
  ///
  /// In en, this message translates to:
  /// **'Guarantee Commission :'**
  String get msgGuaranteecommiss;

  /// No description provided for @msgQuantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity(Qtl.)'**
  String get msgQuantity;

  /// No description provided for @msgApproxdeal.
  ///
  /// In en, this message translates to:
  /// **'Approx Deal Amount :'**
  String get msgApproxdeal;

  /// No description provided for @msgApproxloan.
  ///
  /// In en, this message translates to:
  /// **'Approx Loan Amounts :'**
  String get msgApproxloan;

  /// No description provided for @msgNetpayableamount.
  ///
  /// In en, this message translates to:
  /// **'Net Payable Amount : '**
  String get msgNetpayableamount;

  /// No description provided for @msgCencel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get msgCencel;

  /// No description provided for @msgYourcommodity.
  ///
  /// In en, this message translates to:
  /// **'Add your Commodity'**
  String get msgYourcommodity;

  /// No description provided for @msgNosufficient.
  ///
  /// In en, this message translates to:
  /// **'There is no sufficient sanction limit available in loan account. Please apply for sanction limit.'**
  String get msgNosufficient;

  /// No description provided for @msgWalletbalance.
  ///
  /// In en, this message translates to:
  /// **'Wallet Balance'**
  String get msgWalletbalance;

  /// No description provided for @msgOrderdetails.
  ///
  /// In en, this message translates to:
  /// **'Order Details'**
  String get msgOrderdetails;

  /// No description provided for @msgSellername.
  ///
  /// In en, this message translates to:
  /// **'Seller Name :-'**
  String get msgSellername;

  /// No description provided for @msgCommodityname.
  ///
  /// In en, this message translates to:
  /// **'Commodity Name'**
  String get msgCommodityname;

  /// No description provided for @msgWeight.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get msgWeight;

  /// No description provided for @msgPrice_1.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get msgPrice_1;

  /// No description provided for @msgManditax.
  ///
  /// In en, this message translates to:
  /// **'Mandi Tax'**
  String get msgManditax;

  /// No description provided for @msgAgcommission.
  ///
  /// In en, this message translates to:
  /// **'AG Commission'**
  String get msgAgcommission;

  /// No description provided for @msgDealamount.
  ///
  /// In en, this message translates to:
  /// **'Deal Amount'**
  String get msgDealamount;

  /// No description provided for @msgTotaldealamount.
  ///
  /// In en, this message translates to:
  /// **'Total Deal Amount'**
  String get msgTotaldealamount;

  /// No description provided for @msgTerminal.
  ///
  /// In en, this message translates to:
  /// **'Terminal :'**
  String get msgTerminal;

  /// No description provided for @mstOutstandingamount.
  ///
  /// In en, this message translates to:
  /// **'Outstanding Balance'**
  String get mstOutstandingamount;

  /// No description provided for @msgPendingamount.
  ///
  /// In en, this message translates to:
  /// **'Pending Amount'**
  String get msgPendingamount;

  /// No description provided for @msgRealamount.
  ///
  /// In en, this message translates to:
  /// **'Rent Amount'**
  String get msgRealamount;

  /// No description provided for @msgLoanamount.
  ///
  /// In en, this message translates to:
  /// **'Loan Amount'**
  String get msgLoanamount;

  /// No description provided for @msgInterestamount.
  ///
  /// In en, this message translates to:
  /// **'Interest Amount'**
  String get msgInterestamount;

  /// No description provided for @msgHousename.
  ///
  /// In en, this message translates to:
  /// **'Warehouse \n Name'**
  String get msgHousename;

  /// No description provided for @msgWithdrawa.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get msgWithdrawa;

  /// No description provided for @msgPdf.
  ///
  /// In en, this message translates to:
  /// **'Download PDF'**
  String get msgPdf;

  /// No description provided for @msgChequeno.
  ///
  /// In en, this message translates to:
  /// **'Narration/Ref/Cheque No.'**
  String get msgChequeno;

  /// No description provided for @msgBalance.
  ///
  /// In en, this message translates to:
  /// **'Balance'**
  String get msgBalance;

  /// No description provided for @msgClosingbal.
  ///
  /// In en, this message translates to:
  /// **'Closing Balance'**
  String get msgClosingbal;

  /// No description provided for @msgAadharno.
  ///
  /// In en, this message translates to:
  /// **'Aadhar Number'**
  String get msgAadharno;

  /// No description provided for @msgMystock.
  ///
  /// In en, this message translates to:
  /// **'My Stock'**
  String get msgMystock;

  /// No description provided for @msgMarket.
  ///
  /// In en, this message translates to:
  /// **'Market'**
  String get msgMarket;

  /// No description provided for @msgMybuy.
  ///
  /// In en, this message translates to:
  /// **'My Buy'**
  String get msgMybuy;

  /// No description provided for @msgMysell.
  ///
  /// In en, this message translates to:
  /// **'My Sell'**
  String get msgMysell;

  /// No description provided for @msgHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get msgHome;

  /// No description provided for @msgSeler.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get msgSeler;

  /// No description provided for @msgAction.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get msgAction;

  /// No description provided for @msgNetweight.
  ///
  /// In en, this message translates to:
  /// **'Net Weight(Qtl.)'**
  String get msgNetweight;

  /// No description provided for @msgMandifee.
  ///
  /// In en, this message translates to:
  /// **'Mandi fee'**
  String get msgMandifee;

  /// No description provided for @msgQuality.
  ///
  /// In en, this message translates to:
  /// **'Quality Grade'**
  String get msgQuality;

  /// No description provided for @msgNotfound.
  ///
  /// In en, this message translates to:
  /// **'No Data found!'**
  String get msgNotfound;

  /// No description provided for @noCurrentOrders.
  ///
  /// In en, this message translates to:
  /// **'No current orders'**
  String get noCurrentOrders;

  /// No description provided for @noCurrentBids.
  ///
  /// In en, this message translates to:
  /// **'No current bids'**
  String get noCurrentBids;

  /// No description provided for @somethingWentWrongYouMay.
  ///
  /// In en, this message translates to:
  /// **'Something Went wrong you may'**
  String get somethingWentWrongYouMay;

  /// No description provided for @noTransactionsFound.
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get noTransactionsFound;

  /// No description provided for @noFinancesFound.
  ///
  /// In en, this message translates to:
  /// **'No Finances found!'**
  String get noFinancesFound;

  /// No description provided for @noBnplDataFound.
  ///
  /// In en, this message translates to:
  /// **'No Bnpl Data found!'**
  String get noBnplDataFound;

  /// No description provided for @msgCommodityimg.
  ///
  /// In en, this message translates to:
  /// **'Commodity Image'**
  String get msgCommodityimg;

  /// No description provided for @msgBuysell.
  ///
  /// In en, this message translates to:
  /// **'Buyer/Seller'**
  String get msgBuysell;

  /// No description provided for @msgLoc.
  ///
  /// In en, this message translates to:
  /// **'4QWED+PCC,jaipur,Rajasthan 302015,India'**
  String get msgLoc;

  /// No description provided for @msgCommoditname.
  ///
  /// In en, this message translates to:
  /// **'Thick Black Mustard'**
  String get msgCommoditname;

  /// No description provided for @msgNote.
  ///
  /// In en, this message translates to:
  /// **'Contract \n Note'**
  String get msgNote;

  /// No description provided for @msgBuyer.
  ///
  /// In en, this message translates to:
  /// **'Buyer :'**
  String get msgBuyer;

  /// No description provided for @msgBuyerBest.
  ///
  /// In en, this message translates to:
  /// **'Best Buyer :'**
  String get msgBuyerBest;

  /// No description provided for @buyer.
  ///
  /// In en, this message translates to:
  /// **'Buyer'**
  String get buyer;

  /// No description provided for @seller.
  ///
  /// In en, this message translates to:
  /// **'Seller'**
  String get seller;

  /// No description provided for @msgSeller.
  ///
  /// In en, this message translates to:
  /// **'Seller :'**
  String get msgSeller;

  /// No description provided for @msgSellerBest.
  ///
  /// In en, this message translates to:
  /// **'Best Seller :'**
  String get msgSellerBest;

  /// No description provided for @msgBuyerbid.
  ///
  /// In en, this message translates to:
  /// **'Buyer Bid'**
  String get msgBuyerbid;

  /// No description provided for @msgSellerbid.
  ///
  /// In en, this message translates to:
  /// **'Seller Bid'**
  String get msgSellerbid;

  /// No description provided for @msgRate.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get msgRate;

  /// No description provided for @msgCitytruck.
  ///
  /// In en, this message translates to:
  /// **'City/Truck'**
  String get msgCitytruck;

  /// No description provided for @msgRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get msgRating;

  /// No description provided for @msgYourprice.
  ///
  /// In en, this message translates to:
  /// **'Your Price (per Qtl.)'**
  String get msgYourprice;

  /// No description provided for @msgEnterpincode.
  ///
  /// In en, this message translates to:
  /// **'Enter Pincode'**
  String get msgEnterpincode;

  /// No description provided for @msgTrucknynumber.
  ///
  /// In en, this message translates to:
  /// **'Truck Number (Optional)'**
  String get msgTrucknynumber;

  /// No description provided for @msgTrucknynu.
  ///
  /// In en, this message translates to:
  /// **'Truck Number'**
  String get msgTrucknynu;

  /// No description provided for @msgMybid.
  ///
  /// In en, this message translates to:
  /// **'My Bid'**
  String get msgMybid;

  /// No description provided for @msgIagree.
  ///
  /// In en, this message translates to:
  /// **'I agree to '**
  String get msgIagree;

  /// No description provided for @sellerCopy.
  ///
  /// In en, this message translates to:
  /// **'Seller Copy'**
  String get sellerCopy;

  /// No description provided for @buyerCopy.
  ///
  /// In en, this message translates to:
  /// **'Buyer Copy'**
  String get buyerCopy;

  /// No description provided for @msgPrint.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get msgPrint;

  /// No description provided for @msgPrintername.
  ///
  /// In en, this message translates to:
  /// **'apnagodam.com'**
  String get msgPrintername;

  /// No description provided for @msgInfo.
  ///
  /// In en, this message translates to:
  /// **'(Privet Sub-e-Market Notified by\n Government of Rajasthan)'**
  String get msgInfo;

  /// No description provided for @msgCin.
  ///
  /// In en, this message translates to:
  /// **'CIN='**
  String get msgCin;

  /// No description provided for @msgAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get msgAddress;

  /// No description provided for @emai.
  ///
  /// In en, this message translates to:
  /// **'Email contact:-'**
  String get emai;

  /// No description provided for @msgEmailadd.
  ///
  /// In en, this message translates to:
  /// **'@apnagodam.com'**
  String get msgEmailadd;

  /// No description provided for @msgLandline.
  ///
  /// In en, this message translates to:
  /// **'Landline No.:-'**
  String get msgLandline;

  /// No description provided for @msgContractno.
  ///
  /// In en, this message translates to:
  /// **'Contract Note No.'**
  String get msgContractno;

  /// No description provided for @msgBuyername.
  ///
  /// In en, this message translates to:
  /// **'Buyer Name :-'**
  String get msgBuyername;

  /// No description provided for @msgPrintdate.
  ///
  /// In en, this message translates to:
  /// **'Print Date :'**
  String get msgPrintdate;

  /// No description provided for @msgBiddate.
  ///
  /// In en, this message translates to:
  /// **'Bid date :'**
  String get msgBiddate;

  /// No description provided for @msgEnterprises.
  ///
  /// In en, this message translates to:
  /// **'Enterprises(******8410)'**
  String get msgEnterprises;

  /// No description provided for @msgCaseid.
  ///
  /// In en, this message translates to:
  /// **'Case ID :'**
  String get msgCaseid;

  /// No description provided for @msgId.
  ///
  /// In en, this message translates to:
  /// **'F2F-GROUNDNUT\n SORTEX-12122023-2051'**
  String get msgId;

  /// No description provided for @msgShipmentdet.
  ///
  /// In en, this message translates to:
  /// **'Shipment Details :-'**
  String get msgShipmentdet;

  /// No description provided for @msgSellingprice.
  ///
  /// In en, this message translates to:
  /// **'Selling Price '**
  String get msgSellingprice;

  /// No description provided for @msgTotalrecamount.
  ///
  /// In en, this message translates to:
  /// **'Total Receivable Amount :-'**
  String get msgTotalrecamount;

  /// No description provided for @msginf.
  ///
  /// In en, this message translates to:
  /// **'This is a system generated contract not needed to be signed. Please call on IVR no. 7733901154 to check it authenticity'**
  String get msginf;

  /// No description provided for @msgOutstandingt.
  ///
  /// In en, this message translates to:
  /// **'Outstanding : '**
  String get msgOutstandingt;

  /// No description provided for @msgInterst.
  ///
  /// In en, this message translates to:
  /// **'Interest : '**
  String get msgInterst;

  /// No description provided for @msgPayableammount.
  ///
  /// In en, this message translates to:
  /// **'Total Payable Amount'**
  String get msgPayableammount;

  /// No description provided for @msgPaynow.
  ///
  /// In en, this message translates to:
  /// **'Pay Now'**
  String get msgPaynow;

  /// No description provided for @msgBook.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get msgBook;

  /// No description provided for @msgSubmit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get msgSubmit;

  /// No description provided for @msgStack.
  ///
  /// In en, this message translates to:
  /// **'Stack'**
  String get msgStack;

  /// No description provided for @msgPaddy.
  ///
  /// In en, this message translates to:
  /// **'Paddy'**
  String get msgPaddy;

  /// No description provided for @msgUpdateprice.
  ///
  /// In en, this message translates to:
  /// **'Update Price and Weight'**
  String get msgUpdateprice;

  /// No description provided for @msgUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update now'**
  String get msgUpdate;

  /// No description provided for @msgApnagodam.
  ///
  /// In en, this message translates to:
  /// **'Apna Godam'**
  String get msgApnagodam;

  /// No description provided for @msgAreYousure.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this order!'**
  String get msgAreYousure;

  /// No description provided for @msgDeletetitale.
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get msgDeletetitale;

  /// No description provided for @msgStatusRunning.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get msgStatusRunning;

  /// No description provided for @msgStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get msgStatusRejected;

  /// No description provided for @msgStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get msgStatusApproved;

  /// No description provided for @msgStatusVerified.
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get msgStatusVerified;

  /// No description provided for @buySellCommoduty.
  ///
  /// In en, this message translates to:
  /// **'Buy/Sell your Commodity'**
  String get buySellCommoduty;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View all '**
  String get view;

  /// No description provided for @comList.
  ///
  /// In en, this message translates to:
  /// **'Commodity List'**
  String get comList;

  /// No description provided for @loan.
  ///
  /// In en, this message translates to:
  /// **'Loan/Finance'**
  String get loan;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @nodataFound.
  ///
  /// In en, this message translates to:
  /// **'Data Not Found !!!'**
  String get nodataFound;

  /// No description provided for @msgStatus.
  ///
  /// In en, this message translates to:
  /// **'Status : '**
  String get msgStatus;

  /// No description provided for @orderSummary.
  ///
  /// In en, this message translates to:
  /// **'Order Summary'**
  String get orderSummary;

  /// No description provided for @corporPrice.
  ///
  /// In en, this message translates to:
  /// **'Corporate Price'**
  String get corporPrice;

  /// No description provided for @varition.
  ///
  /// In en, this message translates to:
  /// **'Quality Variation'**
  String get varition;

  /// No description provided for @finalPrice.
  ///
  /// In en, this message translates to:
  /// **'Final Price'**
  String get finalPrice;

  /// No description provided for @pricing.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get pricing;

  /// No description provided for @moisture.
  ///
  /// In en, this message translates to:
  /// **'Moisture'**
  String get moisture;

  /// No description provided for @dana.
  ///
  /// In en, this message translates to:
  /// **'Dana'**
  String get dana;

  /// No description provided for @tikki.
  ///
  /// In en, this message translates to:
  /// **'Tikki'**
  String get tikki;

  /// No description provided for @black.
  ///
  /// In en, this message translates to:
  /// **'Black'**
  String get black;

  /// No description provided for @fatkan.
  ///
  /// In en, this message translates to:
  /// **'Fatkan'**
  String get fatkan;

  /// No description provided for @danthal.
  ///
  /// In en, this message translates to:
  /// **'Danthal'**
  String get danthal;

  /// No description provided for @recovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get recovery;

  /// No description provided for @weighment.
  ///
  /// In en, this message translates to:
  /// **'Weighment'**
  String get weighment;

  /// No description provided for @finalamount.
  ///
  /// In en, this message translates to:
  /// **'Final Amount'**
  String get finalamount;

  /// No description provided for @dealStatus.
  ///
  /// In en, this message translates to:
  /// **'Deal Status'**
  String get dealStatus;

  /// No description provided for @discover.
  ///
  /// In en, this message translates to:
  /// **'Price Discovery'**
  String get discover;

  /// No description provided for @assaying.
  ///
  /// In en, this message translates to:
  /// **'Assaying'**
  String get assaying;

  /// No description provided for @weighting.
  ///
  /// In en, this message translates to:
  /// **'Weighting'**
  String get weighting;

  /// No description provided for @dealComplete.
  ///
  /// In en, this message translates to:
  /// **'Deal Complete'**
  String get dealComplete;

  /// No description provided for @trip.
  ///
  /// In en, this message translates to:
  /// **'Trip Start'**
  String get trip;

  /// No description provided for @goodsDelivery.
  ///
  /// In en, this message translates to:
  /// **'Goods Delivered'**
  String get goodsDelivery;

  /// No description provided for @srnumber.
  ///
  /// In en, this message translates to:
  /// **'Sr No.'**
  String get srnumber;

  /// No description provided for @item.
  ///
  /// In en, this message translates to:
  /// **'items'**
  String get item;

  /// No description provided for @conditions.
  ///
  /// In en, this message translates to:
  /// **'Conditions'**
  String get conditions;

  /// No description provided for @loss.
  ///
  /// In en, this message translates to:
  /// **'Loss in Weight'**
  String get loss;

  /// No description provided for @lastdate.
  ///
  /// In en, this message translates to:
  /// **'Last Date'**
  String get lastdate;

  /// No description provided for @client.
  ///
  /// In en, this message translates to:
  /// **'By Client'**
  String get client;

  /// No description provided for @termCond.
  ///
  /// In en, this message translates to:
  /// **'By proceeding, you agree to our Term and Condition'**
  String get termCond;

  /// No description provided for @agreementdate.
  ///
  /// In en, this message translates to:
  /// **'Warehouse Agreement Date :-'**
  String get agreementdate;

  /// No description provided for @requestedweight.
  ///
  /// In en, this message translates to:
  /// **'Requested Weight'**
  String get requestedweight;

  /// No description provided for @slectstackType.
  ///
  /// In en, this message translates to:
  /// **'Select Stack Type'**
  String get slectstackType;

  /// No description provided for @slectType.
  ///
  /// In en, this message translates to:
  /// **'Select Type'**
  String get slectType;

  /// No description provided for @msgConditions.
  ///
  /// In en, this message translates to:
  /// **'Conditions'**
  String get msgConditions;

  /// No description provided for @msgItems.
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get msgItems;

  /// No description provided for @yourbooked.
  ///
  /// In en, this message translates to:
  /// **'Your Booked Stack'**
  String get yourbooked;

  /// No description provided for @emptystack.
  ///
  /// In en, this message translates to:
  /// **'Empty Stack'**
  String get emptystack;

  /// No description provided for @underprogress.
  ///
  /// In en, this message translates to:
  /// **'Under Progress'**
  String get underprogress;

  /// No description provided for @capacity.
  ///
  /// In en, this message translates to:
  /// **'Capacity :-'**
  String get capacity;

  /// No description provided for @occupied.
  ///
  /// In en, this message translates to:
  /// **'Occupied :-'**
  String get occupied;

  /// No description provided for @reaming.
  ///
  /// In en, this message translates to:
  /// **'Remaining :-'**
  String get reaming;

  /// No description provided for @ratecard.
  ///
  /// In en, this message translates to:
  /// **'Rate Card'**
  String get ratecard;

  /// No description provided for @warehousename.
  ///
  /// In en, this message translates to:
  /// **'Warehouse Name :'**
  String get warehousename;

  /// No description provided for @customer.
  ///
  /// In en, this message translates to:
  /// **'Customer : '**
  String get customer;

  /// No description provided for @warehouserent.
  ///
  /// In en, this message translates to:
  /// **'warehouse rent'**
  String get warehouserent;

  /// No description provided for @tenperquintal.
  ///
  /// In en, this message translates to:
  /// **'per quintal per month'**
  String get tenperquintal;

  /// No description provided for @labour.
  ///
  /// In en, this message translates to:
  /// **'Labour'**
  String get labour;

  /// No description provided for @perquentail.
  ///
  /// In en, this message translates to:
  /// **'₹ 10 per quintal per'**
  String get perquentail;

  /// No description provided for @bankwrcharge.
  ///
  /// In en, this message translates to:
  /// **'Bank W. R. charge'**
  String get bankwrcharge;

  /// No description provided for @wsaCharge.
  ///
  /// In en, this message translates to:
  /// **'WSA Charge'**
  String get wsaCharge;

  /// No description provided for @bankLendingRate.
  ///
  /// In en, this message translates to:
  /// **'Loan: 80% (after signing of agreement by the lender)'**
  String get bankLendingRate;

  /// No description provided for @rateOfInterest.
  ///
  /// In en, this message translates to:
  /// **'Rate of Interest'**
  String get rateOfInterest;

  /// No description provided for @lockInMonth.
  ///
  /// In en, this message translates to:
  /// **'Lock In Month'**
  String get lockInMonth;

  /// No description provided for @commodityArrivalDate.
  ///
  /// In en, this message translates to:
  /// **'Commodity Arrival Date'**
  String get commodityArrivalDate;

  /// No description provided for @gst.
  ///
  /// In en, this message translates to:
  /// **'1%+GST'**
  String get gst;

  /// No description provided for @fareCalculation.
  ///
  /// In en, this message translates to:
  /// **'Fare calculation will be daily. In case of dedicated stack, the fare for the entire stack will start from the first day.'**
  String get fareCalculation;

  /// No description provided for @goodswill.
  ///
  /// In en, this message translates to:
  /// **'Goods will not be released if there is any outstanding balance.'**
  String get goodswill;

  /// No description provided for @rentandinterest.
  ///
  /// In en, this message translates to:
  /// **'Rent and interest payable before the 5th of every month.'**
  String get rentandinterest;

  /// No description provided for @fumigation.
  ///
  /// In en, this message translates to:
  /// **'Fumigation and Insurance included in fare, extra for damaged goods @ ₹ 20 / Qul. fumigation charge'**
  String get fumigation;

  /// No description provided for @ifthecommodity.
  ///
  /// In en, this message translates to:
  /// **'If the commodity price is above Rs 50 per kg, then insurance charges will have to be paid separately.'**
  String get ifthecommodity;

  /// No description provided for @hasbeen.
  ///
  /// In en, this message translates to:
  /// **'Labor has been arranged at the request of the client. The warehouse is in condition of late arrival and early departure and due to labour, the vehicle has to stand at the warehouse for two days.'**
  String get hasbeen;

  /// No description provided for @rentanintrest.
  ///
  /// In en, this message translates to:
  /// **'Rent and interest will be calculated daily.'**
  String get rentanintrest;

  /// No description provided for @removingGoods.
  ///
  /// In en, this message translates to:
  /// **'Rent, interest and other expenses will have to be paid before removing the goods.'**
  String get removingGoods;

  /// No description provided for @fuminationsand.
  ///
  /// In en, this message translates to:
  /// **'Fumigation and insurance are included in the fare, but in case of damaged goods, fumigation charge of Rs 20/- per quintal will be extra.'**
  String get fuminationsand;

  /// No description provided for @theFacility.
  ///
  /// In en, this message translates to:
  /// **'The facility of labor and transport has been provided at the request of the customer, if any delay occurs related to this, Apna Warehouse will not take any responsibility for it.'**
  String get theFacility;

  /// No description provided for @photo.
  ///
  /// In en, this message translates to:
  /// **'Choose Photo'**
  String get photo;

  /// No description provided for @image.
  ///
  /// In en, this message translates to:
  /// **'GST Registration Image'**
  String get image;

  /// No description provided for @panimg.
  ///
  /// In en, this message translates to:
  /// **'PanCard Image'**
  String get panimg;

  /// No description provided for @adharimg.
  ///
  /// In en, this message translates to:
  /// **'Adhar Card Image'**
  String get adharimg;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Click here to upload your Adhar Card Image'**
  String get upload;

  /// No description provided for @apply.
  ///
  /// In en, this message translates to:
  /// **'Apply for BNPL'**
  String get apply;

  /// No description provided for @balance.
  ///
  /// In en, this message translates to:
  /// **'BNPL Balance :'**
  String get balance;

  /// No description provided for @bnpl.
  ///
  /// In en, this message translates to:
  /// **'Buy Now Pay Later'**
  String get bnpl;

  /// No description provided for @limit.
  ///
  /// In en, this message translates to:
  /// **'Maximum Limit :'**
  String get limit;

  /// No description provided for @inwordList.
  ///
  /// In en, this message translates to:
  /// **'Inward List'**
  String get inwordList;

  /// No description provided for @rulesofSbt.
  ///
  /// In en, this message translates to:
  /// **'Rules of SBT (Spot Based Trade)'**
  String get rulesofSbt;

  /// No description provided for @inThis.
  ///
  /// In en, this message translates to:
  /// **'1. In this, bidding is done on the goods kept outside the warehouse, this is only for price discovery.'**
  String get inThis;

  /// No description provided for @apnaWarehouse.
  ///
  /// In en, this message translates to:
  /// **'2. Apna Warehouse does not take any responsibility in this matter.'**
  String get apnaWarehouse;

  /// No description provided for @itisonly.
  ///
  /// In en, this message translates to:
  /// **'3. It is only a medium for price discovery.'**
  String get itisonly;

  /// No description provided for @isdoneThorgh.
  ///
  /// In en, this message translates to:
  /// **'4. In this no transaction is done through wallet.'**
  String get isdoneThorgh;

  /// No description provided for @noCharges.
  ///
  /// In en, this message translates to:
  /// **'5. No charges are taken by our warehouse.'**
  String get noCharges;

  /// No description provided for @customersAre.
  ///
  /// In en, this message translates to:
  /// **'6. Customers are rated based on the volume of trade they have done previously on the Apna Godown portal and their experience with Apna Godown. “Five Star Rating” means highly trusted customer.'**
  String get customersAre;

  /// No description provided for @enterTextAsPer.
  ///
  /// In en, this message translates to:
  /// **'Enter Text as per you want to search'**
  String get enterTextAsPer;

  /// No description provided for @vehicleNo.
  ///
  /// In en, this message translates to:
  /// **'Vehicle No'**
  String get vehicleNo;

  /// No description provided for @createDate.
  ///
  /// In en, this message translates to:
  /// **'Create Date'**
  String get createDate;

  /// No description provided for @msgBnplSummary.
  ///
  /// In en, this message translates to:
  /// **'BNPL Summary'**
  String get msgBnplSummary;

  /// No description provided for @msgLoaning.
  ///
  /// In en, this message translates to:
  /// **'Loaning'**
  String get msgLoaning;

  /// No description provided for @msgReleaseWeight.
  ///
  /// In en, this message translates to:
  /// **'Release Weight'**
  String get msgReleaseWeight;

  /// No description provided for @msgDeleteMassage.
  ///
  /// In en, this message translates to:
  /// **'Are you sure ?'**
  String get msgDeleteMassage;

  /// No description provided for @pan.
  ///
  /// In en, this message translates to:
  /// **'PAN Card'**
  String get pan;

  /// No description provided for @aadharno.
  ///
  /// In en, this message translates to:
  /// **'Aadhar No.'**
  String get aadharno;

  /// No description provided for @accountno.
  ///
  /// In en, this message translates to:
  /// **'Account No.'**
  String get accountno;

  /// No description provided for @chequeimg.
  ///
  /// In en, this message translates to:
  /// **'Bank Passbook/Cheque Image'**
  String get chequeimg;

  /// No description provided for @aadarimg.
  ///
  /// In en, this message translates to:
  /// **'Aadhar Card Image '**
  String get aadarimg;

  /// No description provided for @warehouseOutward.
  ///
  /// In en, this message translates to:
  /// **'Warehouse Outward'**
  String get warehouseOutward;

  /// No description provided for @caseid.
  ///
  /// In en, this message translates to:
  /// **'Case ID'**
  String get caseid;

  /// No description provided for @loanFrom.
  ///
  /// In en, this message translates to:
  /// **'Loan From'**
  String get loanFrom;

  /// No description provided for @requestQuantityLoan.
  ///
  /// In en, this message translates to:
  /// **'Request Quantity (QTL.)'**
  String get requestQuantityLoan;

  /// No description provided for @processingFeeLoan.
  ///
  /// In en, this message translates to:
  /// **'Processing Fees(%)'**
  String get processingFeeLoan;

  /// No description provided for @interestRateLoan.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate(%)'**
  String get interestRateLoan;

  /// No description provided for @laonPerTotalLoan.
  ///
  /// In en, this message translates to:
  /// **'Loan per Total Amount(%)'**
  String get laonPerTotalLoan;

  /// No description provided for @laonPassDaysLoan.
  ///
  /// In en, this message translates to:
  /// **'Loan Pass Days'**
  String get laonPassDaysLoan;

  /// No description provided for @requsetDateLoan.
  ///
  /// In en, this message translates to:
  /// **'Request Date'**
  String get requsetDateLoan;

  /// No description provided for @applyForBnpl.
  ///
  /// In en, this message translates to:
  /// **'Apply for BNPL'**
  String get applyForBnpl;

  /// No description provided for @passportsizeImg.
  ///
  /// In en, this message translates to:
  /// **'Selfie'**
  String get passportsizeImg;

  /// No description provided for @purchase.
  ///
  /// In en, this message translates to:
  /// **'Purchase Price(RS):'**
  String get purchase;

  /// No description provided for @commisionRate.
  ///
  /// In en, this message translates to:
  /// **'AG Commission rate :'**
  String get commisionRate;

  /// No description provided for @commisionAmount.
  ///
  /// In en, this message translates to:
  /// **'AG Commission Amount :'**
  String get commisionAmount;

  /// No description provided for @totalmandiamount.
  ///
  /// In en, this message translates to:
  /// **'Total Mandi Amount:'**
  String get totalmandiamount;

  /// No description provided for @mandiTax.
  ///
  /// In en, this message translates to:
  /// **'Mandi Tax :'**
  String get mandiTax;

  /// No description provided for @buyCommodity.
  ///
  /// In en, this message translates to:
  /// **'Someone wants to buy your commodity'**
  String get buyCommodity;

  /// No description provided for @sellerPrice.
  ///
  /// In en, this message translates to:
  /// **'Seller price (RS):-'**
  String get sellerPrice;

  /// No description provided for @quality.
  ///
  /// In en, this message translates to:
  /// **'Quality'**
  String get quality;

  /// No description provided for @broken.
  ///
  /// In en, this message translates to:
  /// **'Broken'**
  String get broken;

  /// No description provided for @thin.
  ///
  /// In en, this message translates to:
  /// **'Thin'**
  String get thin;

  /// No description provided for @twc.
  ///
  /// In en, this message translates to:
  /// **'TWC'**
  String get twc;

  /// No description provided for @fm.
  ///
  /// In en, this message translates to:
  /// **'FM'**
  String get fm;

  /// No description provided for @origin.
  ///
  /// In en, this message translates to:
  /// **'Origin'**
  String get origin;

  /// No description provided for @defined.
  ///
  /// In en, this message translates to:
  /// **'Note Defined'**
  String get defined;

  /// No description provided for @bidUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update Bid'**
  String get bidUpdate;

  /// No description provided for @addUpdate.
  ///
  /// In en, this message translates to:
  /// **'Add Bid'**
  String get addUpdate;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Data Not Found !!!'**
  String get notFound;

  /// No description provided for @submitBid.
  ///
  /// In en, this message translates to:
  /// **'Submit Bid'**
  String get submitBid;

  /// No description provided for @sufficientAmount.
  ///
  /// In en, this message translates to:
  /// **'You do not have sufficient amount to submit this bid.'**
  String get sufficientAmount;

  /// No description provided for @enoughtAmount.
  ///
  /// In en, this message translates to:
  /// **'There is not enought amount in your account.Click on the button if you want to take BNPL or call to ivr.'**
  String get enoughtAmount;

  /// No description provided for @wallet.
  ///
  /// In en, this message translates to:
  /// **'Wallet'**
  String get wallet;

  /// No description provided for @sirealno.
  ///
  /// In en, this message translates to:
  /// **'S.No'**
  String get sirealno;

  /// No description provided for @kyc.
  ///
  /// In en, this message translates to:
  /// **'KYC'**
  String get kyc;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Enter Email'**
  String get email;

  /// No description provided for @pancard.
  ///
  /// In en, this message translates to:
  /// **'Enter Pan Number'**
  String get pancard;

  /// No description provided for @adharno.
  ///
  /// In en, this message translates to:
  /// **'Enter Aadhar Number'**
  String get adharno;

  /// No description provided for @messageAadhar.
  ///
  /// In en, this message translates to:
  /// **'please enter your aadhar number'**
  String get messageAadhar;

  /// No description provided for @messagePan.
  ///
  /// In en, this message translates to:
  /// **'please enter pancard number'**
  String get messagePan;

  /// No description provided for @messageEmail.
  ///
  /// In en, this message translates to:
  /// **'please enter your aadhar number'**
  String get messageEmail;

  /// No description provided for @enterAmount.
  ///
  /// In en, this message translates to:
  /// **'Please enter your Amount'**
  String get enterAmount;

  /// No description provided for @bnplMessage.
  ///
  /// In en, this message translates to:
  /// **'There is not enough amount in your'**
  String get bnplMessage;

  /// No description provided for @intrest.
  ///
  /// In en, this message translates to:
  /// **'Accrued Interest:'**
  String get intrest;

  /// No description provided for @usedamount.
  ///
  /// In en, this message translates to:
  /// **'Used Amount'**
  String get usedamount;

  /// No description provided for @running.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get running;

  /// No description provided for @paid.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paid;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'In-Progress'**
  String get progress;

  /// No description provided for @msgSuccess.
  ///
  /// In en, this message translates to:
  /// **'Successful'**
  String get msgSuccess;

  /// No description provided for @use.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get use;

  /// No description provided for @saveScreenshoot.
  ///
  /// In en, this message translates to:
  /// **'Save Screenshot'**
  String get saveScreenshoot;

  /// No description provided for @captureScr.
  ///
  /// In en, this message translates to:
  /// **'Captured widget screenshot'**
  String get captureScr;

  /// No description provided for @qlt.
  ///
  /// In en, this message translates to:
  /// **'Quality :-'**
  String get qlt;

  /// No description provided for @bids.
  ///
  /// In en, this message translates to:
  /// **'Bids'**
  String get bids;

  /// No description provided for @shipmentCode.
  ///
  /// In en, this message translates to:
  /// **'Shipment Code'**
  String get shipmentCode;

  /// No description provided for @selectTerminal.
  ///
  /// In en, this message translates to:
  /// **'Please select Terminal'**
  String get selectTerminal;

  /// No description provided for @order.
  ///
  /// In en, this message translates to:
  /// **'Add Order'**
  String get order;

  /// No description provided for @terminal.
  ///
  /// In en, this message translates to:
  /// **'Select Terminal'**
  String get terminal;

  /// No description provided for @place.
  ///
  /// In en, this message translates to:
  /// **'Own Place'**
  String get place;

  /// No description provided for @warehouse.
  ///
  /// In en, this message translates to:
  /// **'Warehouse'**
  String get warehouse;

  /// No description provided for @delivaryAt.
  ///
  /// In en, this message translates to:
  /// **'Delivery at :'**
  String get delivaryAt;

  /// No description provided for @chooseBank.
  ///
  /// In en, this message translates to:
  /// **'Choose Bank First'**
  String get chooseBank;

  /// No description provided for @upi.
  ///
  /// In en, this message translates to:
  /// **'UPI'**
  String get upi;

  /// No description provided for @rtgs.
  ///
  /// In en, this message translates to:
  /// **'RTGS'**
  String get rtgs;

  /// No description provided for @cheque.
  ///
  /// In en, this message translates to:
  /// **'Cheque'**
  String get cheque;

  /// No description provided for @enter.
  ///
  /// In en, this message translates to:
  /// **'Enter here'**
  String get enter;

  /// No description provided for @messagePayment.
  ///
  /// In en, this message translates to:
  /// **'please select a payment mode'**
  String get messagePayment;

  /// No description provided for @messageRcptno.
  ///
  /// In en, this message translates to:
  /// **'please type your receipt no'**
  String get messageRcptno;

  /// No description provided for @chooseBankslip.
  ///
  /// In en, this message translates to:
  /// **'please choose your bank Slip/Cheque photo'**
  String get chooseBankslip;

  /// No description provided for @enterAmt.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount :'**
  String get enterAmt;

  /// No description provided for @selectLang.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLang;

  /// No description provided for @eng.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get eng;

  /// No description provided for @hin.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hin;

  /// No description provided for @kn.
  ///
  /// In en, this message translates to:
  /// **'Kannada'**
  String get kn;

  /// No description provided for @sbtTC.
  ///
  /// In en, this message translates to:
  /// **'SBT T&C.'**
  String get sbtTC;

  /// No description provided for @selectCom.
  ///
  /// In en, this message translates to:
  /// **'Please select Commodity'**
  String get selectCom;

  /// No description provided for @bidding.
  ///
  /// In en, this message translates to:
  /// **'Bidding'**
  String get bidding;

  /// No description provided for @yourPrice.
  ///
  /// In en, this message translates to:
  /// **'Your Price:'**
  String get yourPrice;

  /// No description provided for @tCOne.
  ///
  /// In en, this message translates to:
  /// **'Rs 10 labour will be charged extra'**
  String get tCOne;

  /// No description provided for @tCTwo.
  ///
  /// In en, this message translates to:
  /// **'Transportation has to be arranged by the buyer at the time of commodity withdrawal from warehouse'**
  String get tCTwo;

  /// No description provided for @tCThree.
  ///
  /// In en, this message translates to:
  /// **'1% AG warehouse commission to be paid by the buyee extra '**
  String get tCThree;

  /// No description provided for @tCFour.
  ///
  /// In en, this message translates to:
  /// **'If the commodity is non tax-paid, Mandi tax will be charged extra'**
  String get tCFour;

  /// No description provided for @takeBnpl.
  ///
  /// In en, this message translates to:
  /// **'Take BNPL'**
  String get takeBnpl;

  /// No description provided for @trader.
  ///
  /// In en, this message translates to:
  /// **'Trader:-'**
  String get trader;

  /// No description provided for @bidPrice.
  ///
  /// In en, this message translates to:
  /// **'Bid Price'**
  String get bidPrice;

  /// No description provided for @bidError.
  ///
  /// In en, this message translates to:
  /// **'Please enter bid price'**
  String get bidError;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price(/Qtl.)'**
  String get price;

  /// No description provided for @detail.
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get detail;

  /// No description provided for @totalBages.
  ///
  /// In en, this message translates to:
  /// **'Total Bages'**
  String get totalBages;

  /// No description provided for @nA.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get nA;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip Now'**
  String get skip;

  /// No description provided for @panImg.
  ///
  /// In en, this message translates to:
  /// **'Pan Card Image '**
  String get panImg;

  /// No description provided for @gstImg.
  ///
  /// In en, this message translates to:
  /// **'GST Image '**
  String get gstImg;

  /// No description provided for @debit.
  ///
  /// In en, this message translates to:
  /// **'Debit Amount'**
  String get debit;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @vehicleno.
  ///
  /// In en, this message translates to:
  /// **'Vehicle No:-'**
  String get vehicleno;

  /// No description provided for @driverno.
  ///
  /// In en, this message translates to:
  /// **'Driver No'**
  String get driverno;

  /// No description provided for @enterAmuont.
  ///
  /// In en, this message translates to:
  /// **'Enter Withdraw Amount'**
  String get enterAmuont;

  /// No description provided for @notSelected.
  ///
  /// In en, this message translates to:
  /// **'Date is not selected'**
  String get notSelected;

  /// No description provided for @connect.
  ///
  /// In en, this message translates to:
  /// **'Connect With Us'**
  String get connect;

  /// No description provided for @sendOtp.
  ///
  /// In en, this message translates to:
  /// **'Send OTP'**
  String get sendOtp;

  /// No description provided for @messageValidation.
  ///
  /// In en, this message translates to:
  /// **'Enter Valid Mobile Number'**
  String get messageValidation;

  /// No description provided for @hintText.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get hintText;

  /// No description provided for @privecy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy.'**
  String get privecy;

  /// No description provided for @wantToSellEmandi.
  ///
  /// In en, this message translates to:
  /// **'Want to Sell on E-Mandi'**
  String get wantToSellEmandi;

  /// No description provided for @rentCalculation.
  ///
  /// In en, this message translates to:
  /// **'Rent Calculation'**
  String get rentCalculation;

  /// No description provided for @fromTo.
  ///
  /// In en, this message translates to:
  /// **'From To'**
  String get fromTo;

  /// No description provided for @period.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get period;

  /// No description provided for @totalRentAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Rent Amount'**
  String get totalRentAmount;

  /// No description provided for @totalPandigAmount.
  ///
  /// In en, this message translates to:
  /// **'Total pending amount'**
  String get totalPandigAmount;

  /// No description provided for @rentInterstLoanBnpl.
  ///
  /// In en, this message translates to:
  /// **'(Rent + Interest + Loan + BNPL)'**
  String get rentInterstLoanBnpl;

  /// No description provided for @approxBalanceAmount.
  ///
  /// In en, this message translates to:
  /// **'Approx Balance Amount'**
  String get approxBalanceAmount;

  /// No description provided for @updatePrice.
  ///
  /// In en, this message translates to:
  /// **'Update Price'**
  String get updatePrice;

  /// No description provided for @clickHere.
  ///
  /// In en, this message translates to:
  /// **'Click here'**
  String get clickHere;

  /// No description provided for @qualityReport.
  ///
  /// In en, this message translates to:
  /// **'Quality Report'**
  String get qualityReport;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @distanceKm.
  ///
  /// In en, this message translates to:
  /// **'Distance(Km.) : '**
  String get distanceKm;

  /// No description provided for @mobileNo.
  ///
  /// In en, this message translates to:
  /// **'Mobile No. : '**
  String get mobileNo;

  /// No description provided for @yourBid.
  ///
  /// In en, this message translates to:
  /// **'Your Bid'**
  String get yourBid;

  /// No description provided for @priceLp.
  ///
  /// In en, this message translates to:
  /// **'Price : '**
  String get priceLp;

  /// No description provided for @trackRide.
  ///
  /// In en, this message translates to:
  /// **'Track Ride'**
  String get trackRide;

  /// No description provided for @rejectRide.
  ///
  /// In en, this message translates to:
  /// **'Reject Ride'**
  String get rejectRide;

  /// No description provided for @lastYearPrice.
  ///
  /// In en, this message translates to:
  /// **'Last Year Price'**
  String get lastYearPrice;

  /// No description provided for @currentYearPrice.
  ///
  /// In en, this message translates to:
  /// **'Current Year Price'**
  String get currentYearPrice;

  /// No description provided for @myPrice.
  ///
  /// In en, this message translates to:
  /// **'My Price'**
  String get myPrice;

  /// No description provided for @cgst.
  ///
  /// In en, this message translates to:
  /// **'CGST'**
  String get cgst;

  /// No description provided for @sgst.
  ///
  /// In en, this message translates to:
  /// **'SGST'**
  String get sgst;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'In Own Account'**
  String get account;

  /// No description provided for @bank.
  ///
  /// In en, this message translates to:
  /// **'Bank Name :-'**
  String get bank;

  /// No description provided for @accountnu.
  ///
  /// In en, this message translates to:
  /// **'Account Number :-'**
  String get accountnu;

  /// No description provided for @ifscCode.
  ///
  /// In en, this message translates to:
  /// **'IFSC Code :-'**
  String get ifscCode;

  /// No description provided for @lpList.
  ///
  /// In en, this message translates to:
  /// **'LP List'**
  String get lpList;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @ownVehicle.
  ///
  /// In en, this message translates to:
  /// **'To use Own Vehicle'**
  String get ownVehicle;

  /// No description provided for @godamVehicle.
  ///
  /// In en, this message translates to:
  /// **'To use Apana Godam Vehicle'**
  String get godamVehicle;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @ivr.
  ///
  /// In en, this message translates to:
  /// **'IVR'**
  String get ivr;

  /// No description provided for @wbt.
  ///
  /// In en, this message translates to:
  /// **'Warehouse Based Trade'**
  String get wbt;

  /// No description provided for @sbt.
  ///
  /// In en, this message translates to:
  /// **'Spot Based Trade'**
  String get sbt;

  /// No description provided for @marking.
  ///
  /// In en, this message translates to:
  /// **'Delivery Marking'**
  String get marking;

  /// No description provided for @deals.
  ///
  /// In en, this message translates to:
  /// **'Deals'**
  String get deals;

  /// No description provided for @l.
  ///
  /// In en, this message translates to:
  /// **'L:'**
  String get l;

  /// No description provided for @h.
  ///
  /// In en, this message translates to:
  /// **'H:'**
  String get h;

  /// No description provided for @b.
  ///
  /// In en, this message translates to:
  /// **'B:'**
  String get b;

  /// No description provided for @s.
  ///
  /// In en, this message translates to:
  /// **'S:'**
  String get s;

  /// No description provided for @massegeWeight.
  ///
  /// In en, this message translates to:
  /// **'Please fill your weight'**
  String get massegeWeight;

  /// No description provided for @massegePrice.
  ///
  /// In en, this message translates to:
  /// **'Please fill your price'**
  String get massegePrice;

  /// No description provided for @massegePin.
  ///
  /// In en, this message translates to:
  /// **'Please fill your Pincode'**
  String get massegePin;

  /// No description provided for @massegePinlenth.
  ///
  /// In en, this message translates to:
  /// **'Pincode must be six digits'**
  String get massegePinlenth;

  /// No description provided for @panNo.
  ///
  /// In en, this message translates to:
  /// **'PAN NO:-'**
  String get panNo;

  /// No description provided for @agroSale.
  ///
  /// In en, this message translates to:
  /// **'Hindustan Agro  Sales'**
  String get agroSale;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'done'**
  String get done;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @perQntl.
  ///
  /// In en, this message translates to:
  /// **'per quintal'**
  String get perQntl;

  /// No description provided for @monthOne.
  ///
  /// In en, this message translates to:
  /// **'1 st Month : 2%'**
  String get monthOne;

  /// No description provided for @monthTwo.
  ///
  /// In en, this message translates to:
  /// **'2nd Month : 1.75%'**
  String get monthTwo;

  /// No description provided for @monthThree.
  ///
  /// In en, this message translates to:
  /// **'3nd Month : 1.50%'**
  String get monthThree;

  /// No description provided for @monthFour.
  ///
  /// In en, this message translates to:
  /// **'4th Month : 1.25%'**
  String get monthFour;

  /// No description provided for @monthFive.
  ///
  /// In en, this message translates to:
  /// **'5th Month : 1%%'**
  String get monthFive;

  /// No description provided for @monthSix.
  ///
  /// In en, this message translates to:
  /// **'6th Month : 0.75%'**
  String get monthSix;

  /// No description provided for @monthSeven.
  ///
  /// In en, this message translates to:
  /// **'7th Month : 0.50%'**
  String get monthSeven;

  /// No description provided for @monthEight.
  ///
  /// In en, this message translates to:
  /// **'8th Month : 0.25%'**
  String get monthEight;

  /// No description provided for @monthNine.
  ///
  /// In en, this message translates to:
  /// **'9th Month : 0%'**
  String get monthNine;

  /// No description provided for @msgTermCon.
  ///
  /// In en, this message translates to:
  /// **'By proceeding,you agree to our Term and Conditions'**
  String get msgTermCon;

  /// No description provided for @deliveryDetail.
  ///
  /// In en, this message translates to:
  /// **'Delivery Detail'**
  String get deliveryDetail;

  /// No description provided for @pickupAt.
  ///
  /// In en, this message translates to:
  /// **'Pickup at'**
  String get pickupAt;

  /// No description provided for @distance.
  ///
  /// In en, this message translates to:
  /// **'Distance'**
  String get distance;

  /// No description provided for @commodityDeails.
  ///
  /// In en, this message translates to:
  /// **'Commodity Details'**
  String get commodityDeails;

  /// No description provided for @itemPackage.
  ///
  /// In en, this message translates to:
  /// **'Item/Package'**
  String get itemPackage;

  /// No description provided for @bookAstock.
  ///
  /// In en, this message translates to:
  /// **'Book a Stock'**
  String get bookAstock;

  /// No description provided for @bookingAccepted.
  ///
  /// In en, this message translates to:
  /// **'Booking Accepted'**
  String get bookingAccepted;

  /// No description provided for @onTheWay.
  ///
  /// In en, this message translates to:
  /// **'on the way'**
  String get onTheWay;

  /// No description provided for @readyToPickup.
  ///
  /// In en, this message translates to:
  /// **'Ready to pickup'**
  String get readyToPickup;

  /// No description provided for @finalWeightOf.
  ///
  /// In en, this message translates to:
  /// **'Final Weight of : '**
  String get finalWeightOf;

  /// No description provided for @finalPriceOf.
  ///
  /// In en, this message translates to:
  /// **'Final Price of '**
  String get finalPriceOf;

  /// No description provided for @newPriceInQti.
  ///
  /// In en, this message translates to:
  /// **'New Price in QTI '**
  String get newPriceInQti;

  /// No description provided for @principal.
  ///
  /// In en, this message translates to:
  /// **'Principal Amount'**
  String get principal;

  /// No description provided for @intPeriod.
  ///
  /// In en, this message translates to:
  /// **'Interest Period'**
  String get intPeriod;

  /// No description provided for @rate.
  ///
  /// In en, this message translates to:
  /// **'Effective Rate (qtl)'**
  String get rate;

  /// No description provided for @payable.
  ///
  /// In en, this message translates to:
  /// **'Interest Payable'**
  String get payable;

  /// No description provided for @remainingBalance.
  ///
  /// In en, this message translates to:
  /// **'Wallet Remaining Balance'**
  String get remainingBalance;

  /// No description provided for @bnpl_1.
  ///
  /// In en, this message translates to:
  /// **'B.N.P.L.'**
  String get bnpl_1;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'You cannot sell these goods because your balance is negative (-). IVR please Contact with'**
  String get failed;

  /// No description provided for @bnplAmount.
  ///
  /// In en, this message translates to:
  /// **'BNPL Amount'**
  String get bnplAmount;

  /// No description provided for @bnplInterest.
  ///
  /// In en, this message translates to:
  /// **'BNPL  Interest'**
  String get bnplInterest;

  /// No description provided for @walletRemainig.
  ///
  /// In en, this message translates to:
  /// **'Wallet Remaining Balance'**
  String get walletRemainig;

  /// No description provided for @alert.
  ///
  /// In en, this message translates to:
  /// **'This weight should  not greater than your inventory Quantity  !!!'**
  String get alert;

  /// No description provided for @declineMmsg.
  ///
  /// In en, this message translates to:
  /// **'are you sure you want to decline this order?'**
  String get declineMmsg;

  /// No description provided for @confirmBooking.
  ///
  /// In en, this message translates to:
  /// **' has accepted your order. Please contact him to confirm'**
  String get confirmBooking;

  /// No description provided for @ontheWay.
  ///
  /// In en, this message translates to:
  /// **' is on the way to your I...'**
  String get ontheWay;

  /// No description provided for @pickup.
  ///
  /// In en, this message translates to:
  /// **' is ready to pickup you'**
  String get pickup;

  /// No description provided for @sms.
  ///
  /// In en, this message translates to:
  /// **'SMS'**
  String get sms;

  /// No description provided for @call.
  ///
  /// In en, this message translates to:
  /// **'Call'**
  String get call;

  /// No description provided for @stockDetail.
  ///
  /// In en, this message translates to:
  /// **'Stock Details'**
  String get stockDetail;

  /// No description provided for @totalWeight.
  ///
  /// In en, this message translates to:
  /// **'Total Weight'**
  String get totalWeight;

  /// No description provided for @released.
  ///
  /// In en, this message translates to:
  /// **'Released : '**
  String get released;

  /// No description provided for @funded.
  ///
  /// In en, this message translates to:
  /// **'Funded : '**
  String get funded;

  /// No description provided for @selectYourTerminal.
  ///
  /// In en, this message translates to:
  /// **'Please select your Terminal'**
  String get selectYourTerminal;

  /// No description provided for @selectYourCommodity.
  ///
  /// In en, this message translates to:
  /// **'Please select your Commodity'**
  String get selectYourCommodity;

  /// No description provided for @selectYourWeight.
  ///
  /// In en, this message translates to:
  /// **'Please fill your weight'**
  String get selectYourWeight;

  /// No description provided for @selectYourVehicle.
  ///
  /// In en, this message translates to:
  /// **'Please fill your Vehicle No.'**
  String get selectYourVehicle;

  /// No description provided for @selectYourDriver.
  ///
  /// In en, this message translates to:
  /// **'Please fill your Driver No.'**
  String get selectYourDriver;

  /// No description provided for @selectYourVehicleType.
  ///
  /// In en, this message translates to:
  /// **'Please Select Vehicle Type'**
  String get selectYourVehicleType;

  /// No description provided for @selectCommodity.
  ///
  /// In en, this message translates to:
  /// **'Select Commodity'**
  String get selectCommodity;

  /// No description provided for @customerCopy.
  ///
  /// In en, this message translates to:
  /// **'Customer Copy'**
  String get customerCopy;

  /// No description provided for @doYouWantTo.
  ///
  /// In en, this message translates to:
  /// **'Do you want to really exit the app?'**
  String get doYouWantTo;

  /// No description provided for @addMoneySummury.
  ///
  /// In en, this message translates to:
  /// **'Add Money Summary'**
  String get addMoneySummury;

  /// No description provided for @paymentMode.
  ///
  /// In en, this message translates to:
  /// **'Payment Mode*'**
  String get paymentMode;

  /// No description provided for @paymentAmount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get paymentAmount;

  /// No description provided for @withdrawalStatement.
  ///
  /// In en, this message translates to:
  /// **'Withdrawal Statement'**
  String get withdrawalStatement;

  /// No description provided for @requestAmountty.
  ///
  /// In en, this message translates to:
  /// **'Request Amount'**
  String get requestAmountty;

  /// No description provided for @approvedAmountty.
  ///
  /// In en, this message translates to:
  /// **'Approved Amount'**
  String get approvedAmountty;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @submitted.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;

  /// No description provided for @passportValid.
  ///
  /// In en, this message translates to:
  /// **'Please Choose Your Passport Size Photo'**
  String get passportValid;

  /// No description provided for @passbookValid.
  ///
  /// In en, this message translates to:
  /// **'Please Choose Your Passbook/Cheque Image'**
  String get passbookValid;

  /// No description provided for @youCanApply.
  ///
  /// In en, this message translates to:
  /// **'You can apply for BNPL amount. Call to IVR to get permission to use BNPL amount in Corporate buying.'**
  String get youCanApply;

  /// No description provided for @youCanBnpl.
  ///
  /// In en, this message translates to:
  /// **'This price includes all the expenses like market tax, apna godown commission,gunny bags and the quality values are as follows.'**
  String get youCanBnpl;

  /// No description provided for @rateUs.
  ///
  /// In en, this message translates to:
  /// **'Rate us'**
  String get rateUs;

  /// No description provided for @mandiSmaiti.
  ///
  /// In en, this message translates to:
  /// **'Mandi Samiti :'**
  String get mandiSmaiti;

  /// No description provided for @mandiTaxAmount.
  ///
  /// In en, this message translates to:
  /// **'Mandi Tax Amount :'**
  String get mandiTaxAmount;

  /// No description provided for @dealAmounttttt.
  ///
  /// In en, this message translates to:
  /// **'Deal Amount :'**
  String get dealAmounttttt;

  /// No description provided for @qvAmounttttt.
  ///
  /// In en, this message translates to:
  /// **'QV Amount :'**
  String get qvAmounttttt;

  /// No description provided for @settlementAmounttttt.
  ///
  /// In en, this message translates to:
  /// **'Settlement Amount :'**
  String get settlementAmounttttt;

  /// No description provided for @hdfc.
  ///
  /// In en, this message translates to:
  /// **'HDFC Bank'**
  String get hdfc;

  /// No description provided for @accNo.
  ///
  /// In en, this message translates to:
  /// **'HDFC0003586'**
  String get accNo;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @beneficiaryName.
  ///
  /// In en, this message translates to:
  /// **'Beneficiary Name'**
  String get beneficiaryName;

  /// No description provided for @bankChanged.
  ///
  /// In en, this message translates to:
  /// **'Our bank details are changed. Please transfer the payment only on the bank details mentioned in the app. Do not share these bank details with anyone, including our agents.'**
  String get bankChanged;

  /// No description provided for @commodityWarning.
  ///
  /// In en, this message translates to:
  /// **'It is mandatory to lift paddy from the warehouse before March 31.'**
  String get commodityWarning;

  /// No description provided for @holdSummary.
  ///
  /// In en, this message translates to:
  /// **'Hold Summary'**
  String get holdSummary;

  /// No description provided for @loadCharge.
  ///
  /// In en, this message translates to:
  /// **'Load Charge'**
  String get loadCharge;

  /// No description provided for @transport.
  ///
  /// In en, this message translates to:
  /// **'Transport'**
  String get transport;

  /// No description provided for @entryLoad.
  ///
  /// In en, this message translates to:
  /// **'Entry Load'**
  String get entryLoad;

  /// No description provided for @purchaseOrderList.
  ///
  /// In en, this message translates to:
  /// **'Purchase Order List'**
  String get purchaseOrderList;

  /// No description provided for @poNo.
  ///
  /// In en, this message translates to:
  /// **'P.O. No.'**
  String get poNo;

  /// No description provided for @deliveredQty.
  ///
  /// In en, this message translates to:
  /// **'Delivered Quantity'**
  String get deliveredQty;

  /// No description provided for @availableQty.
  ///
  /// In en, this message translates to:
  /// **'Available Qty..'**
  String get availableQty;

  /// No description provided for @holdQty.
  ///
  /// In en, this message translates to:
  /// **'Hold Qty.'**
  String get holdQty;

  /// No description provided for @poImage.
  ///
  /// In en, this message translates to:
  /// **'P.O. Image'**
  String get poImage;

  /// No description provided for @buyerAddress.
  ///
  /// In en, this message translates to:
  /// **'Buyer Address'**
  String get buyerAddress;

  /// No description provided for @deliveryPincode.
  ///
  /// In en, this message translates to:
  /// **'Delivery Pincode'**
  String get deliveryPincode;

  /// No description provided for @qualityCondition.
  ///
  /// In en, this message translates to:
  /// **'Quality Condition'**
  String get qualityCondition;

  /// No description provided for @pODetails.
  ///
  /// In en, this message translates to:
  /// **'PO Details'**
  String get pODetails;

  /// No description provided for @updatePurchaseOrder.
  ///
  /// In en, this message translates to:
  /// **'Update Purchase Order'**
  String get updatePurchaseOrder;

  /// No description provided for @pendingQuantity.
  ///
  /// In en, this message translates to:
  /// **'Pending Quantity'**
  String get pendingQuantity;

  /// No description provided for @tripRequests.
  ///
  /// In en, this message translates to:
  /// **'Transport Requests'**
  String get tripRequests;

  /// No description provided for @createTripRequests.
  ///
  /// In en, this message translates to:
  /// **'Create Transport Requests'**
  String get createTripRequests;

  /// No description provided for @dealId.
  ///
  /// In en, this message translates to:
  /// **'Deal ID'**
  String get dealId;

  /// No description provided for @tripEndPending.
  ///
  /// In en, this message translates to:
  /// **'Trip End Pending'**
  String get tripEndPending;

  /// No description provided for @caseIdPending.
  ///
  /// In en, this message translates to:
  /// **'Case Id Pending'**
  String get caseIdPending;

  /// No description provided for @pressBackAgainToExit.
  ///
  /// In en, this message translates to:
  /// **'Press back again to exit'**
  String get pressBackAgainToExit;

  /// No description provided for @viewAllWarehouses.
  ///
  /// In en, this message translates to:
  /// **'View all warehouses'**
  String get viewAllWarehouses;

  /// No description provided for @bidTime.
  ///
  /// In en, this message translates to:
  /// **'Bid Time: '**
  String get bidTime;

  /// No description provided for @bidTime_1.
  ///
  /// In en, this message translates to:
  /// **'Bid Time'**
  String get bidTime_1;

  /// No description provided for @lastTradePrice.
  ///
  /// In en, this message translates to:
  /// **'Last Trade Price: '**
  String get lastTradePrice;

  /// No description provided for @lastTradePrice_1.
  ///
  /// In en, this message translates to:
  /// **'Last Trade Price'**
  String get lastTradePrice_1;

  /// No description provided for @msgLicenseDetails.
  ///
  /// In en, this message translates to:
  /// **'License Details'**
  String get msgLicenseDetails;

  /// No description provided for @msgLicenseNo.
  ///
  /// In en, this message translates to:
  /// **'License No.'**
  String get msgLicenseNo;

  /// No description provided for @msgLicenseType.
  ///
  /// In en, this message translates to:
  /// **'License Type'**
  String get msgLicenseType;

  /// No description provided for @msgLicenseHolder.
  ///
  /// In en, this message translates to:
  /// **'License Holder'**
  String get msgLicenseHolder;

  /// No description provided for @msgDistrict.
  ///
  /// In en, this message translates to:
  /// **'District'**
  String get msgDistrict;

  /// No description provided for @msgState.
  ///
  /// In en, this message translates to:
  /// **'State'**
  String get msgState;

  /// No description provided for @msgPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get msgPhone;

  /// No description provided for @msgIssueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue Date'**
  String get msgIssueDate;

  /// No description provided for @msgExpiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get msgExpiryDate;

  /// No description provided for @msgClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get msgClose;

  /// No description provided for @msgGrnRequestList.
  ///
  /// In en, this message translates to:
  /// **'GRN Request List'**
  String get msgGrnRequestList;

  /// No description provided for @msgNoDataFound.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get msgNoDataFound;

  /// No description provided for @msgOrderId.
  ///
  /// In en, this message translates to:
  /// **'Order ID'**
  String get msgOrderId;

  /// No description provided for @msgRequestDate.
  ///
  /// In en, this message translates to:
  /// **'Request Date'**
  String get msgRequestDate;

  /// No description provided for @msgSalesStatus.
  ///
  /// In en, this message translates to:
  /// **'Sales Status'**
  String get msgSalesStatus;

  /// No description provided for @msgVehicleNumber.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Number'**
  String get msgVehicleNumber;

  /// No description provided for @msgDriverNumber.
  ///
  /// In en, this message translates to:
  /// **'Driver Number'**
  String get msgDriverNumber;

  /// No description provided for @msgKantaParchi.
  ///
  /// In en, this message translates to:
  /// **'Kanta Parchi'**
  String get msgKantaParchi;

  /// No description provided for @msgBillty.
  ///
  /// In en, this message translates to:
  /// **'Billty'**
  String get msgBillty;

  /// No description provided for @msgDraftInvoice.
  ///
  /// In en, this message translates to:
  /// **'Draft Invoice'**
  String get msgDraftInvoice;

  /// No description provided for @msgInvoiceCopy.
  ///
  /// In en, this message translates to:
  /// **'Invoice Copy'**
  String get msgInvoiceCopy;

  /// No description provided for @msgGrn.
  ///
  /// In en, this message translates to:
  /// **'GRN'**
  String get msgGrn;

  /// No description provided for @msgReceivingKantaParchi.
  ///
  /// In en, this message translates to:
  /// **'Receiving Kanta Parchi'**
  String get msgReceivingKantaParchi;

  /// No description provided for @msgChangeLanguage.
  ///
  /// In en, this message translates to:
  /// **'Change Language'**
  String get msgChangeLanguage;

  /// No description provided for @msgChangeLanguageContent.
  ///
  /// In en, this message translates to:
  /// **'Would you like to change the app language?'**
  String get msgChangeLanguageContent;

  /// No description provided for @msgNo.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get msgNo;

  /// No description provided for @msgYes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get msgYes;

  /// No description provided for @msgSpotDeals.
  ///
  /// In en, this message translates to:
  /// **'Spot Deals'**
  String get msgSpotDeals;

  /// No description provided for @msgBookWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Book Warehouse'**
  String get msgBookWarehouse;

  /// No description provided for @msgDispatchRequests.
  ///
  /// In en, this message translates to:
  /// **'Dispatch Requests'**
  String get msgDispatchRequests;

  /// No description provided for @msgCreateDispatchRequest.
  ///
  /// In en, this message translates to:
  /// **'Create Dispatch Request'**
  String get msgCreateDispatchRequest;

  /// No description provided for @msgLocationDetails.
  ///
  /// In en, this message translates to:
  /// **'Location Details'**
  String get msgLocationDetails;

  /// No description provided for @msgPinCode.
  ///
  /// In en, this message translates to:
  /// **'Pin Code'**
  String get msgPinCode;

  /// No description provided for @msgWeightQuantity.
  ///
  /// In en, this message translates to:
  /// **'Weight & Quantity'**
  String get msgWeightQuantity;

  /// No description provided for @msgWeightQuintals.
  ///
  /// In en, this message translates to:
  /// **'Weight (in Quintals)'**
  String get msgWeightQuintals;

  /// No description provided for @msgComplianceSales.
  ///
  /// In en, this message translates to:
  /// **'Compliance & Sales'**
  String get msgComplianceSales;

  /// No description provided for @msgMandiCompliance.
  ///
  /// In en, this message translates to:
  /// **'Mandi Compliance'**
  String get msgMandiCompliance;

  /// No description provided for @msgTransportInfo.
  ///
  /// In en, this message translates to:
  /// **'Transport Information'**
  String get msgTransportInfo;

  /// No description provided for @msgTransportType.
  ///
  /// In en, this message translates to:
  /// **'Transport Type'**
  String get msgTransportType;

  /// No description provided for @msgVehicleType.
  ///
  /// In en, this message translates to:
  /// **'Vehicle Type'**
  String get msgVehicleType;

  /// No description provided for @msgBiltyNumber.
  ///
  /// In en, this message translates to:
  /// **'Bilty Number'**
  String get msgBiltyNumber;

  /// No description provided for @msgUpdateQuality.
  ///
  /// In en, this message translates to:
  /// **'Update Quality'**
  String get msgUpdateQuality;

  /// No description provided for @msgAddImages.
  ///
  /// In en, this message translates to:
  /// **'Add Images'**
  String get msgAddImages;

  /// No description provided for @msgFinalSubmission.
  ///
  /// In en, this message translates to:
  /// **'Final Submission'**
  String get msgFinalSubmission;

  /// No description provided for @msgRejectRequest.
  ///
  /// In en, this message translates to:
  /// **'Reject Request'**
  String get msgRejectRequest;

  /// No description provided for @msgRejectDispatchRequest.
  ///
  /// In en, this message translates to:
  /// **'Reject Dispatch Request'**
  String get msgRejectDispatchRequest;

  /// No description provided for @msgCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get msgCancel;

  /// No description provided for @msgReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get msgReject;

  /// No description provided for @msgPendingApproval.
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get msgPendingApproval;

  /// No description provided for @aGCommission.
  ///
  /// In en, this message translates to:
  /// **'AG Commission'**
  String get aGCommission;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @balanceSpaceInMixedStacks.
  ///
  /// In en, this message translates to:
  /// **'Balance space in mixed Stacks'**
  String get balanceSpaceInMixedStacks;

  /// No description provided for @bookWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Book Warehouse'**
  String get bookWarehouse;

  /// No description provided for @bookingRequests.
  ///
  /// In en, this message translates to:
  /// **'Booking Requests'**
  String get bookingRequests;

  /// No description provided for @broadListingsOfBestStorageLocations.
  ///
  /// In en, this message translates to:
  /// **'Broad listings of Best Storage Locations'**
  String get broadListingsOfBestStorageLocations;

  /// No description provided for @cCTVPending.
  ///
  /// In en, this message translates to:
  /// **'CCTV Pending'**
  String get cCTVPending;

  /// No description provided for @cCTVReport.
  ///
  /// In en, this message translates to:
  /// **'CCTV Report'**
  String get cCTVReport;

  /// No description provided for @calculateQuality.
  ///
  /// In en, this message translates to:
  /// **'Calculate Quality'**
  String get calculateQuality;

  /// No description provided for @cancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get cancelled;

  /// No description provided for @capacity_1.
  ///
  /// In en, this message translates to:
  /// **'Capacity'**
  String get capacity_1;

  /// No description provided for @capturePOImage.
  ///
  /// In en, this message translates to:
  /// **'Capture PO Image'**
  String get capturePOImage;

  /// No description provided for @charges.
  ///
  /// In en, this message translates to:
  /// **'Charges'**
  String get charges;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @commodities.
  ///
  /// In en, this message translates to:
  /// **'Commodities'**
  String get commodities;

  /// No description provided for @commodityPrice.
  ///
  /// In en, this message translates to:
  /// **'Commodity Price'**
  String get commodityPrice;

  /// No description provided for @commodityWeight.
  ///
  /// In en, this message translates to:
  /// **'Commodity Weight'**
  String get commodityWeight;

  /// No description provided for @completeProfile.
  ///
  /// In en, this message translates to:
  /// **'Complete Profile'**
  String get completeProfile;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @deliveryMarking.
  ///
  /// In en, this message translates to:
  /// **'Delivery Marking'**
  String get deliveryMarking;

  /// No description provided for @deliveryQuantity.
  ///
  /// In en, this message translates to:
  /// **'Delivery Quantity'**
  String get deliveryQuantity;

  /// No description provided for @dispatchRequest.
  ///
  /// In en, this message translates to:
  /// **'Dispatch Request'**
  String get dispatchRequest;

  /// No description provided for @doYouHaveValidLicense.
  ///
  /// In en, this message translates to:
  /// **'Do you have valid license?'**
  String get doYouHaveValidLicense;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @enterPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter Price'**
  String get enterPrice;

  /// No description provided for @enterYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Mobile Number'**
  String get enterYourMobileNumber;

  /// No description provided for @enterYourName.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Name'**
  String get enterYourName;

  /// No description provided for @errorLoadingData.
  ///
  /// In en, this message translates to:
  /// **'Error loading data'**
  String get errorLoadingData;

  /// No description provided for @exitLoadRentLockInApplicable.
  ///
  /// In en, this message translates to:
  /// **'Exit Load - rent lock-in applicable'**
  String get exitLoadRentLockInApplicable;

  /// No description provided for @expiryDate.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate;

  /// No description provided for @filterCommodity.
  ///
  /// In en, this message translates to:
  /// **'Filter Commodity'**
  String get filterCommodity;

  /// No description provided for @filterTerminals.
  ///
  /// In en, this message translates to:
  /// **'Filter Terminals'**
  String get filterTerminals;

  /// No description provided for @finance.
  ///
  /// In en, this message translates to:
  /// **'Finance'**
  String get finance;

  /// No description provided for @financialSolutions.
  ///
  /// In en, this message translates to:
  /// **'Financial Solutions'**
  String get financialSolutions;

  /// No description provided for @findWarehouses.
  ///
  /// In en, this message translates to:
  /// **'Find Warehouses'**
  String get findWarehouses;

  /// No description provided for @firstKantaParchi.
  ///
  /// In en, this message translates to:
  /// **'First Kanta Parchi'**
  String get firstKantaParchi;

  /// No description provided for @firstQuality.
  ///
  /// In en, this message translates to:
  /// **'First Quality'**
  String get firstQuality;

  /// No description provided for @firstQualityReport.
  ///
  /// In en, this message translates to:
  /// **'First Quality Report'**
  String get firstQualityReport;

  /// No description provided for @gSTNumber.
  ///
  /// In en, this message translates to:
  /// **'GST Number'**
  String get gSTNumber;

  /// No description provided for @gSTProfile.
  ///
  /// In en, this message translates to:
  /// **'GST Profile'**
  String get gSTProfile;

  /// No description provided for @gatepassPending.
  ///
  /// In en, this message translates to:
  /// **'Gatepass Pending'**
  String get gatepassPending;

  /// No description provided for @gstAvailable.
  ///
  /// In en, this message translates to:
  /// **'Gst Available?'**
  String get gstAvailable;

  /// No description provided for @issueDate.
  ///
  /// In en, this message translates to:
  /// **'Issue Date'**
  String get issueDate;

  /// No description provided for @labourBook.
  ///
  /// In en, this message translates to:
  /// **'Labour Book'**
  String get labourBook;

  /// No description provided for @landAreaInAcres.
  ///
  /// In en, this message translates to:
  /// **'Land Area in Acres'**
  String get landAreaInAcres;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn More'**
  String get learnMore;

  /// No description provided for @letUsKnowYourThoughts.
  ///
  /// In en, this message translates to:
  /// **'Let us know your thoughts...'**
  String get letUsKnowYourThoughts;

  /// No description provided for @liftingDays.
  ///
  /// In en, this message translates to:
  /// **'Lifting Days'**
  String get liftingDays;

  /// No description provided for @locate.
  ///
  /// In en, this message translates to:
  /// **'Locate'**
  String get locate;

  /// No description provided for @locateOnMap.
  ///
  /// In en, this message translates to:
  /// **'Locate on Map'**
  String get locateOnMap;

  /// No description provided for @loginToAddMoney.
  ///
  /// In en, this message translates to:
  /// **'Login to add money!'**
  String get loginToAddMoney;

  /// No description provided for @loginToBookStacks.
  ///
  /// In en, this message translates to:
  /// **'Login to book stacks'**
  String get loginToBookStacks;

  /// No description provided for @stacks.
  ///
  /// In en, this message translates to:
  /// **'Stacks'**
  String get stacks;

  /// No description provided for @kisani.
  ///
  /// In en, this message translates to:
  /// **'Kisani'**
  String get kisani;

  /// No description provided for @bookingRejectedSuccessfully2.
  ///
  /// In en, this message translates to:
  /// **'Booking rejected successfully'**
  String get bookingRejectedSuccessfully2;

  /// No description provided for @loginToCheckYourStatement.
  ///
  /// In en, this message translates to:
  /// **'Login to check your statement!'**
  String get loginToCheckYourStatement;

  /// No description provided for @loginToProvideFeedback.
  ///
  /// In en, this message translates to:
  /// **'Login to provide feedback'**
  String get loginToProvideFeedback;

  /// No description provided for @loginToViewInvoices.
  ///
  /// In en, this message translates to:
  /// **'Login to view invoices!'**
  String get loginToViewInvoices;

  /// No description provided for @loginToViewSummary.
  ///
  /// In en, this message translates to:
  /// **'Login to view summary'**
  String get loginToViewSummary;

  /// No description provided for @loginToViewYourGatepasses.
  ///
  /// In en, this message translates to:
  /// **'Login to view your gatepasses'**
  String get loginToViewYourGatepasses;

  /// No description provided for @mandiTaxType.
  ///
  /// In en, this message translates to:
  /// **'Mandi Tax Type'**
  String get mandiTaxType;

  /// No description provided for @markDelivery.
  ///
  /// In en, this message translates to:
  /// **'Mark Delivery'**
  String get markDelivery;

  /// No description provided for @millCapacityPerAnnum.
  ///
  /// In en, this message translates to:
  /// **'Mill Capacity per annum'**
  String get millCapacityPerAnnum;

  /// No description provided for @mobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Mobile Number'**
  String get mobileNumber;

  /// No description provided for @myStock.
  ///
  /// In en, this message translates to:
  /// **'My Stock'**
  String get myStock;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No Data Found'**
  String get noDataFound;

  /// No description provided for @notNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get notNow;

  /// No description provided for @paymentTo.
  ///
  /// In en, this message translates to:
  /// **'Payment to'**
  String get paymentTo;

  /// No description provided for @pleaseSelectClearingAndForwardingAgent.
  ///
  /// In en, this message translates to:
  /// **'Please Select Clearing and Forwarding Agent'**
  String get pleaseSelectClearingAndForwardingAgent;

  /// No description provided for @pleaseFillAllTheFieldsProperly.
  ///
  /// In en, this message translates to:
  /// **'Please fill all the fields properly'**
  String get pleaseFillAllTheFieldsProperly;

  /// No description provided for @pleaseInputValidValue.
  ///
  /// In en, this message translates to:
  /// **'Please input valid value'**
  String get pleaseInputValidValue;

  /// No description provided for @pleaseInputYourMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Please input your mobile Number'**
  String get pleaseInputYourMobileNumber;

  /// No description provided for @pleaseSelectCommodity.
  ///
  /// In en, this message translates to:
  /// **'Please select Commodity'**
  String get pleaseSelectCommodity;

  /// No description provided for @pleaseSelectConstitution.
  ///
  /// In en, this message translates to:
  /// **'Please select Constitution'**
  String get pleaseSelectConstitution;

  /// No description provided for @pleaseSelectAPlan.
  ///
  /// In en, this message translates to:
  /// **'Please select a plan'**
  String get pleaseSelectAPlan;

  /// No description provided for @pleaseSelectAutoInvoicing.
  ///
  /// In en, this message translates to:
  /// **'Please select auto invoicing'**
  String get pleaseSelectAutoInvoicing;

  /// No description provided for @pleaseSelectLicenseType.
  ///
  /// In en, this message translates to:
  /// **'Please select license type'**
  String get pleaseSelectLicenseType;

  /// No description provided for @price_1.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price_1;

  /// No description provided for @profilePending.
  ///
  /// In en, this message translates to:
  /// **'Profile Pending!'**
  String get profilePending;

  /// No description provided for @purchaseFinance.
  ///
  /// In en, this message translates to:
  /// **'Purchase Finance'**
  String get purchaseFinance;

  /// No description provided for @purchased.
  ///
  /// In en, this message translates to:
  /// **'Purchased'**
  String get purchased;

  /// No description provided for @qtyQtl.
  ///
  /// In en, this message translates to:
  /// **'Qty(Qtl.)'**
  String get qtyQtl;

  /// No description provided for @qualityVarianceCalculator.
  ///
  /// In en, this message translates to:
  /// **'Quality Variance Calculator'**
  String get qualityVarianceCalculator;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @quantityShouldBeGreaterThan0.
  ///
  /// In en, this message translates to:
  /// **'Quantity should be greater than 0!'**
  String get quantityShouldBeGreaterThan0;

  /// No description provided for @rate_1.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate_1;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @releaseAndTransferStockEffortlessly.
  ///
  /// In en, this message translates to:
  /// **'Release and Transfer stock effortlessly'**
  String get releaseAndTransferStockEffortlessly;

  /// No description provided for @releasedWeightInQtl.
  ///
  /// In en, this message translates to:
  /// **'Released Weight(in Qtl.)'**
  String get releasedWeightInQtl;

  /// No description provided for @releasedAndFunded.
  ///
  /// In en, this message translates to:
  /// **'Released and Funded'**
  String get releasedAndFunded;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @rent.
  ///
  /// In en, this message translates to:
  /// **'Rent'**
  String get rent;

  /// No description provided for @rentAmount.
  ///
  /// In en, this message translates to:
  /// **'Rent Amount'**
  String get rentAmount;

  /// No description provided for @runningDeals.
  ///
  /// In en, this message translates to:
  /// **'Running Deals'**
  String get runningDeals;

  /// No description provided for @salesStatus.
  ///
  /// In en, this message translates to:
  /// **'Sales Status'**
  String get salesStatus;

  /// No description provided for @secondKantaParchi.
  ///
  /// In en, this message translates to:
  /// **'Second Kanta Parchi'**
  String get secondKantaParchi;

  /// No description provided for @secondQuality.
  ///
  /// In en, this message translates to:
  /// **'Second Quality'**
  String get secondQuality;

  /// No description provided for @secondQualityReport.
  ///
  /// In en, this message translates to:
  /// **'Second Quality Report'**
  String get secondQualityReport;

  /// No description provided for @selectAnnualTurnover.
  ///
  /// In en, this message translates to:
  /// **'Select Annual Turnover'**
  String get selectAnnualTurnover;

  /// No description provided for @selectAutoInvoicing.
  ///
  /// In en, this message translates to:
  /// **'Select Auto Invoicing'**
  String get selectAutoInvoicing;

  /// No description provided for @selectAvailability.
  ///
  /// In en, this message translates to:
  /// **'Select Availability'**
  String get selectAvailability;

  /// No description provided for @selectBiltyImage.
  ///
  /// In en, this message translates to:
  /// **'Select Bilty Image'**
  String get selectBiltyImage;

  /// No description provided for @selectCapacityPerAnnum.
  ///
  /// In en, this message translates to:
  /// **'Select Capacity per annum'**
  String get selectCapacityPerAnnum;

  /// No description provided for @selectClearingAndForwardingAgent.
  ///
  /// In en, this message translates to:
  /// **'Select Clearing and Forwarding Agent'**
  String get selectClearingAndForwardingAgent;

  /// No description provided for @selectCommodities.
  ///
  /// In en, this message translates to:
  /// **'Select Commodities'**
  String get selectCommodities;

  /// No description provided for @selectDestinationTerminalOrLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Destination (Terminal or Location)'**
  String get selectDestinationTerminalOrLocation;

  /// No description provided for @selectFacility.
  ///
  /// In en, this message translates to:
  /// **'Select Facility'**
  String get selectFacility;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// No description provided for @selectInvoiceImage.
  ///
  /// In en, this message translates to:
  /// **'Select Invoice Image'**
  String get selectInvoiceImage;

  /// No description provided for @selectKantaImage.
  ///
  /// In en, this message translates to:
  /// **'Select Kanta Image'**
  String get selectKantaImage;

  /// No description provided for @selectLicenseType.
  ///
  /// In en, this message translates to:
  /// **'Select License Type'**
  String get selectLicenseType;

  /// No description provided for @selectPickUpLocationTerminalOrLocation.
  ///
  /// In en, this message translates to:
  /// **'Select Pick up location (Terminal or Location)'**
  String get selectPickUpLocationTerminalOrLocation;

  /// No description provided for @selectPurchaseOrder.
  ///
  /// In en, this message translates to:
  /// **'Select Purchase Order'**
  String get selectPurchaseOrder;

  /// No description provided for @selectTransporter.
  ///
  /// In en, this message translates to:
  /// **'Select Transporter'**
  String get selectTransporter;

  /// No description provided for @selectTripId.
  ///
  /// In en, this message translates to:
  /// **'Select Trip Id'**
  String get selectTripId;

  /// No description provided for @selectTurnover.
  ///
  /// In en, this message translates to:
  /// **'Select Turnover'**
  String get selectTurnover;

  /// No description provided for @selectFromGallery.
  ///
  /// In en, this message translates to:
  /// **'Select from Gallery'**
  String get selectFromGallery;

  /// No description provided for @showDetails.
  ///
  /// In en, this message translates to:
  /// **'Show Details'**
  String get showDetails;

  /// No description provided for @showReport.
  ///
  /// In en, this message translates to:
  /// **'Show Report'**
  String get showReport;

  /// No description provided for @sold.
  ///
  /// In en, this message translates to:
  /// **'Sold'**
  String get sold;

  /// No description provided for @stockist.
  ///
  /// In en, this message translates to:
  /// **'Stockist'**
  String get stockist;

  /// No description provided for @storage.
  ///
  /// In en, this message translates to:
  /// **'Storage'**
  String get storage;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @totalPendingAmountRENTLOANINTEREST.
  ///
  /// In en, this message translates to:
  /// **'Total Pending Amount (RENT + LOAN + INTEREST)'**
  String get totalPendingAmountRENTLOANINTEREST;

  /// No description provided for @trading.
  ///
  /// In en, this message translates to:
  /// **'Trading'**
  String get trading;

  /// No description provided for @tripEnd.
  ///
  /// In en, this message translates to:
  /// **'Trip End'**
  String get tripEnd;

  /// No description provided for @turnover.
  ///
  /// In en, this message translates to:
  /// **'Turnover'**
  String get turnover;

  /// No description provided for @typeOfProcessingFacility.
  ///
  /// In en, this message translates to:
  /// **'Type Of processing facility'**
  String get typeOfProcessingFacility;

  /// No description provided for @uploadYourPassportSizedPhotos.
  ///
  /// In en, this message translates to:
  /// **'Upload your passport sized photos'**
  String get uploadYourPassportSizedPhotos;

  /// No description provided for @viewChart.
  ///
  /// In en, this message translates to:
  /// **'View Chart'**
  String get viewChart;

  /// No description provided for @walletRefund.
  ///
  /// In en, this message translates to:
  /// **'Wallet Refund'**
  String get walletRefund;

  /// No description provided for @walletTotalBalance.
  ///
  /// In en, this message translates to:
  /// **'Wallet Total Balance'**
  String get walletTotalBalance;

  /// No description provided for @weightShortageAllowance.
  ///
  /// In en, this message translates to:
  /// **'Weight Shortage Allowance'**
  String get weightShortageAllowance;

  /// No description provided for @yourProfileIsCurrentlyPendingPleaseCompleteItToStartTrading.
  ///
  /// In en, this message translates to:
  /// **'Your Profile is currently pending, please complete it to start trading'**
  String get yourProfileIsCurrentlyPendingPleaseCompleteItToStartTrading;

  /// No description provided for @yourFeedback.
  ///
  /// In en, this message translates to:
  /// **'Your feedback'**
  String get yourFeedback;

  /// No description provided for @exitLoad.
  ///
  /// In en, this message translates to:
  /// **'Exit Load'**
  String get exitLoad;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @inputLandAreaInAcres.
  ///
  /// In en, this message translates to:
  /// **'Input land area in Acres'**
  String get inputLandAreaInAcres;

  /// No description provided for @km.
  ///
  /// In en, this message translates to:
  /// **'km'**
  String get km;

  /// No description provided for @msgFacetoface.
  ///
  /// In en, this message translates to:
  /// **'Face to Face'**
  String get msgFacetoface;

  /// No description provided for @pleaseInputValidMobileNumber.
  ///
  /// In en, this message translates to:
  /// **'Please input valid mobile number'**
  String get pleaseInputValidMobileNumber;

  /// No description provided for @pleaseSelectImage.
  ///
  /// In en, this message translates to:
  /// **'Please select image'**
  String get pleaseSelectImage;

  /// No description provided for @tcw.
  ///
  /// In en, this message translates to:
  /// **'TCW'**
  String get tcw;

  /// No description provided for @youWantToCancelThisInwardRequest.
  ///
  /// In en, this message translates to:
  /// **'You want to cancel this inward request?'**
  String get youWantToCancelThisInwardRequest;

  /// No description provided for @youWantToCancelThisOutwardRequest.
  ///
  /// In en, this message translates to:
  /// **'You want to cancel this outward request?'**
  String get youWantToCancelThisOutwardRequest;

  /// No description provided for @broker.
  ///
  /// In en, this message translates to:
  /// **'Broker'**
  String get broker;

  /// No description provided for @uniqueId.
  ///
  /// In en, this message translates to:
  /// **'Unique ID'**
  String get uniqueId;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @tBeZero.
  ///
  /// In en, this message translates to:
  /// **'Can\'t be zero!'**
  String get tBeZero;

  /// No description provided for @apply_1.
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply_1;

  /// No description provided for @custom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get custom;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @dispatchRequests.
  ///
  /// In en, this message translates to:
  /// **'Dispatch Requests'**
  String get dispatchRequests;

  /// No description provided for @errorLoadingTerminals.
  ///
  /// In en, this message translates to:
  /// **'Error loading terminals'**
  String get errorLoadingTerminals;

  /// No description provided for @errorLoadingWarehouses.
  ///
  /// In en, this message translates to:
  /// **'Error loading warehouses'**
  String get errorLoadingWarehouses;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get loading;

  /// No description provided for @loading_1.
  ///
  /// In en, this message translates to:
  /// **'Loading... '**
  String get loading_1;

  /// No description provided for @myHoldWallet.
  ///
  /// In en, this message translates to:
  /// **'My Hold Wallet'**
  String get myHoldWallet;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No Data'**
  String get noData;

  /// No description provided for @selectDateRange.
  ///
  /// In en, this message translates to:
  /// **'Select Date Range'**
  String get selectDateRange;

  /// No description provided for @stackSettlement.
  ///
  /// In en, this message translates to:
  /// **'Stack Settlement'**
  String get stackSettlement;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @tenor.
  ///
  /// In en, this message translates to:
  /// **'Tenor'**
  String get tenor;

  /// No description provided for @updateTripId.
  ///
  /// In en, this message translates to:
  /// **'Update Trip Id'**
  String get updateTripId;

  /// No description provided for @warehouseBasedTrade.
  ///
  /// In en, this message translates to:
  /// **'Warehouse Based Trade'**
  String get warehouseBasedTrade;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @allNotificationsCleared.
  ///
  /// In en, this message translates to:
  /// **'All notifications cleared'**
  String get allNotificationsCleared;

  /// No description provided for @android.
  ///
  /// In en, this message translates to:
  /// **'Android:'**
  String get android;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @defaultNotificationSent.
  ///
  /// In en, this message translates to:
  /// **'Default notification sent'**
  String get defaultNotificationSent;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deliveryCentersMap.
  ///
  /// In en, this message translates to:
  /// **'Delivery Centers Map'**
  String get deliveryCentersMap;

  /// No description provided for @errorLoadingDeliveryCenters.
  ///
  /// In en, this message translates to:
  /// **'Error loading delivery centers'**
  String get errorLoadingDeliveryCenters;

  /// No description provided for @fCMTokenCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'FCM Token copied to clipboard!'**
  String get fCMTokenCopiedToClipboard;

  /// No description provided for @fCMTokenNotAvailableYetPleaseWait.
  ///
  /// In en, this message translates to:
  /// **'FCM Token not available yet. Please wait...'**
  String get fCMTokenNotAvailableYetPleaseWait;

  /// No description provided for @failedToConnect.
  ///
  /// In en, this message translates to:
  /// **'Failed to connect'**
  String get failedToConnect;

  /// No description provided for @finalSubmissionPreview.
  ///
  /// In en, this message translates to:
  /// **'Final Submission Preview'**
  String get finalSubmissionPreview;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @grnImage.
  ///
  /// In en, this message translates to:
  /// **'Grn Image'**
  String get grnImage;

  /// No description provided for @inwardDetails.
  ///
  /// In en, this message translates to:
  /// **'Inward Details'**
  String get inwardDetails;

  /// No description provided for @kantaImage.
  ///
  /// In en, this message translates to:
  /// **'Kanta Image'**
  String get kantaImage;

  /// No description provided for @labourRate.
  ///
  /// In en, this message translates to:
  /// **'Labour Rate - '**
  String get labourRate;

  /// No description provided for @outwardDetails.
  ///
  /// In en, this message translates to:
  /// **'Outward Details'**
  String get outwardDetails;

  /// No description provided for @printFailed.
  ///
  /// In en, this message translates to:
  /// **'Print failed'**
  String get printFailed;

  /// No description provided for @printJobSent.
  ///
  /// In en, this message translates to:
  /// **'Print job sent'**
  String get printJobSent;

  /// No description provided for @print.
  ///
  /// In en, this message translates to:
  /// **'Print'**
  String get print;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @selectPrinter.
  ///
  /// In en, this message translates to:
  /// **'Select Printer'**
  String get selectPrinter;

  /// No description provided for @spotDeals.
  ///
  /// In en, this message translates to:
  /// **'Spot Deals'**
  String get spotDeals;

  /// No description provided for @stackSellBidding.
  ///
  /// In en, this message translates to:
  /// **'Stack Sell Bidding'**
  String get stackSellBidding;

  /// No description provided for @submitFinal.
  ///
  /// In en, this message translates to:
  /// **'Submit Final'**
  String get submitFinal;

  /// No description provided for @count.
  ///
  /// In en, this message translates to:
  /// **'Count'**
  String get count;

  /// No description provided for @iOS.
  ///
  /// In en, this message translates to:
  /// **'iOS:'**
  String get iOS;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @yourBottomSheetContent.
  ///
  /// In en, this message translates to:
  /// **'Your Bottom Sheet Content'**
  String get yourBottomSheetContent;

  /// No description provided for @pF.
  ///
  /// In en, this message translates to:
  /// **'PF(%)'**
  String get pF;

  /// No description provided for @interestRate.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate(%)'**
  String get interestRate;

  /// No description provided for @lTV.
  ///
  /// In en, this message translates to:
  /// **'LTV(%)'**
  String get lTV;

  /// No description provided for @aadharBackImage.
  ///
  /// In en, this message translates to:
  /// **'Aadhar Back Image'**
  String get aadharBackImage;

  /// No description provided for @aadharFrontImage.
  ///
  /// In en, this message translates to:
  /// **'Aadhar Front Image'**
  String get aadharFrontImage;

  /// No description provided for @accountSettings.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings;

  /// No description provided for @accountSettings3.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettings3;

  /// No description provided for @addParameter.
  ///
  /// In en, this message translates to:
  /// **'Add Parameter'**
  String get addParameter;

  /// No description provided for @addQualityParameter.
  ///
  /// In en, this message translates to:
  /// **'Add Quality Parameter'**
  String get addQualityParameter;

  /// No description provided for @advanceAmtInr2.
  ///
  /// In en, this message translates to:
  /// **'Advance Amt Inr'**
  String get advanceAmtInr2;

  /// No description provided for @agreeContinue2.
  ///
  /// In en, this message translates to:
  /// **'Agree Continue'**
  String get agreeContinue2;

  /// No description provided for @anErrorOccurredPleaseTryAgain2.
  ///
  /// In en, this message translates to:
  /// **'An Error Occurred Please Try Again'**
  String get anErrorOccurredPleaseTryAgain2;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @approve3.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve3;

  /// No description provided for @approveQuality.
  ///
  /// In en, this message translates to:
  /// **'Approve Quality'**
  String get approveQuality;

  /// No description provided for @approvedloan.
  ///
  /// In en, this message translates to:
  /// **'Approvedloan'**
  String get approvedloan;

  /// No description provided for @areYouSure.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure'**
  String get areYouSure;

  /// No description provided for @areYouSure3.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure'**
  String get areYouSure3;

  /// No description provided for @areYouSureYouWantToDeleteThisBid2.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure You Want To Delete This Bid'**
  String get areYouSureYouWantToDeleteThisBid2;

  /// No description provided for @areYouSureYouWantToDeleteYourAccountThisCannotBeUndone2.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure You Want To Delete Your Account This Cannot Be Undone'**
  String get areYouSureYouWantToDeleteYourAccountThisCannotBeUndone2;

  /// No description provided for @areYouSureYouWantToRejectThisBooking2.
  ///
  /// In en, this message translates to:
  /// **'Are You Sure You Want To Reject This Booking'**
  String get areYouSureYouWantToRejectThisBooking2;

  /// No description provided for @areaInAcres.
  ///
  /// In en, this message translates to:
  /// **'Area In Acres'**
  String get areaInAcres;

  /// No description provided for @autoInvoice2.
  ///
  /// In en, this message translates to:
  /// **'Auto Invoice'**
  String get autoInvoice2;

  /// No description provided for @autoInvoicing2.
  ///
  /// In en, this message translates to:
  /// **'Auto Invoicing'**
  String get autoInvoicing2;

  /// No description provided for @availableQty2.
  ///
  /// In en, this message translates to:
  /// **'Available Qty'**
  String get availableQty2;

  /// No description provided for @bagsRequired.
  ///
  /// In en, this message translates to:
  /// **'Bags Required'**
  String get bagsRequired;

  /// No description provided for @bankbranch.
  ///
  /// In en, this message translates to:
  /// **'Bankbranch'**
  String get bankbranch;

  /// No description provided for @biltyImage.
  ///
  /// In en, this message translates to:
  /// **'Bilty Image'**
  String get biltyImage;

  /// No description provided for @bnpl2.
  ///
  /// In en, this message translates to:
  /// **'Bnpl '**
  String get bnpl2;

  /// No description provided for @bookingHistory2.
  ///
  /// In en, this message translates to:
  /// **'Booking History'**
  String get bookingHistory2;

  /// No description provided for @broker2.
  ///
  /// In en, this message translates to:
  /// **'Broker'**
  String get broker2;

  /// No description provided for @businessProfile.
  ///
  /// In en, this message translates to:
  /// **'Business Profile'**
  String get businessProfile;

  /// No description provided for @buySell.
  ///
  /// In en, this message translates to:
  /// **'Buy Sell'**
  String get buySell;

  /// No description provided for @buySellCommodity.
  ///
  /// In en, this message translates to:
  /// **'Buy Sell Commodity'**
  String get buySellCommodity;

  /// No description provided for @buyerAddress3.
  ///
  /// In en, this message translates to:
  /// **'Buyer Address'**
  String get buyerAddress3;

  /// No description provided for @buyerDetails.
  ///
  /// In en, this message translates to:
  /// **'Buyer Details'**
  String get buyerDetails;

  /// No description provided for @buyerGstNumber2.
  ///
  /// In en, this message translates to:
  /// **'Buyer Gst Number'**
  String get buyerGstNumber2;

  /// No description provided for @buyerName2.
  ///
  /// In en, this message translates to:
  /// **'Buyer Name'**
  String get buyerName2;

  /// No description provided for @buyerPhone3.
  ///
  /// In en, this message translates to:
  /// **'Buyer Phone'**
  String get buyerPhone3;

  /// No description provided for @buyerPhone4.
  ///
  /// In en, this message translates to:
  /// **'Buyer Phone'**
  String get buyerPhone4;

  /// No description provided for @buyingDeal.
  ///
  /// In en, this message translates to:
  /// **'Buying Deal'**
  String get buyingDeal;

  /// No description provided for @calculatePrice2.
  ///
  /// In en, this message translates to:
  /// **'Calculate Price'**
  String get calculatePrice2;

  /// No description provided for @cancel3.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel3;

  /// No description provided for @checkDealStatus.
  ///
  /// In en, this message translates to:
  /// **'Check Deal Status'**
  String get checkDealStatus;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear All'**
  String get clearAll;

  /// No description provided for @clearAllChannels.
  ///
  /// In en, this message translates to:
  /// **'Clear All Channels'**
  String get clearAllChannels;

  /// No description provided for @commodity2.
  ///
  /// In en, this message translates to:
  /// **'Commodity'**
  String get commodity2;

  /// No description provided for @commodityType.
  ///
  /// In en, this message translates to:
  /// **'Commodity Type'**
  String get commodityType;

  /// No description provided for @company.
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get company;

  /// No description provided for @computerGeneratedInvoice.
  ///
  /// In en, this message translates to:
  /// **'Computer Generated Invoice'**
  String get computerGeneratedInvoice;

  /// No description provided for @consigneeName2.
  ///
  /// In en, this message translates to:
  /// **'Consignee Name'**
  String get consigneeName2;

  /// No description provided for @consigneePhone2.
  ///
  /// In en, this message translates to:
  /// **'Consignee Phone'**
  String get consigneePhone2;

  /// No description provided for @contactEmail.
  ///
  /// In en, this message translates to:
  /// **'Contact Email'**
  String get contactEmail;

  /// No description provided for @createPurchaseOrder.
  ///
  /// In en, this message translates to:
  /// **'Create Purchase Order'**
  String get createPurchaseOrder;

  /// No description provided for @createTripId2.
  ///
  /// In en, this message translates to:
  /// **'Create Trip Id'**
  String get createTripId2;

  /// No description provided for @credit.
  ///
  /// In en, this message translates to:
  /// **'Credit'**
  String get credit;

  /// No description provided for @customDate.
  ///
  /// In en, this message translates to:
  /// **'Custom Date'**
  String get customDate;

  /// No description provided for @customDate3.
  ///
  /// In en, this message translates to:
  /// **'Custom Date'**
  String get customDate3;

  /// No description provided for @dealTypeId.
  ///
  /// In en, this message translates to:
  /// **'Deal Type Id'**
  String get dealTypeId;

  /// No description provided for @deleteAccount2.
  ///
  /// In en, this message translates to:
  /// **'Delete Account'**
  String get deleteAccount2;

  /// No description provided for @deleteBid.
  ///
  /// In en, this message translates to:
  /// **'Delete Bid'**
  String get deleteBid;

  /// No description provided for @deleteBid3.
  ///
  /// In en, this message translates to:
  /// **'Delete Bid'**
  String get deleteBid3;

  /// No description provided for @deliveredQty2.
  ///
  /// In en, this message translates to:
  /// **'Delivered Qty'**
  String get deliveredQty2;

  /// No description provided for @deliveryCenters.
  ///
  /// In en, this message translates to:
  /// **'Delivery Centers'**
  String get deliveryCenters;

  /// No description provided for @deliveryCenters3.
  ///
  /// In en, this message translates to:
  /// **'Delivery Centers'**
  String get deliveryCenters3;

  /// No description provided for @deliveryLocation.
  ///
  /// In en, this message translates to:
  /// **'Delivery Location'**
  String get deliveryLocation;

  /// No description provided for @deliveryMarkingPending.
  ///
  /// In en, this message translates to:
  /// **'Delivery Marking Pending'**
  String get deliveryMarkingPending;

  /// No description provided for @deliveryPincode3.
  ///
  /// In en, this message translates to:
  /// **'Delivery Pincode'**
  String get deliveryPincode3;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @dispatch.
  ///
  /// In en, this message translates to:
  /// **'Dispatch'**
  String get dispatch;

  /// No description provided for @dispatch3.
  ///
  /// In en, this message translates to:
  /// **'Dispatch'**
  String get dispatch3;

  /// No description provided for @dispatchLocation.
  ///
  /// In en, this message translates to:
  /// **'Dispatch Location'**
  String get dispatchLocation;

  /// No description provided for @doYouHaveGst2.
  ///
  /// In en, this message translates to:
  /// **'Do You Have Gst'**
  String get doYouHaveGst2;

  /// No description provided for @done2.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done2;

  /// No description provided for @driverMobileNo2.
  ///
  /// In en, this message translates to:
  /// **'Driver Mobile No'**
  String get driverMobileNo2;

  /// No description provided for @drop.
  ///
  /// In en, this message translates to:
  /// **'Drop'**
  String get drop;

  /// No description provided for @effectiveBalance2.
  ///
  /// In en, this message translates to:
  /// **'Effective Balance'**
  String get effectiveBalance2;

  /// No description provided for @effectivebalance.
  ///
  /// In en, this message translates to:
  /// **'Effectivebalance'**
  String get effectivebalance;

  /// No description provided for @enter2.
  ///
  /// In en, this message translates to:
  /// **'Enter'**
  String get enter2;

  /// No description provided for @enterAmount2.
  ///
  /// In en, this message translates to:
  /// **'Enter Amount'**
  String get enterAmount2;

  /// No description provided for @enterBagsCount.
  ///
  /// In en, this message translates to:
  /// **'Enter Bags Count'**
  String get enterBagsCount;

  /// No description provided for @enterBuyPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter Buy Price'**
  String get enterBuyPrice;

  /// No description provided for @enterCompanyName2.
  ///
  /// In en, this message translates to:
  /// **'Enter Company Name'**
  String get enterCompanyName2;

  /// No description provided for @enterCompanyNumber2.
  ///
  /// In en, this message translates to:
  /// **'Enter Company Number'**
  String get enterCompanyNumber2;

  /// No description provided for @enterPrice2.
  ///
  /// In en, this message translates to:
  /// **'Enter Price'**
  String get enterPrice2;

  /// No description provided for @enterPriceToFetchStackData2.
  ///
  /// In en, this message translates to:
  /// **'Enter Price To Fetch Stack Data'**
  String get enterPriceToFetchStackData2;

  /// No description provided for @enterSellPrice.
  ///
  /// In en, this message translates to:
  /// **'Enter Sell Price'**
  String get enterSellPrice;

  /// No description provided for @enterValidNumber.
  ///
  /// In en, this message translates to:
  /// **'Enter Valid Number'**
  String get enterValidNumber;

  /// No description provided for @enterValidWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter Valid Weight'**
  String get enterValidWeight;

  /// No description provided for @enterValue.
  ///
  /// In en, this message translates to:
  /// **'Enter Value'**
  String get enterValue;

  /// No description provided for @enterWeight.
  ///
  /// In en, this message translates to:
  /// **'Enter Weight'**
  String get enterWeight;

  /// No description provided for @entryLoadCharge.
  ///
  /// In en, this message translates to:
  /// **'Entry Load Charge'**
  String get entryLoadCharge;

  /// No description provided for @entryloadcharge2.
  ///
  /// In en, this message translates to:
  /// **'Entryloadcharge'**
  String get entryloadcharge2;

  /// No description provided for @error2.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error2;

  /// No description provided for @errorE2.
  ///
  /// In en, this message translates to:
  /// **'Error E'**
  String get errorE2;

  /// No description provided for @errorUpdatingPhotos.
  ///
  /// In en, this message translates to:
  /// **'Error Updating Photos'**
  String get errorUpdatingPhotos;

  /// No description provided for @exitApp.
  ///
  /// In en, this message translates to:
  /// **'Exit App'**
  String get exitApp;

  /// No description provided for @exitAppConfirm.
  ///
  /// In en, this message translates to:
  /// **'Exit App Confirm'**
  String get exitAppConfirm;

  /// No description provided for @exitLoadCharge.
  ///
  /// In en, this message translates to:
  /// **'Exit Load Charge'**
  String get exitLoadCharge;

  /// No description provided for @exitloadcharge2.
  ///
  /// In en, this message translates to:
  /// **'Exitloadcharge'**
  String get exitloadcharge2;

  /// No description provided for @expiryDate2.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDate2;

  /// No description provided for @extreme.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get extreme;

  /// No description provided for @extreme3.
  ///
  /// In en, this message translates to:
  /// **'Extreme'**
  String get extreme3;

  /// No description provided for @facilityType.
  ///
  /// In en, this message translates to:
  /// **'Facility Type'**
  String get facilityType;

  /// No description provided for @failedToDeleteAccountPleaseTryAgain2.
  ///
  /// In en, this message translates to:
  /// **'Failed To Delete Account Please Try Again'**
  String get failedToDeleteAccountPleaseTryAgain2;

  /// No description provided for @failedToPickImage.
  ///
  /// In en, this message translates to:
  /// **'Failed To Pick Image'**
  String get failedToPickImage;

  /// No description provided for @failedToUpdatePhotos.
  ///
  /// In en, this message translates to:
  /// **'Failed To Update Photos'**
  String get failedToUpdatePhotos;

  /// No description provided for @failedToUpdateQualityData.
  ///
  /// In en, this message translates to:
  /// **'Failed To Update Quality Data'**
  String get failedToUpdateQualityData;

  /// No description provided for @faq.
  ///
  /// In en, this message translates to:
  /// **'Faq'**
  String get faq;

  /// No description provided for @filter.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// No description provided for @filter3.
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter3;

  /// No description provided for @filterMyInvoices.
  ///
  /// In en, this message translates to:
  /// **'Filter My Invoices'**
  String get filterMyInvoices;

  /// No description provided for @filterReceivedInvoices.
  ///
  /// In en, this message translates to:
  /// **'Filter Received Invoices'**
  String get filterReceivedInvoices;

  /// No description provided for @financewallet.
  ///
  /// In en, this message translates to:
  /// **'Financewallet'**
  String get financewallet;

  /// No description provided for @firstKantaPending.
  ///
  /// In en, this message translates to:
  /// **'First Kanta Pending'**
  String get firstKantaPending;

  /// No description provided for @firstKantaPending3.
  ///
  /// In en, this message translates to:
  /// **'First Kanta Pending'**
  String get firstKantaPending3;

  /// No description provided for @firstQualityPending.
  ///
  /// In en, this message translates to:
  /// **'First Quality Pending'**
  String get firstQualityPending;

  /// No description provided for @firstQualityPending3.
  ///
  /// In en, this message translates to:
  /// **'First Quality Pending'**
  String get firstQualityPending3;

  /// No description provided for @from2.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get from2;

  /// No description provided for @fundedBags.
  ///
  /// In en, this message translates to:
  /// **'Funded Bags'**
  String get fundedBags;

  /// No description provided for @fundedWeightInQtl.
  ///
  /// In en, this message translates to:
  /// **'Funded Weight In Qtl'**
  String get fundedWeightInQtl;

  /// No description provided for @gatepassRecommended.
  ///
  /// In en, this message translates to:
  /// **'Gatepass Recommended'**
  String get gatepassRecommended;

  /// No description provided for @gatepassRecommended3.
  ///
  /// In en, this message translates to:
  /// **'Gatepass Recommended'**
  String get gatepassRecommended3;

  /// No description provided for @gatepassWise.
  ///
  /// In en, this message translates to:
  /// **'Gatepass Wise'**
  String get gatepassWise;

  /// No description provided for @grnNumber.
  ///
  /// In en, this message translates to:
  /// **'Grn Number'**
  String get grnNumber;

  /// No description provided for @hdfc0000054.
  ///
  /// In en, this message translates to:
  /// **'Hdfc'**
  String get hdfc0000054;

  /// No description provided for @history2.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history2;

  /// No description provided for @holdAmount.
  ///
  /// In en, this message translates to:
  /// **'Hold Amount'**
  String get holdAmount;

  /// No description provided for @holdBalance2.
  ///
  /// In en, this message translates to:
  /// **'Hold Balance'**
  String get holdBalance2;

  /// No description provided for @holdQty2.
  ///
  /// In en, this message translates to:
  /// **'Hold Qty'**
  String get holdQty2;

  /// No description provided for @holdbalance.
  ///
  /// In en, this message translates to:
  /// **'Holdbalance'**
  String get holdbalance;

  /// No description provided for @igst.
  ///
  /// In en, this message translates to:
  /// **'Igst'**
  String get igst;

  /// No description provided for @imageNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Image Not Available'**
  String get imageNotAvailable;

  /// No description provided for @inAcres.
  ///
  /// In en, this message translates to:
  /// **'In Acres'**
  String get inAcres;

  /// No description provided for @individual.
  ///
  /// In en, this message translates to:
  /// **'Individual'**
  String get individual;

  /// No description provided for @inputValidValue3.
  ///
  /// In en, this message translates to:
  /// **'Input Valid Value'**
  String get inputValidValue3;

  /// No description provided for @inputValidValue4.
  ///
  /// In en, this message translates to:
  /// **'Input Valid Value'**
  String get inputValidValue4;

  /// No description provided for @interestRate1.
  ///
  /// In en, this message translates to:
  /// **'Interest Rate'**
  String get interestRate1;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid Number'**
  String get invalidNumber;

  /// No description provided for @investmentAmount.
  ///
  /// In en, this message translates to:
  /// **'Investment Amount'**
  String get investmentAmount;

  /// No description provided for @invoicesRaisedByMe.
  ///
  /// In en, this message translates to:
  /// **'Invoices Raised By Me'**
  String get invoicesRaisedByMe;

  /// No description provided for @invoicesRaisedToMe.
  ///
  /// In en, this message translates to:
  /// **'Invoices Raised To Me'**
  String get invoicesRaisedToMe;

  /// No description provided for @inwardRequest.
  ///
  /// In en, this message translates to:
  /// **'Inward Request'**
  String get inwardRequest;

  /// No description provided for @inwards.
  ///
  /// In en, this message translates to:
  /// **'Inwards'**
  String get inwards;

  /// No description provided for @inwards3.
  ///
  /// In en, this message translates to:
  /// **'Inwards'**
  String get inwards3;

  /// No description provided for @k1Month2.
  ///
  /// In en, this message translates to:
  /// **'K1 Month'**
  String get k1Month2;

  /// No description provided for @k3Months2.
  ///
  /// In en, this message translates to:
  /// **'K3 Months'**
  String get k3Months2;

  /// No description provided for @k6Months2.
  ///
  /// In en, this message translates to:
  /// **'K6 Months'**
  String get k6Months2;

  /// No description provided for @kantaParchiPhoto.
  ///
  /// In en, this message translates to:
  /// **'Kanta Parchi Photo'**
  String get kantaParchiPhoto;

  /// No description provided for @khasraNumber.
  ///
  /// In en, this message translates to:
  /// **'Khasra Number'**
  String get khasraNumber;

  /// No description provided for @kycProfile.
  ///
  /// In en, this message translates to:
  /// **'Kyc Profile'**
  String get kycProfile;

  /// No description provided for @labourBookPending.
  ///
  /// In en, this message translates to:
  /// **'Labour Book Pending'**
  String get labourBookPending;

  /// No description provided for @labourPending2.
  ///
  /// In en, this message translates to:
  /// **'Labour Pending'**
  String get labourPending2;

  /// No description provided for @landmark2.
  ///
  /// In en, this message translates to:
  /// **'Landmark'**
  String get landmark2;

  /// No description provided for @limit2.
  ///
  /// In en, this message translates to:
  /// **'Limit'**
  String get limit2;

  /// No description provided for @limitHold.
  ///
  /// In en, this message translates to:
  /// **'Limit Hold'**
  String get limitHold;

  /// No description provided for @live.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live;

  /// No description provided for @live3.
  ///
  /// In en, this message translates to:
  /// **'Live'**
  String get live3;

  /// No description provided for @loadTruckPhoto.
  ///
  /// In en, this message translates to:
  /// **'Load Truck Photo'**
  String get loadTruckPhoto;

  /// No description provided for @loanapplied.
  ///
  /// In en, this message translates to:
  /// **'Loanapplied'**
  String get loanapplied;

  /// No description provided for @loanopencase.
  ///
  /// In en, this message translates to:
  /// **'Loanopencase'**
  String get loanopencase;

  /// No description provided for @loginToCheckStatement.
  ///
  /// In en, this message translates to:
  /// **'Login To Check Statement'**
  String get loginToCheckStatement;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Login To Continue'**
  String get loginToContinue;

  /// No description provided for @loginToContinue3.
  ///
  /// In en, this message translates to:
  /// **'Login To Continue'**
  String get loginToContinue3;

  /// No description provided for @loginToGetSummary2.
  ///
  /// In en, this message translates to:
  /// **'Login To Get Summary'**
  String get loginToGetSummary2;

  /// No description provided for @loginToViewProfile.
  ///
  /// In en, this message translates to:
  /// **'Login To View Profile'**
  String get loginToViewProfile;

  /// No description provided for @loginToViewYourGatepasses2.
  ///
  /// In en, this message translates to:
  /// **'Login To View Your Gatepasses'**
  String get loginToViewYourGatepasses2;

  /// No description provided for @loginToViewYourStacks2.
  ///
  /// In en, this message translates to:
  /// **'Login To View Your Stacks'**
  String get loginToViewYourStacks2;

  /// No description provided for @loginToViewYourStockSummary2.
  ///
  /// In en, this message translates to:
  /// **'Login To View Your Stock Summary'**
  String get loginToViewYourStockSummary2;

  /// No description provided for @loginToWithdrawMoney.
  ///
  /// In en, this message translates to:
  /// **'Login To Withdraw Money'**
  String get loginToWithdrawMoney;

  /// No description provided for @ltv1.
  ///
  /// In en, this message translates to:
  /// **'Ltv'**
  String get ltv1;

  /// No description provided for @mandi.
  ///
  /// In en, this message translates to:
  /// **'Mandi'**
  String get mandi;

  /// No description provided for @mandiTaxImage.
  ///
  /// In en, this message translates to:
  /// **'Mandi Tax Image'**
  String get mandiTaxImage;

  /// No description provided for @mandiTaxProfile.
  ///
  /// In en, this message translates to:
  /// **'Mandi Tax Profile'**
  String get mandiTaxProfile;

  /// No description provided for @matchingDeals.
  ///
  /// In en, this message translates to:
  /// **'Matching Deals'**
  String get matchingDeals;

  /// No description provided for @max.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max;

  /// No description provided for @max3.
  ///
  /// In en, this message translates to:
  /// **'Max'**
  String get max3;

  /// No description provided for @media.
  ///
  /// In en, this message translates to:
  /// **'Media'**
  String get media;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min;

  /// No description provided for @min3.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min3;

  /// No description provided for @msgApprovedamount3.
  ///
  /// In en, this message translates to:
  /// **' Approvedamount'**
  String get msgApprovedamount3;

  /// No description provided for @msgBuyerBest3.
  ///
  /// In en, this message translates to:
  /// **' Buyer Best'**
  String get msgBuyerBest3;

  /// No description provided for @msgCencel3.
  ///
  /// In en, this message translates to:
  /// **' Cencel'**
  String get msgCencel3;

  /// No description provided for @msgCommodityy3.
  ///
  /// In en, this message translates to:
  /// **' Commodityy'**
  String get msgCommodityy3;

  /// No description provided for @msgDisbursement3.
  ///
  /// In en, this message translates to:
  /// **' Disbursement'**
  String get msgDisbursement3;

  /// No description provided for @msgFcmToken.
  ///
  /// In en, this message translates to:
  /// **' Fcm Token'**
  String get msgFcmToken;

  /// No description provided for @msgGeneratorname2.
  ///
  /// In en, this message translates to:
  /// **' Generatorname'**
  String get msgGeneratorname2;

  /// No description provided for @msgGetFcmTokenForFirebaseConsole.
  ///
  /// In en, this message translates to:
  /// **' Get Fcm Token For Firebase Console'**
  String get msgGetFcmTokenForFirebaseConsole;

  /// No description provided for @msgGuaranteecommiss2.
  ///
  /// In en, this message translates to:
  /// **' Guaranteecommiss'**
  String get msgGuaranteecommiss2;

  /// No description provided for @msgInterestrate3.
  ///
  /// In en, this message translates to:
  /// **' Interestrate'**
  String get msgInterestrate3;

  /// No description provided for @msgInvoices.
  ///
  /// In en, this message translates to:
  /// **' Invoices'**
  String get msgInvoices;

  /// No description provided for @msgLoanpertotal3.
  ///
  /// In en, this message translates to:
  /// **' Loanpertotal'**
  String get msgLoanpertotal3;

  /// No description provided for @msginfo.
  ///
  /// In en, this message translates to:
  /// **' info'**
  String get msginfo;

  /// No description provided for @msgMybid3.
  ///
  /// In en, this message translates to:
  /// **' Mybid'**
  String get msgMybid3;

  /// No description provided for @msgNarration.
  ///
  /// In en, this message translates to:
  /// **' Narration'**
  String get msgNarration;

  /// No description provided for @msgOnlineMandi.
  ///
  /// In en, this message translates to:
  /// **' Online Mandi'**
  String get msgOnlineMandi;

  /// No description provided for @msgProcessing3.
  ///
  /// In en, this message translates to:
  /// **' Processing'**
  String get msgProcessing3;

  /// No description provided for @msgRequestamount3.
  ///
  /// In en, this message translates to:
  /// **' Requestamount'**
  String get msgRequestamount3;

  /// No description provided for @msgSanctioned3.
  ///
  /// In en, this message translates to:
  /// **' Sanctioned'**
  String get msgSanctioned3;

  /// No description provided for @msgSellerBest3.
  ///
  /// In en, this message translates to:
  /// **' Seller Best'**
  String get msgSellerBest3;

  /// No description provided for @msgStack3.
  ///
  /// In en, this message translates to:
  /// **' Stack'**
  String get msgStack3;

  /// No description provided for @msgStackboking2.
  ///
  /// In en, this message translates to:
  /// **' Stackboking'**
  String get msgStackboking2;

  /// No description provided for @msgStackinward.
  ///
  /// In en, this message translates to:
  /// **' Stackinward'**
  String get msgStackinward;

  /// No description provided for @msgStackinward3.
  ///
  /// In en, this message translates to:
  /// **' Stackinward'**
  String get msgStackinward3;

  /// No description provided for @msgStackno3.
  ///
  /// In en, this message translates to:
  /// **' Stackno'**
  String get msgStackno3;

  /// No description provided for @msgStackoutward2.
  ///
  /// In en, this message translates to:
  /// **' Stackoutward'**
  String get msgStackoutward2;

  /// No description provided for @msgStatusApproved3.
  ///
  /// In en, this message translates to:
  /// **' Status Approved'**
  String get msgStatusApproved3;

  /// No description provided for @msgStatusRejected3.
  ///
  /// In en, this message translates to:
  /// **' Status Rejected'**
  String get msgStatusRejected3;

  /// No description provided for @msgStatusRunning3.
  ///
  /// In en, this message translates to:
  /// **' Status Running'**
  String get msgStatusRunning3;

  /// No description provided for @msgStatusVerified3.
  ///
  /// In en, this message translates to:
  /// **' Status Verified'**
  String get msgStatusVerified3;

  /// No description provided for @msgSubmit3.
  ///
  /// In en, this message translates to:
  /// **' Submit'**
  String get msgSubmit3;

  /// No description provided for @msgTrade.
  ///
  /// In en, this message translates to:
  /// **' Trade'**
  String get msgTrade;

  /// No description provided for @msgUpdate2.
  ///
  /// In en, this message translates to:
  /// **' Update'**
  String get msgUpdate2;

  /// No description provided for @msgUpdateprice2.
  ///
  /// In en, this message translates to:
  /// **' Updateprice'**
  String get msgUpdateprice2;

  /// No description provided for @msgViewgraph3.
  ///
  /// In en, this message translates to:
  /// **' Viewgraph'**
  String get msgViewgraph3;

  /// No description provided for @mstOutstandingamount3.
  ///
  /// In en, this message translates to:
  /// **'Mst Outstandingamount'**
  String get mstOutstandingamount3;

  /// No description provided for @myBusinessProfile.
  ///
  /// In en, this message translates to:
  /// **'My Business Profile'**
  String get myBusinessProfile;

  /// No description provided for @myGstProfiles2.
  ///
  /// In en, this message translates to:
  /// **'My Gst Profiles'**
  String get myGstProfiles2;

  /// No description provided for @myMandiTaxProfiles.
  ///
  /// In en, this message translates to:
  /// **'My Mandi Tax Profiles'**
  String get myMandiTaxProfiles;

  /// No description provided for @mySbtOrders.
  ///
  /// In en, this message translates to:
  /// **'My Sbt Orders'**
  String get mySbtOrders;

  /// No description provided for @name3.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name3;

  /// No description provided for @narration.
  ///
  /// In en, this message translates to:
  /// **'Narration'**
  String get narration;

  /// No description provided for @noBookingHistoryAvailable2.
  ///
  /// In en, this message translates to:
  /// **'No Booking History Available'**
  String get noBookingHistoryAvailable2;

  /// No description provided for @noImageSelected.
  ///
  /// In en, this message translates to:
  /// **'No Image Selected'**
  String get noImageSelected;

  /// No description provided for @noInvoicesFound.
  ///
  /// In en, this message translates to:
  /// **'No Invoices Found'**
  String get noInvoicesFound;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @normal3.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal3;

  /// No description provided for @nowarehousesfound.
  ///
  /// In en, this message translates to:
  /// **'Nowarehousesfound'**
  String get nowarehousesfound;

  /// No description provided for @numberOfBags.
  ///
  /// In en, this message translates to:
  /// **'Number Of Bags'**
  String get numberOfBags;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'Ok'**
  String get ok;

  /// No description provided for @oneMonth.
  ///
  /// In en, this message translates to:
  /// **'One Month'**
  String get oneMonth;

  /// No description provided for @orderInventories.
  ///
  /// In en, this message translates to:
  /// **'Order Inventories'**
  String get orderInventories;

  /// No description provided for @otherTrades.
  ///
  /// In en, this message translates to:
  /// **'Other Trades'**
  String get otherTrades;

  /// No description provided for @outsideWarehouse.
  ///
  /// In en, this message translates to:
  /// **'Outside Warehouse'**
  String get outsideWarehouse;

  /// No description provided for @outwardRequest.
  ///
  /// In en, this message translates to:
  /// **'Outward Request'**
  String get outwardRequest;

  /// No description provided for @outwardRequest3.
  ///
  /// In en, this message translates to:
  /// **'Outward Request'**
  String get outwardRequest3;

  /// No description provided for @outwards.
  ///
  /// In en, this message translates to:
  /// **'Outwards'**
  String get outwards;

  /// No description provided for @outwards3.
  ///
  /// In en, this message translates to:
  /// **'Outwards'**
  String get outwards3;

  /// No description provided for @outwardsList2.
  ///
  /// In en, this message translates to:
  /// **'Outwards List'**
  String get outwardsList2;

  /// No description provided for @paramarters2.
  ///
  /// In en, this message translates to:
  /// **'Paramarters'**
  String get paramarters2;

  /// No description provided for @parameter.
  ///
  /// In en, this message translates to:
  /// **'Parameter'**
  String get parameter;

  /// No description provided for @parameterExample.
  ///
  /// In en, this message translates to:
  /// **'Parameter Example'**
  String get parameterExample;

  /// No description provided for @parameterName.
  ///
  /// In en, this message translates to:
  /// **'Parameter Name'**
  String get parameterName;

  /// No description provided for @parameterNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Parameter Name Required'**
  String get parameterNameRequired;

  /// No description provided for @partnership.
  ///
  /// In en, this message translates to:
  /// **'Partnership'**
  String get partnership;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @payment3.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment3;

  /// No description provided for @pendingQuantity3.
  ///
  /// In en, this message translates to:
  /// **'Pending Quantity'**
  String get pendingQuantity3;

  /// No description provided for @perQtl.
  ///
  /// In en, this message translates to:
  /// **'Per Qtl'**
  String get perQtl;

  /// No description provided for @pf1.
  ///
  /// In en, this message translates to:
  /// **'Pf'**
  String get pf1;

  /// No description provided for @photosUpdatedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Photos Updated Successfully'**
  String get photosUpdatedSuccessfully;

  /// No description provided for @pickImage2.
  ///
  /// In en, this message translates to:
  /// **'Pick Image'**
  String get pickImage2;

  /// No description provided for @pickUp.
  ///
  /// In en, this message translates to:
  /// **'Pick Up'**
  String get pickUp;

  /// No description provided for @pincode2.
  ///
  /// In en, this message translates to:
  /// **'Pincode'**
  String get pincode2;

  /// No description provided for @pleaseInputValidAddress2.
  ///
  /// In en, this message translates to:
  /// **'Please Input Valid Address'**
  String get pleaseInputValidAddress2;

  /// No description provided for @pleaseInputValidGst2.
  ///
  /// In en, this message translates to:
  /// **'Please Input Valid Gst'**
  String get pleaseInputValidGst2;

  /// No description provided for @pleaseProvideRatingAndFeedback2.
  ///
  /// In en, this message translates to:
  /// **'Please Provide Rating And Feedback'**
  String get pleaseProvideRatingAndFeedback2;

  /// No description provided for @pleaseRateYourExperienceWithApnaGodam2.
  ///
  /// In en, this message translates to:
  /// **'Please Rate Your Experience With Apna Godam'**
  String get pleaseRateYourExperienceWithApnaGodam2;

  /// No description provided for @pleaseSelectAState2.
  ///
  /// In en, this message translates to:
  /// **'Please Select Astate'**
  String get pleaseSelectAState2;

  /// No description provided for @pleaseSelectAllAboveConditions2.
  ///
  /// In en, this message translates to:
  /// **'Please Select All Above Conditions'**
  String get pleaseSelectAllAboveConditions2;

  /// No description provided for @pleaseSelectAtleastOneOrderToMarkDelivery.
  ///
  /// In en, this message translates to:
  /// **'Please Select Atleast One Order To Mark Delivery'**
  String get pleaseSelectAtleastOneOrderToMarkDelivery;

  /// No description provided for @pleaseSelectAtleastOnePhoto.
  ///
  /// In en, this message translates to:
  /// **'Please Select Atleast One Photo'**
  String get pleaseSelectAtleastOnePhoto;

  /// No description provided for @pleaseSelectAutoInvoice2.
  ///
  /// In en, this message translates to:
  /// **'Please Select Auto Invoice'**
  String get pleaseSelectAutoInvoice2;

  /// No description provided for @pleaseSelectBroker2.
  ///
  /// In en, this message translates to:
  /// **'Please Select Broker'**
  String get pleaseSelectBroker2;

  /// No description provided for @pleaseSelectBuyer2.
  ///
  /// In en, this message translates to:
  /// **'Please Select Buyer'**
  String get pleaseSelectBuyer2;

  /// No description provided for @pleaseSelectDistrict.
  ///
  /// In en, this message translates to:
  /// **'Please Select District'**
  String get pleaseSelectDistrict;

  /// No description provided for @pleaseSelectDistrict3.
  ///
  /// In en, this message translates to:
  /// **'Please Select District'**
  String get pleaseSelectDistrict3;

  /// No description provided for @pleaseSelectFromLocation2.
  ///
  /// In en, this message translates to:
  /// **'Please Select From Location'**
  String get pleaseSelectFromLocation2;

  /// No description provided for @pleaseSelectPaymentType2.
  ///
  /// In en, this message translates to:
  /// **'Please Select Payment Type'**
  String get pleaseSelectPaymentType2;

  /// No description provided for @pleaseSelectScheme.
  ///
  /// In en, this message translates to:
  /// **'Please Select Scheme'**
  String get pleaseSelectScheme;

  /// No description provided for @pleaseSelectState.
  ///
  /// In en, this message translates to:
  /// **'Please Select State'**
  String get pleaseSelectState;

  /// No description provided for @pleaseSelectState3.
  ///
  /// In en, this message translates to:
  /// **'Please Select State'**
  String get pleaseSelectState3;

  /// No description provided for @pleaseSelectToLocation2.
  ///
  /// In en, this message translates to:
  /// **'Please Select To Location'**
  String get pleaseSelectToLocation2;

  /// No description provided for @pleaseSelectTransporter2.
  ///
  /// In en, this message translates to:
  /// **'Please Select Transporter'**
  String get pleaseSelectTransporter2;

  /// No description provided for @pleaseSelectTripId.
  ///
  /// In en, this message translates to:
  /// **'Please Select Trip Id'**
  String get pleaseSelectTripId;

  /// No description provided for @pleaseSelectTripId3.
  ///
  /// In en, this message translates to:
  /// **'Please Select Trip Id'**
  String get pleaseSelectTripId3;

  /// No description provided for @pngJpgJpeg2.
  ///
  /// In en, this message translates to:
  /// **'Png Jpg Jpeg'**
  String get pngJpgJpeg2;

  /// No description provided for @poImage2.
  ///
  /// In en, this message translates to:
  /// **'Po Image'**
  String get poImage2;

  /// No description provided for @poNo2.
  ///
  /// In en, this message translates to:
  /// **'Po No'**
  String get poNo2;

  /// No description provided for @poNumber2.
  ///
  /// In en, this message translates to:
  /// **'Po Number'**
  String get poNumber2;

  /// No description provided for @product.
  ///
  /// In en, this message translates to:
  /// **'Product'**
  String get product;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @profileUnderVerification.
  ///
  /// In en, this message translates to:
  /// **'Profile Under Verification'**
  String get profileUnderVerification;

  /// No description provided for @profiling.
  ///
  /// In en, this message translates to:
  /// **'Profiling'**
  String get profiling;

  /// No description provided for @proprietor.
  ///
  /// In en, this message translates to:
  /// **'Proprietor'**
  String get proprietor;

  /// No description provided for @purchaseOrder2.
  ///
  /// In en, this message translates to:
  /// **'Purchase Order'**
  String get purchaseOrder2;

  /// No description provided for @purchaseOrderTechniqueSystem.
  ///
  /// In en, this message translates to:
  /// **'Purchase Order'**
  String get purchaseOrderTechniqueSystem;

  /// No description provided for @qualityClaimPerQtl.
  ///
  /// In en, this message translates to:
  /// **'Quality Claim Per Qtl'**
  String get qualityClaimPerQtl;

  /// No description provided for @qualityCondition3.
  ///
  /// In en, this message translates to:
  /// **'Quality Condition'**
  String get qualityCondition3;

  /// No description provided for @qualityConsent.
  ///
  /// In en, this message translates to:
  /// **'Quality Consent'**
  String get qualityConsent;

  /// No description provided for @qualityConsent3.
  ///
  /// In en, this message translates to:
  /// **'Quality Consent'**
  String get qualityConsent3;

  /// No description provided for @qualityDataUpdated.
  ///
  /// In en, this message translates to:
  /// **'Quality Data Updated'**
  String get qualityDataUpdated;

  /// No description provided for @qualityParameterAdded.
  ///
  /// In en, this message translates to:
  /// **'Quality Parameter Added'**
  String get qualityParameterAdded;

  /// No description provided for @qualityParameters.
  ///
  /// In en, this message translates to:
  /// **'Quality Parameters'**
  String get qualityParameters;

  /// No description provided for @qualityPhoto.
  ///
  /// In en, this message translates to:
  /// **'Quality Photo'**
  String get qualityPhoto;

  /// No description provided for @quantity3.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity3;

  /// No description provided for @quantityLabel.
  ///
  /// In en, this message translates to:
  /// **'Quantity Label'**
  String get quantityLabel;

  /// No description provided for @quantityType.
  ///
  /// In en, this message translates to:
  /// **'Quantity Type'**
  String get quantityType;

  /// No description provided for @rate3.
  ///
  /// In en, this message translates to:
  /// **'Rate'**
  String get rate3;

  /// No description provided for @ratePerQtl3.
  ///
  /// In en, this message translates to:
  /// **'Rate Per Qtl'**
  String get ratePerQtl3;

  /// No description provided for @ratePerQtl4.
  ///
  /// In en, this message translates to:
  /// **'Rate Per Qtl'**
  String get ratePerQtl4;

  /// No description provided for @reapply.
  ///
  /// In en, this message translates to:
  /// **'Reapply'**
  String get reapply;

  /// No description provided for @referenceNo.
  ///
  /// In en, this message translates to:
  /// **'Reference No'**
  String get referenceNo;

  /// No description provided for @regOffice.
  ///
  /// In en, this message translates to:
  /// **'Reg Office'**
  String get regOffice;

  /// No description provided for @releasedBags.
  ///
  /// In en, this message translates to:
  /// **'Released Bags'**
  String get releasedBags;

  /// No description provided for @releasedBags3.
  ///
  /// In en, this message translates to:
  /// **'Released Bags'**
  String get releasedBags3;

  /// No description provided for @releasedWeight2.
  ///
  /// In en, this message translates to:
  /// **'Released Weight'**
  String get releasedWeight2;

  /// No description provided for @remark3.
  ///
  /// In en, this message translates to:
  /// **'Remark'**
  String get remark3;

  /// No description provided for @remark4.
  ///
  /// In en, this message translates to:
  /// **'Remark'**
  String get remark4;

  /// No description provided for @removeYourAccountPermanently2.
  ///
  /// In en, this message translates to:
  /// **'Remove Your Account Permanently'**
  String get removeYourAccountPermanently2;

  /// No description provided for @rentAmount2.
  ///
  /// In en, this message translates to:
  /// **'Rent Amount'**
  String get rentAmount2;

  /// No description provided for @request2.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request2;

  /// No description provided for @requestDate.
  ///
  /// In en, this message translates to:
  /// **'Request Date'**
  String get requestDate;

  /// No description provided for @sNo2.
  ///
  /// In en, this message translates to:
  /// **'S No'**
  String get sNo2;

  /// No description provided for @salesType.
  ///
  /// In en, this message translates to:
  /// **'Sales Type'**
  String get salesType;

  /// No description provided for @santionLimitSchemes2.
  ///
  /// In en, this message translates to:
  /// **'Santion Limit Schemes'**
  String get santionLimitSchemes2;

  /// No description provided for @schemeName.
  ///
  /// In en, this message translates to:
  /// **'Scheme Name'**
  String get schemeName;

  /// No description provided for @schemeName3.
  ///
  /// In en, this message translates to:
  /// **'Scheme Name'**
  String get schemeName3;

  /// No description provided for @searchCommodity2.
  ///
  /// In en, this message translates to:
  /// **'Search Commodity'**
  String get searchCommodity2;

  /// No description provided for @searchTerminal2.
  ///
  /// In en, this message translates to:
  /// **'Search Terminal'**
  String get searchTerminal2;

  /// No description provided for @secondKantaParchiPending.
  ///
  /// In en, this message translates to:
  /// **'Second Kanta Parchi Pending'**
  String get secondKantaParchiPending;

  /// No description provided for @secondKantaParchiPending3.
  ///
  /// In en, this message translates to:
  /// **'Second Kanta Parchi Pending'**
  String get secondKantaParchiPending3;

  /// No description provided for @secondQualityReportPending.
  ///
  /// In en, this message translates to:
  /// **'Second Quality Report Pending'**
  String get secondQualityReportPending;

  /// No description provided for @secondQualityReportPending3.
  ///
  /// In en, this message translates to:
  /// **'Second Quality Report Pending'**
  String get secondQualityReportPending3;

  /// No description provided for @selectAmount.
  ///
  /// In en, this message translates to:
  /// **'Select Amount'**
  String get selectAmount;

  /// No description provided for @selectBroker2.
  ///
  /// In en, this message translates to:
  /// **'Select Broker'**
  String get selectBroker2;

  /// No description provided for @selectBusinessType.
  ///
  /// In en, this message translates to:
  /// **'Select Business Type'**
  String get selectBusinessType;

  /// No description provided for @selectBuyer2.
  ///
  /// In en, this message translates to:
  /// **'Select Buyer'**
  String get selectBuyer2;

  /// No description provided for @selectCommodityTaxType.
  ///
  /// In en, this message translates to:
  /// **'Select Commodity Tax Type'**
  String get selectCommodityTaxType;

  /// No description provided for @selectCommodityTaxType3.
  ///
  /// In en, this message translates to:
  /// **'Select Commodity Tax Type'**
  String get selectCommodityTaxType3;

  /// No description provided for @selectConstitution.
  ///
  /// In en, this message translates to:
  /// **'Select Constitution'**
  String get selectConstitution;

  /// No description provided for @selectConstitution3.
  ///
  /// In en, this message translates to:
  /// **'Select Constitution'**
  String get selectConstitution3;

  /// No description provided for @selectDate2.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate2;

  /// No description provided for @selectDateOfPurchaseOrder2.
  ///
  /// In en, this message translates to:
  /// **'Select Date Of Purchase Order'**
  String get selectDateOfPurchaseOrder2;

  /// No description provided for @selectDistrict.
  ///
  /// In en, this message translates to:
  /// **'Select District'**
  String get selectDistrict;

  /// No description provided for @selectDistrict3.
  ///
  /// In en, this message translates to:
  /// **'Select District'**
  String get selectDistrict3;

  /// No description provided for @selectExpiryDateOfPurchaseOrder2.
  ///
  /// In en, this message translates to:
  /// **'Select Expiry Date Of Purchase Order'**
  String get selectExpiryDateOfPurchaseOrder2;

  /// No description provided for @selectFinanceType.
  ///
  /// In en, this message translates to:
  /// **'Select Finance Type'**
  String get selectFinanceType;

  /// No description provided for @selectFinanceType3.
  ///
  /// In en, this message translates to:
  /// **'Select Finance Type'**
  String get selectFinanceType3;

  /// No description provided for @selectImageBeforeSubmit.
  ///
  /// In en, this message translates to:
  /// **'Select Image Before Submit'**
  String get selectImageBeforeSubmit;

  /// No description provided for @selectImageBeforeSubmit3.
  ///
  /// In en, this message translates to:
  /// **'Select Image Before Submit'**
  String get selectImageBeforeSubmit3;

  /// No description provided for @selectImageSource.
  ///
  /// In en, this message translates to:
  /// **'Select Image Source'**
  String get selectImageSource;

  /// No description provided for @selectLicenseImage.
  ///
  /// In en, this message translates to:
  /// **'Select License Image'**
  String get selectLicenseImage;

  /// No description provided for @selectPurchaseOrder3.
  ///
  /// In en, this message translates to:
  /// **'Select Purchase Order'**
  String get selectPurchaseOrder3;

  /// No description provided for @selectSource2.
  ///
  /// In en, this message translates to:
  /// **'Select Source'**
  String get selectSource2;

  /// No description provided for @selectState.
  ///
  /// In en, this message translates to:
  /// **'Select State'**
  String get selectState;

  /// No description provided for @selectState3.
  ///
  /// In en, this message translates to:
  /// **'Select State'**
  String get selectState3;

  /// No description provided for @selectTo2.
  ///
  /// In en, this message translates to:
  /// **'Select To'**
  String get selectTo2;

  /// No description provided for @selectYourStack2.
  ///
  /// In en, this message translates to:
  /// **'Select Your Stack'**
  String get selectYourStack2;

  /// No description provided for @selectpickupTerminalOrLocation.
  ///
  /// In en, this message translates to:
  /// **'Selectpickup Terminal Or Location'**
  String get selectpickupTerminalOrLocation;

  /// No description provided for @sellerDetails.
  ///
  /// In en, this message translates to:
  /// **'Seller Details'**
  String get sellerDetails;

  /// No description provided for @sellingDeal.
  ///
  /// In en, this message translates to:
  /// **'Selling Deal'**
  String get sellingDeal;

  /// No description provided for @settlementAmounttttt2.
  ///
  /// In en, this message translates to:
  /// **'Settlement Amounttttt'**
  String get settlementAmounttttt2;

  /// No description provided for @sixMonths.
  ///
  /// In en, this message translates to:
  /// **'Six Months'**
  String get sixMonths;

  /// No description provided for @stackNo3.
  ///
  /// In en, this message translates to:
  /// **'Stack No'**
  String get stackNo3;

  /// No description provided for @stackNo4.
  ///
  /// In en, this message translates to:
  /// **'Stack No'**
  String get stackNo4;

  /// No description provided for @stackWise.
  ///
  /// In en, this message translates to:
  /// **'Stack Wise'**
  String get stackWise;

  /// No description provided for @submitFeedback2.
  ///
  /// In en, this message translates to:
  /// **'Submit Feedback'**
  String get submitFeedback2;

  /// No description provided for @submitQualityData.
  ///
  /// In en, this message translates to:
  /// **'Submit Quality Data'**
  String get submitQualityData;

  /// No description provided for @submitted2.
  ///
  /// In en, this message translates to:
  /// **'Submitted'**
  String get submitted2;

  /// No description provided for @success3.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success3;

  /// No description provided for @success4.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success4;

  /// No description provided for @takePicture2.
  ///
  /// In en, this message translates to:
  /// **'Take Picture'**
  String get takePicture2;

  /// No description provided for @tapForDetails.
  ///
  /// In en, this message translates to:
  /// **'Tap For Details'**
  String get tapForDetails;

  /// No description provided for @tapForDetails3.
  ///
  /// In en, this message translates to:
  /// **'Tap For Details'**
  String get tapForDetails3;

  /// No description provided for @tapToPlay.
  ///
  /// In en, this message translates to:
  /// **'Tap To Play'**
  String get tapToPlay;

  /// No description provided for @tapToUploadTitleImage2.
  ///
  /// In en, this message translates to:
  /// **'Tap To Upload Title Image'**
  String get tapToUploadTitleImage2;

  /// No description provided for @taxInvoice.
  ///
  /// In en, this message translates to:
  /// **'Tax Invoice'**
  String get taxInvoice;

  /// No description provided for @taxPaid2.
  ///
  /// In en, this message translates to:
  /// **'Tax Paid'**
  String get taxPaid2;

  /// No description provided for @taxRate.
  ///
  /// In en, this message translates to:
  /// **'Tax Rate'**
  String get taxRate;

  /// No description provided for @tehsilName.
  ///
  /// In en, this message translates to:
  /// **'Tehsil Name'**
  String get tehsilName;

  /// No description provided for @terminal5.
  ///
  /// In en, this message translates to:
  /// **'Terminal'**
  String get terminal5;

  /// No description provided for @termsConditions2.
  ///
  /// In en, this message translates to:
  /// **'Terms Conditions'**
  String get termsConditions2;

  /// No description provided for @testIplSound.
  ///
  /// In en, this message translates to:
  /// **'Test Ipl Sound'**
  String get testIplSound;

  /// No description provided for @thankYouForYourFeedback2.
  ///
  /// In en, this message translates to:
  /// **'Thank You For Your Feedback'**
  String get thankYouForYourFeedback2;

  /// No description provided for @threeMonths.
  ///
  /// In en, this message translates to:
  /// **'Three Months'**
  String get threeMonths;

  /// No description provided for @to2.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get to2;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @totalAmount3.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount3;

  /// No description provided for @totalBags.
  ///
  /// In en, this message translates to:
  /// **'Total Bags'**
  String get totalBags;

  /// No description provided for @totalSettlement.
  ///
  /// In en, this message translates to:
  /// **'Total Settlement'**
  String get totalSettlement;

  /// No description provided for @tradewallet.
  ///
  /// In en, this message translates to:
  /// **'Tradewallet'**
  String get tradewallet;

  /// No description provided for @tripComplete2.
  ///
  /// In en, this message translates to:
  /// **'Trip Complete'**
  String get tripComplete2;

  /// No description provided for @tripStartPending2.
  ///
  /// In en, this message translates to:
  /// **'Trip Start Pending'**
  String get tripStartPending2;

  /// No description provided for @truckBook2.
  ///
  /// In en, this message translates to:
  /// **'Truck Book'**
  String get truckBook2;

  /// No description provided for @truckDriver2.
  ///
  /// In en, this message translates to:
  /// **'Truck Driver'**
  String get truckDriver2;

  /// No description provided for @truckDriverPhoto.
  ///
  /// In en, this message translates to:
  /// **'Truck Driver Photo'**
  String get truckDriverPhoto;

  /// No description provided for @typeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type Label'**
  String get typeLabel;

  /// No description provided for @typeOfBusiness.
  ///
  /// In en, this message translates to:
  /// **'Type Of Business'**
  String get typeOfBusiness;

  /// No description provided for @uniqueTradeId.
  ///
  /// In en, this message translates to:
  /// **'Unique Trade Id'**
  String get uniqueTradeId;

  /// No description provided for @update2.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update2;

  /// No description provided for @updateDispatchPhotos.
  ///
  /// In en, this message translates to:
  /// **'Update Dispatch Photos'**
  String get updateDispatchPhotos;

  /// No description provided for @updatePhotos.
  ///
  /// In en, this message translates to:
  /// **'Update Photos'**
  String get updatePhotos;

  /// No description provided for @uploadAadharBack.
  ///
  /// In en, this message translates to:
  /// **'Upload Aadhar Back'**
  String get uploadAadharBack;

  /// No description provided for @uploadAadharFront.
  ///
  /// In en, this message translates to:
  /// **'Upload Aadhar Front'**
  String get uploadAadharFront;

  /// No description provided for @uploadBankPassbook.
  ///
  /// In en, this message translates to:
  /// **'Upload Bank Passbook'**
  String get uploadBankPassbook;

  /// No description provided for @uploadDocumentImage.
  ///
  /// In en, this message translates to:
  /// **'Upload Document Image'**
  String get uploadDocumentImage;

  /// No description provided for @uploadPanCardPhoto.
  ///
  /// In en, this message translates to:
  /// **'Upload Pan Card Photo'**
  String get uploadPanCardPhoto;

  /// No description provided for @uploadingPhotos.
  ///
  /// In en, this message translates to:
  /// **'Uploading Photos'**
  String get uploadingPhotos;

  /// No description provided for @validationOutwordStack2.
  ///
  /// In en, this message translates to:
  /// **'Validation Outword Stack'**
  String get validationOutwordStack2;

  /// No description provided for @verify2.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verify2;

  /// No description provided for @verify.
  ///
  /// In en, this message translates to:
  /// **'Verify '**
  String get verify;

  /// No description provided for @video.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get video;

  /// No description provided for @walletBalance.
  ///
  /// In en, this message translates to:
  /// **'Wallet Balance'**
  String get walletBalance;

  /// No description provided for @walletHold.
  ///
  /// In en, this message translates to:
  /// **'Wallet Hold'**
  String get walletHold;

  /// No description provided for @wantToSell2.
  ///
  /// In en, this message translates to:
  /// **'Want To Sell'**
  String get wantToSell2;

  /// No description provided for @warehouseAddress.
  ///
  /// In en, this message translates to:
  /// **'Warehouse Address'**
  String get warehouseAddress;

  /// No description provided for @warehouseBookings2.
  ///
  /// In en, this message translates to:
  /// **'Warehouse Bookings'**
  String get warehouseBookings2;

  /// No description provided for @warehousewallet.
  ///
  /// In en, this message translates to:
  /// **'Warehousewallet'**
  String get warehousewallet;

  /// No description provided for @warehousingSolutions.
  ///
  /// In en, this message translates to:
  /// **'Warehousing Solutions'**
  String get warehousingSolutions;

  /// No description provided for @weightInQuintals.
  ///
  /// In en, this message translates to:
  /// **'Weight In Quintals'**
  String get weightInQuintals;

  /// No description provided for @weightRequired.
  ///
  /// In en, this message translates to:
  /// **'Weight Required'**
  String get weightRequired;

  /// No description provided for @youDontHaveSufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'You Dont Have Sufficient Balance'**
  String get youDontHaveSufficientBalance;

  /// No description provided for @yourAccountHasBeenDeleted2.
  ///
  /// In en, this message translates to:
  /// **'Your Account Has Been Deleted'**
  String get yourAccountHasBeenDeleted2;

  /// No description provided for @agCommission.
  ///
  /// In en, this message translates to:
  /// **'Ag Commission'**
  String get agCommission;

  /// No description provided for @capturePoImage.
  ///
  /// In en, this message translates to:
  /// **'Capture PO Image'**
  String get capturePoImage;

  /// No description provided for @cctvPending.
  ///
  /// In en, this message translates to:
  /// **'CCTV Pending'**
  String get cctvPending;

  /// No description provided for @cctvReport.
  ///
  /// In en, this message translates to:
  /// **'CCTV Report'**
  String get cctvReport;

  /// No description provided for @fcmTokenNotAvailableYetPleaseWait.
  ///
  /// In en, this message translates to:
  /// **'FCM token not available yet, please wait'**
  String get fcmTokenNotAvailableYetPleaseWait;

  /// No description provided for @gstNumber.
  ///
  /// In en, this message translates to:
  /// **'GST Number'**
  String get gstNumber;

  /// No description provided for @gstProfile.
  ///
  /// In en, this message translates to:
  /// **'GST Profile'**
  String get gstProfile;

  /// No description provided for @lockinmonth.
  ///
  /// In en, this message translates to:
  /// **'Lock-in Month'**
  String get lockinmonth;

  /// No description provided for @msgIfsc.
  ///
  /// In en, this message translates to:
  /// **'IFSC'**
  String get msgIfsc;

  /// No description provided for @nobnpldatafound.
  ///
  /// In en, this message translates to:
  /// **'No BNPL data found'**
  String get nobnpldatafound;

  /// No description provided for @nocurrentbids.
  ///
  /// In en, this message translates to:
  /// **'No current bids'**
  String get nocurrentbids;

  /// No description provided for @nocurrentorders.
  ///
  /// In en, this message translates to:
  /// **'No current orders'**
  String get nocurrentorders;

  /// No description provided for @nofinancesfound.
  ///
  /// In en, this message translates to:
  /// **'No finances found'**
  String get nofinancesfound;

  /// No description provided for @notransactionsfound.
  ///
  /// In en, this message translates to:
  /// **'No transactions found'**
  String get notransactionsfound;

  /// No description provided for @poDetails.
  ///
  /// In en, this message translates to:
  /// **'PO Details'**
  String get poDetails;

  /// No description provided for @somethingwentwrongyoumay.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingwentwrongyoumay;

  /// No description provided for @wsacharge.
  ///
  /// In en, this message translates to:
  /// **'WSA Charge'**
  String get wsacharge;

  /// No description provided for @poEdit.
  ///
  /// In en, this message translates to:
  /// **'PO Edit'**
  String get poEdit;

  /// No description provided for @poDelete.
  ///
  /// In en, this message translates to:
  /// **'PO Delete'**
  String get poDelete;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi', 'kn'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
    case 'kn':
      return AppLocalizationsKn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
