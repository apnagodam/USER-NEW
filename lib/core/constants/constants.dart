// com.example.lazycharge
// const String BASEURL ='https://tradeyarr.com/backend/';
// ignore_for_file: constant_identifier_names

import '../../presentation/home_screen/models/CommonIndexModel.dart';
// const String BASEURL ='https://lionstocks.net/backend/';
// // //TEST TEST TEST TEST TEST TEST TEST
const String BASEURL = 'https://demoaws.apnagodam.com/';
const String IMAGE_BASE_URL =
    'https://demoaws.apnagodam.com/resources/assets/upload/';
const String IMAGE_BASE_URL_FRONTEND =
    'https://demoaws.apnagodam.com/resources/frontend_assets/uploads/';


// Live Live Live Live Live Live
// const String BASEURL = 'https://apnagodam.com/';
// const String IMAGE_BASE_URL = 'https://apnagodam.com/resources/assets/upload/';
// const String IMAGE_BASE_URL_FRONTEND =
//     'https://apnagodam.com/resources/frontend_assets/uploads/';

const String DOLOGIN = '${BASEURL}api/apna_send_otp';
const String DOSIGNUPOTPVERIFY = '${BASEURL}user_api/apna_u_signup';
const String DOOTPVERIFY = '${BASEURL}api/apna_verify_otp';
const String SIGN_UP_OTP_SEND = '${BASEURL}user_api/apna_u_send_signup_otp';
const String MANDIBHAV = '${BASEURL}api/mandi-bhav-list';
const String COMMIDITY_LIST = '${BASEURL}api/index-data';
const String USER_DETAILS = '${BASEURL}user_api/apna_u_user_details';
const String GET_USER_TRADE_LIMIT_REQ = '${BASEURL}user_api/getUsertradeLimitReq';
const String SAVE_USER_TRADE_LIMIT_REQ = '${BASEURL}user_api/saveUsertradeLimitReq';
const String UPDATE_TRADE_LIMIT_DATA = '${BASEURL}user_api/upDateTradeLimitData';
const String ADD_MONEY = '${BASEURL}user_api/add-money-request';
const String WITHDRAW_MONEY = '${BASEURL}user_api/withdrawal-request';
const String WALLET_STATEMENT = '${BASEURL}user_api/wallet-statement';
const String EMANDI_SELL_DATA = '${BASEURL}user_api/apna_u_get_settlement';
const String MRA_MALL = '${BASEURL}user_api/apna_u_get_inventories';
const String APNAUCOMMODITYBIDDING =
    '${BASEURL}user_api/apna_u_commodity_biddings';
const String FINANCE_TERM = '${BASEURL}user_api/finance-terms';
const String SANCTION_LIMIT_TERM = '${BASEURL}user_api/sanction-limit-terms';
const String SANCTION_LIMIT_LIST = '${BASEURL}user_api/sanction-limit-list';
const String FINANCE_BANKS = '${BASEURL}user_api/finance-banks';
const String SANCTION_LIMIT_APPLY = '${BASEURL}user_api/sanction-limit-apply';
const String FTWOF_DEAL_CREATE = '${BASEURL}user_api/f2f-deal-create';
const String FTWOF_DEAL_CALCULATION = '${BASEURL}user_api/deal-calculation';
const String APNA_WAREHOUSE_LIST = '${BASEURL}user_api/apna_u_sell_buy_list';
const String APNA_SPOT_DEAL = '${BASEURL}user_api/apna_u_get_spot_deals';
const String FTWOF_DEALS = '${BASEURL}user_api/f2f-deals';
const String SBT_COMMODITY_LIST = '${BASEURL}sbt_api/sbt_product_list';
const String SBT_BUYER_SELLER = '${BASEURL}sbt_api/sbt_trade_list';
const String SBT_BUYANDSELL = '${BASEURL}user_api/apna_u_sbt_seller';
const String SELL_ORDER_CREATE = '${BASEURL}user_api/apna_u_add_spot_inventory';
const String TERMINAL_LIST = '${BASEURL}api/apna_terminals';
const String BUY_ORDER_CREATE = '${BASEURL}user_api/generate-order';
const String USER_COMMODITY_TERMINAL =
    '${BASEURL}user_api/apna_u_get_user_commodity_terminal';
const String STACK_WISE_SETTLEMENT_TERMINAL =
    '${BASEURL}user_api/apna_u_terminal_stack_wise_settlement';
const String CORPORATE_ORDERS = '${BASEURL}user_api/corporate-orders';
const String CORPORATE_ORDERS_UPDATE =
    '${BASEURL}user_api/update-corporate-order';
const String CORPORATE_ORDERS_DELETE =
    '${BASEURL}user_api/corporate-buyer-destroy';
const String SPOT_ORDERS_LIST = '${BASEURL}user_api/order-list';
const String USER_REPAYMENT_SETTLEMENT =
    '${BASEURL}user_api/apna_u_get_user_repayment_sattlement';
const String WAREHOUSE_TERMINAL_STACK =
    '${BASEURL}user_api/apna_u_get_tarminal_stack';

const String GET_RATECARD_LASTID =
    '${BASEURL}user_api/apna_u_get_ratecard_lastid';
const String WAREHOUSE_DEFAULT_LIST = '${BASEURL}api/apna_default_list';

const String APANA_CREATE_STACK_REQUEST =
    '${BASEURL}user_api/apna_u_create_stack_request';

const String createStackRequestOutward =
    '${BASEURL}user_api/v1_apna_u_add_outward_request';

const String APANA_U_RATE_CARD = '${BASEURL}user_api/apna_u_rate_card';

const String APANA_U_ADD_INWORD_REQUEST =
    '${BASEURL}user_api/v1_apna_u_add_inword_request'; //apna_u_add_inword_request
const String BNPL_REQUEST_LIST = '${BASEURL}user_api/bnpl-request-list';
const String BNPL_SUMMARY_LIST = '${BASEURL}user_api/bnpl-summary';
const String BNPL_DESTORY = '${BASEURL}user_api/bnpl-destroy';
const String BNPL_REQUEST_ADD = '${BASEURL}user_api/bnpl-request';
const String APANA_U_GET_INWORD_REQUEST_LIST =
    '${BASEURL}user_api/apna_u_get_inword_request';  
const String APANA_U_REJECT_INWORD_REQUEST =
    '${BASEURL}user_api/apna_u_reject_inword_request';
const String APANA_U_FINANCE_LIST = '${BASEURL}user_api/apna_u_finance_list';
const String WBT_UPDATE_SELL_PRICE = '${BASEURL}user_api/update-sell-price';
const String APNA_U_BID_BY_BUYER = '${BASEURL}user_api/apna_u_bid_by_buyer';
const String APNA_U_WANT_TO_SELL = '${BASEURL}user_api/apna_u_want_to_sell';
const String NEW_TAJA_BHAV = '${BASEURL}user_api/new-taja-bhav';
const String APNA_U_BIDDING_LIST = '${BASEURL}user_api/apna_u_bidding_list';
const String APNA_U_UPDATE_USER_IMAGE =
    '${BASEURL}user_api/apna_u_update_user_image';
const String EMANDI_SELL_QUALITY_CLAIM =
    '${BASEURL}user_api/apna_u_get_quality_claim';
const String APNA_U_UPDATE_USER = '${BASEURL}user_api/apna_u_update_user';
const String APNA_U_GET_PDF = '${BASEURL}user_api/apna_u_get_pdf';
const String APNA_U_ON_BOOK_MGP_LP = '${BASEURL}user_api/apna_u_on_book_mgp_lp';
const String APNA_USER_VIEW_BOOKING =
    '${BASEURL}user_api/apna_user_view_booking';
const String APNA_USER_ALL_BOOKINGS =
    '${BASEURL}user_api/apna_user_all_bookings';
const String APNA_USER_CANCEL_BOOKINGS =
    '${BASEURL}user_api/apna_user_cancel_booking';
const String APNA_USER_ACCEPT_PRICE_REQUEST =
    '${BASEURL}user_api/apna_user_price_accept_request';
const String APNA_USER_ACCEPT_WEIGHT_REQUEST =
    '${BASEURL}user_api/apna_user_weight_accept_request';
const String USER_COMMODITY_DATA = '${BASEURL}user_api/user_commodity_data';
const String USER_COMMODITY_LIST = '${BASEURL}user_api/user_commodity_list';
const String SETTINGS_URL = '${BASEURL}api/settings';

const String APNA_U_LOAN_REQUEST = '${BASEURL}user_api/apna_u_loan_request';
const String WITHDRAWAL_REQUEST_LIST =
    '${BASEURL}user_api/withdrawal-request-list';
const String ADD_MONEY_REQUEST_LIST =
    '${BASEURL}user_api/apna_u_get_repayment_request';
const String APNA_U_GET_INWARDREQUEST =
    '${BASEURL}user_api/apna_u_get_inwardrequest';

const String APANA_COMMIDITY = '${BASEURL}api/apna_commodities';
const String APANA_MASTER_COMMIDITY = '${BASEURL}api/apna-master-commodities';
const String APANA_U_SPOT_INVENTORIES =
    '${BASEURL}user_api/apna_u_spot_inventories';
const String APANA_USER_LOGUT = '${BASEURL}api/apna_user_logout';
const String APANA_U_ON_BOOK_MPG_LP =
    '${BASEURL}user_api/apna_u_on_book_mgp_lp_test';
const String GRAPH = '${BASEURL}user_api/apna_u_commodity_graph';
const String FINANCEGATEPASS = '${BASEURL}user_api/apna_u_get_finance_gatepass';
const String LOANPRICE = '${BASEURL}user_api/apna_u_loan_price';
const String CONTRACTNOTE = '${BASEURL}user_api/apna_u_get_contract_note';

const String DISTRICTSBTLIST = '${BASEURL}api/apna_sbt_districts';
const String DISTRICT_COMMODITY_LIST =
    '${BASEURL}api/apna_commodities_districtwise';

// var select = "en";

/*

Anant's work since since January 2024


*/

const String getInwardTripList = '${BASEURL}user_api/inward_trip_id';
const String getOutwardTripList = '${BASEURL}user_api/outward_trip_id';

const String getTransporterList =
    '${BASEURL}user_api/apna_u_get_trip_transporter';

const String getPO = 'user_api/apna_u_get_trip_po';

const String tripidRequestCreate = 'user_api/trip_request_create';
const String getTripRequests = 'user_api/apna_u_get_trip_request';

const String getBiltyData = "user_api/bilty_data";
const String getFreightData = 'user_api/fright_data';

const String tripIdUpdate = 'user_api/trip_request_update';

const sbtUpdate = 'sbt_api/sbt_trade_edit';

const postBid = 'sbt_api/sbt_trade_save';

const getMatchingOrders = 'sbt_api/sbt_trade_order_list';

const deleteSbtOrder = 'sbt_api/sbt_trade_order_cancelled';

const getSbtRequest = 'user_api/sbt-request-list';

const getSbtHoldList = 'user_api/sbt-hold-list';

const getMatchedOrders = 'user_api/match-order-list';

const getMatchOrderPrint = 'sbt_api/get_match_order_print';

const getMatchOrderPdf = 'sbt_api/get_match_order_pdf';

const getOrderInventories = 'user_api/order-inventory-list';

const postDelivery = 'user_api/mark-delivery';

const getDeliveryMarkingTerminalList = 'user_api/get_terminal_list';

const getDeliveryMarkingStackList = 'user_api/get_stack_list';

const getOutwardsRequests = 'user_api/apna_u_get_outward_request';

const rejectOutwardRequest = 'user_api/apna_u_update_outward_request';

const getSbtHoldSummary = 'emp_api/get_hold_summary_data';

const getHoldStatement = 'user_api/hold-data-list';

const getHoldSummary = 'user_api/hold-data-summery';

const getProductQuality = 'user_api/product-quality-parameter';

const getWarehouseList = 'user_api/product-delivery-center';

const getSbtTerms = 'user_api/user_sbt_terms';

const getSbtContractList = 'user_api/sbt-contract-note-list';

const getSbtContractNote = 'user_api/sbt-contract-note';

const getBuyerSbtContractNote = 'user_api/sbt-confirm_contract-note';

const rejectTripId = 'user_api/trip_request_reject';

const updateMandiTaxProfile = 'user_api/update-mandi-tax-profile';

const getCandF = 'user_api/get_candf';

const postPurchaseOrder = 'user_api/purchase-order-store';

const getPurchaseOrders = 'user_api/purchase-order';

const deletePurchaseOrders = 'user_api/purchase-order-delete';
const updatePUrchaseOrders = 'user_api/purchase-order-edit';

const getMandiTaxProfiles = 'user_api/mandi-tax-profile';

const checkUserWallet = '/sbt_api/check_user_wallet';

const getBookingData = 'user_api/apna_u_get_case_status';

const getBookingQuality = 'user_api/apna_u_case_quality';

const approveBookingQuality = 'user_api/apna_u_quality_approve';

const getListOfFaq = 'user_api/apna_u_complaint_types';

const rejectQualityClaim = 'user_api/apna_u_quality_reject';

const addGstProfile = '/user_api/store_user_gst_profile';
const getGstProfileListing = '/user_api/get_user_gst_profile';
const getBusinessProfileListing = '/user_api/get_user_profile';
const setBusinessProfile = 'user_api/store_user_profile';

const getWalletSummary = 'user_api/wallet-statement-summery';

const String getWarehouseData = 'api/apna_terminals';

const registerUserProfile = "user_api/v1_exists_user_update_kyc";
// const registerUserProfile = "user_api/exists_user_update_kyc";
const registerOldUser = 'user_api/old_user_update_kyc';

const String getWarehouseHistory =
    '${BASEURL}user_api/apna_u_get_stack_request';

const String gatePassTerms = 'user_api/get_gatepass_sell_terms';
/*
Partners and directors api
*
*
*
*/

const directorSendOtp =
    'director_partners_add_send_otp'; // api for partner and director

const submitDirectorDetails =
    'partenrs_director_add'; // api for partner and director submission
const getListOfPartnersDirectors = 'partenrs_director_list';
const updateDirectorPartner = 'partenrs_director_update';
const sendDirectorVerifyOtp = 'director_partners_update_send_otp';

const getAuthorisationLetter = 'auth_letter_download'; //auth_letter_upload

const uploadAuthorisationLetter = 'auth_letter_upload';
/*
commodity quality calculator
*
*
*/

const getQualityParamsList = 'user_api/get_quality_parameter_list';
const getQualityPrice = 'user_api/get_quality_deduction_amount';

/*
sates url from api controller.php*
*
*
*/

const getStatesNew = "api/get_state_name_new";
const getDistrictsNew = 'api/district-list-new';

const getStates = "api/get_state_name";
const getDistricts = 'api/district-list';
/*
aadhar verification apis
*
*
*/
const userSendAadharVerificationOtp = 'user_api/otp-send_aadhar-zoop';
const userVerifAadharOtp = 'user_api/otp-verify_aadhar-zoop';
/*
dispatch request apis
*
*
*/
const postDispatchRequestSBT = 'user_api/add_vdc_inward_request';
const postDispatchRequest = 'user_api/add_dispatch_request';

const getDispatchListing = 'user_api/get_dispatch_request';
const getDispatchListingSBT = 'user_api/get_vdc_inward_request';

const getDispatchQualityParams = 'user_api/get_factory_qv';
const updateDispatchQualityParams = 'user_api/update_factory_weight';
const updateDispatchPhotosEndpoint = 'user_api/update_dispatch_photos';
const removeDispatchRequest = 'user_api/dispatch_reject_request';
const removeDispatchRequestSBT = 'user_api/reject_vdc_inward_request';
const finalSubmitDispatchRequest = 'user_api/dispatch_final_submit';
const rejectDispatchRequest = 'user_api/reject_vdc_inward_request';
const updateDispatchRequest = 'user_api/update_grn_request';
const getGrnRequestList = 'user_api/get_grnrequest_list';

/*
new My Stock Apis
*
*
*/
const getStacksTerminals = 'user_api/user_terminal_list';
const getStacksCommodity = 'user_api/user_commodity_list';
const getStacks = 'user_api/user_stack_list';
const getStackSettlementData = 'user_api/user_stack_settlement_list';
const postWantToSell = 'user_api/user_stack_want_to_sell';
const getDefaultStackSellListing =
    'user_api/default_get_stack_want_to_sell_list';
const getStackSellListing = 'user_api/get_stack_want_to_sell_list';
const getStackOrdersListing = 'user_api/user_stack_want_to_sell_list';
const getStackBuySellListing = 'user_api/apna_u_stack_buy_sell_list';
const getStackContractNote = 'user_api/apna_u_stack_buy_sell_contract_note';
const postStackBid = 'user_api/buyer_stack_want_to_buy';
const postSellerPriceUpdate = 'user_api/seller_stack_sell_price_update';
const postSellerPriceDelete = 'user_api/seller_stack_sell_price_delete';
const fetchStackSellTerms = 'user_api/get_stack_sell_terms';

//purchase order apis
const getBrokerList = 'user_api/get_broker_buyer_list';
const getPoOutwards = 'user_api/apna_u_get_trip_offline_po';
const String getPoWarehouseData = 'user_api/getWarehouseData';
const String getPoCommodityData = 'user_api/getCommodityData';
const String getPoShipToUserData = 'user_api/getShipToUserData';
const String getPoFactoryList = 'user_api/getFactoryList';

//account disable
const disableUserAccount = 'user_api/disable_user_account';

//invoices
const invoiceData = 'user_api/get_rise_by_me_invoice';
const invoicePdf = 'user_api/get_clpl_pdf_data';
String wallatAmount = "0";
//get address
const addressFromPincode = 'user_api/get_address_from_pincode';

//authentication apis
const String CHECK_USER_URL = 'user_api/check_user';
const String USER_REGISTER_URL = 'user_api/user_register';
const String USER_SEND_OTP_URL = 'user_api/user_send_otp';
const String USER_VERIFY_OTP_URL = 'user_api/user_verify_otp';

List<Commodites> commodityslist = [];

bool connectivity = true, isNotifyConnectivity = false;

