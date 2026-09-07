import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/helper.dart';
import 'package:apnagodam/presentation/bid_power/model/bid_power_model.dart';
import 'package:apnagodam/presentation/bid_power/service/bid_power_service.dart';
import 'package:apnagodam/presentation/home_screen/service/home_screen_service.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BidPowerScreen extends ConsumerStatefulWidget {
  const BidPowerScreen({super.key});

  @override
  ConsumerState<BidPowerScreen> createState() => _BidPowerScreenState();
}

class _BidPowerScreenState extends ConsumerState<BidPowerScreen> {
  final currencyFormat = NumberFormat.currency(
    locale: 'HI',
    symbol: '₹',
    decimalDigits: 2,
  );

  int _selectedType = 1; // 1 for Secure, 2 for UnSecure
  bool _isSubmitting = false;
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(userDetailsProvider);
      ref.invalidate(getUserTradeLimitReqProvider);
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  String _formatAmount(dynamic val) {
    if (val == null || val.toString().isEmpty) return '₹0.00';
    try {
      final d = double.parse(val.toString().replaceAll(',', ''));
      return currencyFormat.format(d);
    } catch (_) {
      return '₹${val.toString()}';
    }
  }

  String _formatDate(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    try {
      final dt = DateTime.parse(raw).toLocal();
      return DateFormat('dd MMM yyyy, hh:mm a').format(dt);
    } catch (_) {
      return raw;
    }
  }

  void _addQuickAmount(double delta) {
    final current = double.tryParse(_amountController.text.trim()) ?? 0.0;
    final updated = current + delta;
    _amountController.text = updated.toStringAsFixed(0);
  }

  void _showSuccessDialog(String message, bool isHindi) {
    if (getx.Get.isDialogOpen ?? false) {
      getx.Get.back();
    }
    getx.Get.defaultDialog(
      title: isHindi ? "सफल" : "Success",
      radius: 10,
      barrierDismissible: false,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_circle_rounded, color: ColorConstant.maingreen, size: 48),
          const SizedBox(height: 10),
          Text(
            message,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: Adaptive.sp(16),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevarmPrimaryButton.text(
              text: 'OK',
              buttonThemeData: ElevarmPrimaryButtonThemeData(
                primaryColor: ColorConstant.maingreen,
              ),
              onPressed: () => getx.Get.back(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isHindi = Get.locale?.languageCode == 'hi';
    final userAsync = ref.watch(userDetailsProvider);
    final reqsAsync = ref.watch(getUserTradeLimitReqProvider);

    // Extract total available limit from profile
    String totalAvailableLimit = '0.00';
    userAsync.whenData((authModel) {
      final u = authModel?.userDetails;
      totalAvailableLimit = (u?.bidPower ?? u?.power ?? '0.00').toString();
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F8),
      appBar: AppBar(
        elevation: 2,
        backgroundColor: ColorConstant.maingreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text(
          isHindi ? 'बिड पावर (Bid Power)' : 'Bid Power',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
            tooltip: isHindi ? 'रिफ्रेश करें' : 'Refresh',
            onPressed: () {
              ref.invalidate(userDetailsProvider);
              ref.invalidate(getUserTradeLimitReqProvider);
            },
          ),
          IconButton(
            icon: const Icon(Icons.headset_mic_rounded, color: Colors.amber),
            tooltip: isHindi ? 'हेल्पलाइन' : 'Helpline',
            onPressed: () => CallLaunch('tel:7733901154'),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: ColorConstant.maingreen,
        onRefresh: () async {
          ref.invalidate(userDetailsProvider);
          ref.invalidate(getUserTradeLimitReqProvider);
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Power Availability Metrics (including Trade Wallet Balance)
              _buildPowerAvailabilityHeader(context, userAsync, isHindi),
              const SizedBox(height: 18),

              // 2. Add Bid Power Request Form (with both Total Available Limit and Last Bid)
              _buildAddBidPowerSection(context, reqsAsync, userAsync, isHindi),
              const SizedBox(height: 20),

              // 3. Bid Power Requests Listing (with Update Option showing Total Available Limit)
              _buildBidPowerRequestsListSection(context, reqsAsync, totalAvailableLimit, isHindi),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  /// Top Power Availability Section with Metric Cards (including Trade Wallet Balance)
  Widget _buildPowerAvailabilityHeader(
    BuildContext context,
    AsyncValue<dynamic> userAsync,
    bool isHindi,
  ) {
    return userAsync.when(
      data: (authModel) {
        final u = authModel?.userDetails;
        final bidPower = u?.bidPower ?? u?.power ?? '0.00';
        final bidUsePower = u?.bidUsePower ?? '0.00';
        final bidHoldPower = u?.bidHoldPower ?? u?.holdPower ?? '0.00';
        final bidSecurePower = u?.bidSecurePower ?? '0.00';
        final bidUnsecurePower = u?.bidUnsecurePower ?? '0.00';
        final securityAmt = u?.securityAmt ?? '0.00';
        final tradePower = u?.tradePower ?? '0.00';

        return Column(
          children: [
            // Prominent Total Bid Power Card
            Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(18),
              child: InkWell(
                onTap: () => _showAmountDetailsDialog(
                  context,
                  isHindi ? 'कुल उपलब्ध बिड पावर' : 'Total Available Bid Power',
                  _formatAmount(bidPower),
                  icon: Icons.bolt_rounded,
                  iconColor: Colors.amber,
                  bgColor: Colors.amber.withValues(alpha: 0.2),
                ),
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF12281B),
                        Color(0xFF1E462B),
                        Color(0xFF2E6340),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: ColorConstant.maingreen.withValues(alpha: 0.35),
                        blurRadius: 14,
                        offset: const Offset(0, 5),
                      ),
                    ],
                    border: Border.all(color: Colors.amber.shade400, width: 1.2),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.bolt_rounded,
                                  color: Colors.amber,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                isHindi ? 'कुल उपलब्ध बिड पावर' : 'Total Available Bid Power',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              isHindi ? 'सक्रिय' : 'Active',
                              style: GoogleFonts.poppins(
                                color: Colors.amber,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _formatAmount(bidPower),
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isHindi
                            ? 'इस राशि से आप मार्केट में बोली (Bid) लगा सकते हैं।'
                            : 'Use this limit to place purchase and sell bids across markets.',
                        style: GoogleFonts.poppins(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Row 1: Used Power & Hold Power
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    context: context,
                    title: isHindi ? 'उपयोग की गई' : 'Used Power',
                    value: _formatAmount(bidUsePower),
                    icon: Icons.pie_chart_outline_rounded,
                    iconColor: Colors.orange.shade700,
                    bgColor: Colors.orange.shade50,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricCard(
                    context: context,
                    title: isHindi ? 'होल्ड बिड पावर' : 'Hold Power',
                    value: _formatAmount(bidHoldPower),
                    icon: Icons.pause_circle_outline_rounded,
                    iconColor: Colors.blue.shade700,
                    bgColor: Colors.blue.shade50,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Row 2: Secure Power & Unsecure Power
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    context: context,
                    title: isHindi ? 'सिक्योर बिड पावर' : 'Secure Power',
                    value: _formatAmount(bidSecurePower),
                    icon: Icons.verified_user_outlined,
                    iconColor: Colors.teal.shade700,
                    bgColor: Colors.teal.shade50,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricCard(
                    context: context,
                    title: isHindi ? 'अनसिक्योर बिड पावर' : 'Unsecure Power',
                    value: _formatAmount(bidUnsecurePower),
                    icon: Icons.shield_outlined,
                    iconColor: Colors.purple.shade700,
                    bgColor: Colors.purple.shade50,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Row 3: Security Deposit Amount & Trade Wallet Balance
            Row(
              children: [
                Expanded(
                  child: _buildMetricCard(
                    context: context,
                    title: isHindi ? 'सिक्योरिटी राशि' : 'Security Deposit Amount',
                    value: _formatAmount(securityAmt),
                    icon: Icons.security_rounded,
                    iconColor: const Color(0xFF4F46E5),
                    bgColor: const Color(0xFFEEF2FF),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildMetricCard(
                    context: context,
                    title: isHindi ? 'ट्रेड वॉलेट बैलेंस' : 'Trade Wallet Balance',
                    value: _formatAmount(tradePower),
                    icon: Icons.account_balance_wallet_rounded,
                    iconColor: const Color(0xFF0D9488),
                    bgColor: const Color(0xFFCCFBF1),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      loading: () => Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: CircularProgressIndicator.adaptive()),
      ),
      error: (_, __) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          isHindi ? 'प्रोफाइल विवरण लोड नहीं हो सका' : 'Unable to load profile summary',
          style: GoogleFonts.poppins(color: Colors.red, fontSize: 14),
        ),
      ),
    );
  }

  void _showAmountDetailsDialog(
    BuildContext context,
    String title,
    String amount, {
    IconData? icon,
    Color? iconColor,
    Color? bgColor,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: bgColor ?? ColorConstant.maingreen.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: iconColor ?? ColorConstant.maingreen, size: 36),
                ),
                const SizedBox(height: 16),
              ],
              Text(
                title,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade800,
                ),
              ),
              const SizedBox(height: 14),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: SelectableText(
                  amount,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1E293B),
                    letterSpacing: 0.5,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorConstant.maingreen,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'OK',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => _showAmountDetailsDialog(
          context,
          title,
          value,
          icon: icon,
          iconColor: iconColor,
          bgColor: bgColor,
        ),
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: iconColor, size: 20),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 3),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        value,
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          color: const Color(0xFF1E293B),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Add Bid Power Request Section (showing both Total Available Limit & Last Bid)
  Widget _buildAddBidPowerSection(
    BuildContext context,
    AsyncValue<UserTradeLimitReqModel> reqsAsync,
    AsyncValue<dynamic> userAsync,
    bool isHindi,
  ) {
    // 1. Total Available Limit
    String totalAvailableLimitStr = '₹0.00';
    userAsync.whenData((authModel) {
      final u = authModel?.userDetails;
      totalAvailableLimitStr = _formatAmount(u?.bidPower ?? u?.power);
    });

    // 2. Last Bid / Last Limit (latest submitted bid in the list)
    String lastLimitStr = '';
    reqsAsync.whenData((model) {
      final list = model.data ?? [];
      if (list.isNotEmpty) {
        lastLimitStr = _formatAmount(list.last.amount);
      }
    });

    if (lastLimitStr.isEmpty) {
      userAsync.whenData((authModel) {
        final u = authModel?.userDetails;
        final used = u?.bidUsePower;
        if (used != null && used.toString() != '0' && used.toString() != '0.00') {
          lastLimitStr = _formatAmount(used);
        }
      });
    }

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section Title
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: ColorConstant.maingreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.add_circle_outline_rounded,
                  color: ColorConstant.maingreen,
                  size: 26,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isHindi ? 'नया बिड पावर अनुरोध' : 'Add Bid Power Request',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  Text(
                    isHindi
                        ? 'राशि दर्ज करें और अनुरोध सबमिट करें'
                        : 'Enter amount & submit request',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),

          // Dual Limit Badges: Total Available Limit & Last Bid
          Row(
            children: [
              // Total Available Limit Badge
              Expanded(
                child: Material(
                  color: const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () => _showAmountDetailsDialog(
                      context,
                      isHindi ? 'कुल उपलब्ध सीमा' : 'Total Available Limit',
                      totalAvailableLimitStr,
                      icon: Icons.bolt_rounded,
                      iconColor: Colors.green.shade700,
                      bgColor: Colors.green.shade50,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.green.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.bolt_rounded, size: 16, color: Colors.green.shade700),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  isHindi ? 'कुल उपलब्ध सीमा' : 'Total Available',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: Colors.green.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              totalAvailableLimitStr,
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),

              // Last Bid / Last Limit Badge
              Expanded(
                child: Material(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () => _showAmountDetailsDialog(
                      context,
                      isHindi ? 'अंतिम बिड (Last Bid)' : 'Last Bid',
                      lastLimitStr.isNotEmpty ? lastLimitStr : '₹0.00',
                      icon: Icons.history_rounded,
                      iconColor: Colors.blue.shade700,
                      bgColor: Colors.blue.shade50,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue.shade300),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.history_rounded, size: 16, color: Colors.blue.shade700),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  isHindi ? 'अंतिम बिड (Last Bid)' : 'Last Bid',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: Colors.blue.shade800,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Text(
                              lastLimitStr.isNotEmpty ? lastLimitStr : '₹0.00',
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          // Direct Input Type Amount Field
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorConstant.maingreen, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  isHindi ? 'बिड राशि दर्ज करें (Enter Bid Amount)' : 'Enter Bid Amount',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey.shade700,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '₹ ',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: ColorConstant.maingreen,
                      ),
                    ),
                    Flexible(
                      child: IntrinsicWidth(
                        child: TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                          ],
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: ColorConstant.maingreen,
                            letterSpacing: 0.5,
                          ),
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                            border: InputBorder.none,
                            hintText: '0',
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade400,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),

          // Quick Increment Pill Buttons (+100, +500, +1K, +5K, +10K, Reset)
          Text(
            isHindi ? 'त्वरित राशि जोड़ें (+):' : 'Quick Add (+):',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildQuickAddChip('+ ₹100', 100.0),
                const SizedBox(width: 8),
                _buildQuickAddChip('+ ₹500', 500.0),
                const SizedBox(width: 8),
                _buildQuickAddChip('+ ₹1,000', 1000.0),
                const SizedBox(width: 8),
                _buildQuickAddChip('+ ₹5,000', 5000.0),
                const SizedBox(width: 8),
                _buildQuickAddChip('+ ₹10,000', 10000.0),
                const SizedBox(width: 8),
                ActionChip(
                  label: Text(
                    isHindi ? 'रीसेट (0)' : 'Reset (0)',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.red.shade700,
                    ),
                  ),
                  backgroundColor: Colors.red.shade50,
                  side: BorderSide(color: Colors.red.shade200),
                  onPressed: () {
                    _amountController.text = '0';
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Security Type Selector (Secure: 1 / UnSecure: 2)
          Text(
            isHindi ? 'सिक्योरिटी प्रकार चुनें:' : 'Security Type:',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade700,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _selectedType = 1),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: _selectedType == 1
                          ? Colors.teal.shade50
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedType == 1
                            ? Colors.teal.shade600
                            : Colors.grey.shade300,
                        width: _selectedType == 1 ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _selectedType == 1
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: _selectedType == 1
                              ? Colors.teal.shade700
                              : Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              isHindi ? 'सिक्योर (1)' : 'Secure (1)',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: _selectedType == 1
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: _selectedType == 1
                                    ? Colors.teal.shade900
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: InkWell(
                  onTap: () => setState(() => _selectedType = 2),
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    decoration: BoxDecoration(
                      color: _selectedType == 2
                          ? Colors.purple.shade50
                          : const Color(0xFFF8FAFC),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _selectedType == 2
                            ? Colors.purple.shade600
                            : Colors.grey.shade300,
                        width: _selectedType == 2 ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _selectedType == 2
                              ? Icons.radio_button_checked
                              : Icons.radio_button_off,
                          color: _selectedType == 2
                              ? Colors.purple.shade700
                              : Colors.grey,
                          size: 20,
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              isHindi ? 'अनसिक्योर (2)' : 'UnSecure (2)',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: _selectedType == 2
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                color: _selectedType == 2
                                    ? Colors.purple.shade900
                                    : Colors.grey.shade700,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 22),

          // Submit Button
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton.icon(
              onPressed: _isSubmitting ? null : _submitBid,
              icon: _isSubmitting
                  ? const SizedBox()
                  : const Icon(Icons.check_circle_rounded, color: Colors.white, size: 24),
              label: _isSubmitting
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                  : Text(
                      isHindi ? 'अनुरोध सबमिट करें' : 'Save Request',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 0.3,
                      ),
                    ),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorConstant.maingreen,
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAddChip(String label, double delta) {
    return ActionChip(
      label: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: ColorConstant.maingreen,
        ),
      ),
      backgroundColor: ColorConstant.maingreen.withValues(alpha: 0.08),
      side: BorderSide(color: ColorConstant.maingreen.withValues(alpha: 0.25)),
      onPressed: () => _addQuickAmount(delta),
    );
  }

  /// Bid Power Requests Listing Section (with Update Option)
  Widget _buildBidPowerRequestsListSection(
    BuildContext context,
    AsyncValue<UserTradeLimitReqModel> reqsAsync,
    String totalAvailableLimit,
    bool isHindi,
  ) {
    return reqsAsync.when(
      data: (model) {
        final list = model.data ?? [];
        return Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // List Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.list_alt_rounded,
                          color: Colors.blue.shade700,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isHindi ? 'बिड पावर अनुरोध सूची' : 'Bid Power Requests',
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF1E293B),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${list.length} ${isHindi ? 'रिकॉर्ड' : 'Requests'}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Color(0xFFF1F5F9)),
              const SizedBox(height: 14),

              if (list.isEmpty)
                Container(
                  padding: const EdgeInsets.all(24),
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      Icon(Icons.inbox_outlined, size: 48, color: Colors.grey.shade400),
                      const SizedBox(height: 8),
                      Text(
                        isHindi ? 'कोई बिड पावर अनुरोध नहीं मिला' : 'No bid power requests found',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = list[index];
                    final isSecure = (item.clientSecurityType ?? '').toLowerCase().contains('secure') &&
                        !(item.clientSecurityType ?? '').toLowerCase().contains('unsecure');

                    return Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header: TM Name & Security Type Badge
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  item.tmName ?? 'Trading Member',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF1E293B),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isSecure ? Colors.teal.shade50 : Colors.purple.shade50,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: isSecure ? Colors.teal.shade300 : Colors.purple.shade300,
                                  ),
                                ),
                                child: Text(
                                  item.clientSecurityType ?? '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: isSecure ? Colors.teal.shade800 : Colors.purple.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Details: Amount, HairCut, TradeLimit
                          Row(
                            children: [
                              Expanded(
                                child: _buildInfoColumn(
                                  isHindi ? 'राशि (Amount)' : 'Amount',
                                  _formatAmount(item.amount),
                                  ColorConstant.maingreen,
                                ),
                              ),
                              Expanded(
                                child: _buildInfoColumn(
                                  isHindi ? 'हेयर कट' : 'Hair Cut',
                                  '${item.hairCut ?? 0}%',
                                  Colors.orange.shade800,
                                ),
                              ),
                              Expanded(
                                child: _buildInfoColumn(
                                  isHindi ? 'ट्रेड लिमिट' : 'Trade Limit',
                                  _formatAmount(item.tradelimit),
                                  Colors.blue.shade800,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),

                          // Footer: Date & Update Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _formatDate(item.date),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () => _showUpdateDialog(context, item, totalAvailableLimit, isHindi),
                                icon: const Icon(Icons.edit_rounded, size: 16, color: Colors.white),
                                label: Text(
                                  isHindi ? 'अपडेट करें' : 'Update',
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorConstant.maingreen,
                                  elevation: 1,
                                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        );
      },
      loading: () => Container(
        height: 120,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: CircularProgressIndicator.adaptive()),
      ),
      error: (_, __) => const SizedBox(),
    );
  }

  Widget _buildInfoColumn(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  /// Show Update Limit Modal BottomSheet (showing Total Available Limit)
  void _showUpdateDialog(
    BuildContext context,
    UserTradeLimitItem item,
    String totalAvailableLimit,
    bool isHindi,
  ) {
    final updateController = TextEditingController(
      text: item.amount != null ? double.tryParse(item.amount.toString())?.toStringAsFixed(0) ?? '' : '',
    );
    bool isUpdating = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setModalState) {
          return Container(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              top: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isHindi ? 'बिड पावर अपडेट करें' : 'Update Bid Power',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.tmName ?? "CLPL"} • ${item.clientSecurityType ?? ""}',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 14),

                // Dual Info in Bottom Sheet: Total Available Limit & Current Amount
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0FDF4),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.green.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isHindi ? 'कुल उपलब्ध सीमा' : 'Total Available',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.green.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _formatAmount(totalAvailableLimit),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.green.shade900,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue.shade50,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue.shade300),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isHindi ? 'वर्तमान बिड' : 'Current Bid',
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.blue.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              _formatAmount(item.amount),
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.blue.shade900,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                Text(
                  isHindi ? 'नई राशि दर्ज करें (₹):' : 'Enter New Amount (₹):',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: updateController,
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: ColorConstant.maingreen,
                  ),
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.currency_rupee_rounded, size: 20),
                    hintText: '0',
                    filled: true,
                    fillColor: const Color(0xFFF8FAFC),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: BorderSide(color: ColorConstant.maingreen, width: 1.5),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: isUpdating
                        ? null
                        : () async {
                            final newAmt = double.tryParse(updateController.text.trim()) ?? 0.0;
                            if (newAmt <= 0) {
                              showErrorAlertDialog(
                                context,
                                isHindi
                                    ? 'कृपया 0 से अधिक राशि दर्ज करें'
                                    : 'Please enter an amount greater than 0',
                              );
                              return;
                            }
                            setModalState(() => isUpdating = true);
                            try {
                              final res = await ref.read(bidPowerServiceProvider).updateTradeLimitData(
                                    id: item.id,
                                    amount: newAmt,
                                  );
                              if (mounted) Navigator.pop(context);
                              ref.invalidate(getUserTradeLimitReqProvider);
                              ref.invalidate(userDetailsProvider);
                              _showSuccessDialog(
                                res['message']?.toString() ??
                                    (isHindi ? 'सफलतापूर्वक अपडेट किया गया!' : 'Updated successfully!'),
                                isHindi,
                              );
                            } catch (e) {
                              showErrorAlertDialog(context, 'Error: $e');
                            } finally {
                              setModalState(() => isUpdating = false);
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.maingreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: isUpdating
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          )
                        : Text(
                            isHindi ? 'अपडेट करें (Update)' : 'Update Limit',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Submit the Bid Power Request (saveUsertradeLimitReq)
  Future<void> _submitBid() async {
    final isHindi = Get.locale?.languageCode == 'hi';
    final amount = double.tryParse(_amountController.text.trim()) ?? 0.0;

    if (amount <= 0) {
      showErrorAlertDialog(
        context,
        isHindi
            ? 'कृपया 0 से अधिक बिड राशि दर्ज करें'
            : 'Please enter a bid amount greater than 0',
      );
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      final res = await ref.read(bidPowerServiceProvider).saveUserTradeLimitReq(
            amount: amount,
            type: _selectedType,
          );

      ref.invalidate(getUserTradeLimitReqProvider);
      ref.invalidate(userDetailsProvider);

      _amountController.text = '0';

      _showSuccessDialog(
        res['message']?.toString() ??
            (isHindi
                ? 'बिड अनुरोध सफलतापूर्वक सबमिट किया गया!'
                : 'Bid request submitted successfully!'),
        isHindi,
      );
    } catch (e) {
      showErrorAlertDialog(
        context,
        'Error: $e',
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }
}
