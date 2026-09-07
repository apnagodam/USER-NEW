import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:apnagodam/core/config/app_config.dart';
import 'package:apnagodam/core/services/exotel_service.dart';
import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';

/// Entry point to display the Exotel AI Call Request Dialog / Bottom Sheet
void showExotelCallDialog(
  BuildContext context, {
  WidgetRef? ref,
  String? initialQuery,
  String? defaultTopic,
  Map<String, dynamic>? userProfile,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _ExotelCallBottomSheet(
      ref: ref,
      initialQuery: initialQuery,
      defaultTopic: defaultTopic,
      userProfile: userProfile,
    ),
  );
}

class _ExotelCallBottomSheet extends StatefulWidget {
  final WidgetRef? ref;
  final String? initialQuery;
  final String? defaultTopic;
  final Map<String, dynamic>? userProfile;

  const _ExotelCallBottomSheet({
    this.ref,
    this.initialQuery,
    this.defaultTopic,
    this.userProfile,
  });

  @override
  State<_ExotelCallBottomSheet> createState() => _ExotelCallBottomSheetState();
}

class _ExotelCallBottomSheetState extends State<_ExotelCallBottomSheet>
    with SingleTickerProviderStateMixin {
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _queryCtrl;

  String _selectedLanguage = 'hi'; // 'mwr', 'hi', 'en'
  String _selectedTopic = 'mandi_rates';

  bool _isCalling = false;
  bool _callSuccess = false;
  String? _callSid;
  String? _statusMessage;
  Timer? _statusTimer;

  late AnimationController _pulseCtrl;

  final List<Map<String, dynamic>> _topics = [
    {
      'id': 'mandi_rates',
      'label': '🌾 मंडी भाव',
      'sub': 'Mandi Rates',
    },
    {
      'id': 'warehouse_booking',
      'label': '🏢 वेयरहाउस',
      'sub': 'Storage & Space',
    },
    {
      'id': 'trade_orders',
      'label': '🤝 व्यापार व सौदे',
      'sub': 'Trades & Bidding',
    },
    {
      'id': 'loan_finance',
      'label': '💰 लोन व वित्त',
      'sub': 'Finance / BNPL',
    },
    {
      'id': 'general_query',
      'label': '❓ अन्य सहायता',
      'sub': 'General Help',
    },
  ];

  final List<Map<String, String>> _languages = [
    {'code': 'hi', 'name': 'हिन्दी (Hindi)'},
    {'code': 'mwr', 'name': 'मारवाड़ी (Marwari)'},
    {'code': 'en', 'name': 'English'},
  ];

  @override
  void initState() {
    super.initState();
    _phoneCtrl = TextEditingController();
    _queryCtrl = TextEditingController(text: widget.initialQuery ?? '');

    if (widget.defaultTopic != null) {
      _selectedTopic = widget.defaultTopic!;
    }

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    // Auto-fetch user phone number from SharedPrefs if available
    _autoPopulatePhone();
  }

  void _autoPopulatePhone() {
    try {
      if (widget.ref != null) {
        final sharedUtility = widget.ref!.read(sharedUtilityProvider);
        final user = sharedUtility.getUser();
        if (user != null && user.phone != null && user.phone.toString().isNotEmpty) {
          _phoneCtrl.text = user.phone.toString();
        }
      }
    } catch (_) {}
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _statusTimer?.cancel();
    _phoneCtrl.dispose();
    _queryCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleInitiateCall() async {
    final phone = _phoneCtrl.text.trim();

    if (!ExotelService.isValidIndianPhoneNumber(phone)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('कृपया सही 10 अंकों का मोबाइल नंबर दर्ज करें।'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() {
      _isCalling = true;
      _statusMessage = 'Exotel AI सर्वर से कॉल कनेक्ट की जा रही है...';
    });

    final response = await ExotelService.initiateAiCall(
      userPhone: phone,
      topic: _selectedTopic,
      language: _selectedLanguage,
      customQuery: _queryCtrl.text.trim(),
      userProfile: widget.userProfile,
    );

    if (!mounted) return;

    if (response.success) {
      setState(() {
        _isCalling = false;
        _callSuccess = true;
        _callSid = response.callSid;
        _statusMessage = 'कॉल शुरू हो गई है! कृपया अपने फोन पर आने वाली कॉल का उत्तर दें।';
      });

      // Poll call status periodically
      if (_callSid != null && !_callSid!.startsWith('simulated_')) {
        _statusTimer = Timer.periodic(const Duration(seconds: 4), (timer) async {
          final statusRes = await ExotelService.getCallDetails(_callSid!);
          if (mounted && statusRes.status != null) {
            setState(() {
              if (statusRes.status == 'in-progress') {
                _statusMessage = '📞 कॉल जारी है (In Progress) - AI से बात हो रही है...';
              } else if (statusRes.status == 'completed') {
                _statusMessage = '✅ कॉल सफलतापूर्वक संपन्न हुई।';
                timer.cancel();
              } else if (statusRes.status == 'failed' || statusRes.status == 'busy' || statusRes.status == 'no-answer') {
                _statusMessage = 'कॉल स्थिति: ${statusRes.status}';
                timer.cancel();
              }
            });
          }
        });
      }
    } else {
      setState(() {
        _isCalling = false;
        _callSuccess = false;
        _statusMessage = response.message;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.message),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  Future<void> _directCallSupport() async {
    final callerId = AppConfig.exotelCallerId;
    final phoneNumber = callerId.isNotEmpty && callerId != 'YOUR_EXOPHONE_NUMBER'
        ? callerId
        : '18001234567'; // Fallback toll-free
    final uri = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      margin: EdgeInsets.only(bottom: bottomInset),
      decoration: const BoxDecoration(
        color: Color(0xFF0F1E16),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(28),
          topRight: Radius.circular(28),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black54,
            blurRadius: 20,
            offset: Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.5.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top drag pill
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              SizedBox(height: 2.h),

              // Header with glowing phone icon
              Row(
                children: [
                  AnimatedBuilder(
                    animation: _pulseCtrl,
                    builder: (context, child) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: const Color(0xFF275135),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.amber.withValues(alpha: 0.3 * _pulseCtrl.value),
                              blurRadius: 16 * _pulseCtrl.value,
                              spreadRadius: 2 * _pulseCtrl.value,
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.phone_in_talk_rounded,
                          color: Colors.amber,
                          size: 26,
                        ),
                      );
                    },
                  ),
                  SizedBox(width: 3.5.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AI वॉइस कॉल (Exotel IVR)',
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 0.3.h),
                        Text(
                          'अपना गोदाम AI आपके फोन पर कॉल करके बात करेगा',
                          style: GoogleFonts.poppins(
                            color: Colors.white70,
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close_rounded, color: Colors.white54),
                  ),
                ],
              ),

              const Divider(color: Colors.white12, height: 28),

              if (_callSuccess) ...[
                // Success Call State View
                _buildCallActiveView(),
              ] else ...[
                // Call Request Form
                _buildCallFormView(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCallFormView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Mobile Number Input
        Text(
          'आपका मोबाइल नंबर (Phone Number)',
          style: GoogleFonts.poppins(
            color: Colors.amber.shade300,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 0.8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1B3524),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: TextField(
            controller: _phoneCtrl,
            keyboardType: TextInputType.phone,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 15.5.sp,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.1,
            ),
            decoration: InputDecoration(
              prefixIcon: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('🇮🇳 +91', style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold)),
                    SizedBox(width: 2.w),
                    Container(height: 20, width: 1, color: Colors.white24),
                  ],
                ),
              ),
              hintText: '9876543210',
              hintStyle: const TextStyle(color: Colors.white38),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),

        SizedBox(height: 2.h),

        // 2. Language Selection
        Text(
          'बातचीत की भाषा चुनें (Preferred Language)',
          style: GoogleFonts.poppins(
            color: Colors.amber.shade300,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _languages.map((lang) {
            final isSelected = _selectedLanguage == lang['code'];
            return ChoiceChip(
              label: Text(lang['name']!),
              selected: isSelected,
              onSelected: (val) {
                if (val) setState(() => _selectedLanguage = lang['code']!);
              },
              selectedColor: Colors.amber.shade500,
              backgroundColor: const Color(0xFF1B3524),
              labelStyle: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13.5.sp,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: isSelected ? Colors.amber : Colors.white12,
                ),
              ),
            );
          }).toList(),
        ),

        SizedBox(height: 2.h),

        // 3. Topic Selection
        Text(
          'सवाल का विषय चुनें (Query Topic)',
          style: GoogleFonts.poppins(
            color: Colors.amber.shade300,
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        Wrap(
          spacing: 2.w,
          runSpacing: 1.h,
          children: _topics.map((topic) {
            final isSelected = _selectedTopic == topic['id'];
            return ChoiceChip(
              label: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(topic['label']),
                ],
              ),
              selected: isSelected,
              onSelected: (val) {
                if (val) setState(() => _selectedTopic = topic['id']);
              },
              selectedColor: const Color(0xFF2E6340),
              backgroundColor: const Color(0xFF1B3524),
              labelStyle: TextStyle(
                color: isSelected ? Colors.amber.shade300 : Colors.white70,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 13.5.sp,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(
                  color: isSelected ? Colors.amber.shade400 : Colors.white12,
                ),
              ),
            );
          }).toList(),
        ),

        SizedBox(height: 2.h),

        // 4. Optional query input
        Text(
          'कोई विशेष सवाल? (Optional Query Context)',
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 13.5.sp,
          ),
        ),
        SizedBox(height: 0.8.h),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFF1B3524),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: Colors.white12),
          ),
          child: TextField(
            controller: _queryCtrl,
            maxLines: 2,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'उदा: आज खाटूश्यामजी मंडी में जौ का क्या रेट चल रहा है?',
              hintStyle: TextStyle(color: Colors.white38, fontSize: 13),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12),
            ),
          ),
        ),

        SizedBox(height: 3.h),

        // 5. Submit Button (Call Me Now)
        ElevatedButton(
          onPressed: _isCalling ? null : _handleInitiateCall,
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorConstant.maingreen,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: Colors.amber, width: 1.2),
            ),
            elevation: 6,
          ),
          child: _isCalling
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Colors.amber,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    Text(
                      'कॉल कनेक्ट हो रही है...',
                      style: GoogleFonts.poppins(fontSize: 15.sp, fontWeight: FontWeight.bold),
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.phone_forwarded_rounded, color: Colors.amber),
                    SizedBox(width: 2.5.w),
                    Text(
                      'तुरंत AI कॉल करवाएं (Call Me Now)',
                      style: GoogleFonts.poppins(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
        ),

        SizedBox(height: 1.5.h),

        // Direct Call Fallback
        TextButton.icon(
          onPressed: _directCallSupport,
          icon: const Icon(Icons.support_agent_rounded, color: Colors.amber, size: 20),
          label: Text(
            'सीधे हमारे हेल्पलाइन नंबर पर कॉल करें',
            style: GoogleFonts.poppins(
              color: Colors.amber.shade200,
              fontSize: 13.5.sp,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCallActiveView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1B3524),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.4)),
          ),
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _pulseCtrl,
                builder: (context, child) {
                  return Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: ColorConstant.maingreen,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.greenAccent.withValues(alpha: 0.4 * _pulseCtrl.value),
                          blurRadius: 24 * _pulseCtrl.value,
                          spreadRadius: 4 * _pulseCtrl.value,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.ring_volume_rounded,
                      color: Colors.amber,
                      size: 40,
                    ),
                  );
                },
              ),
              SizedBox(height: 2.h),
              Text(
                'कॉल आपके फोन पर आ रही है!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.amber.shade300,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                _statusMessage ?? 'कृपया अपना फोन उठाएं और AI सहायक से बात करें।',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Colors.white70,
                  fontSize: 14.sp,
                ),
              ),
              if (_callSid != null) ...[
                SizedBox(height: 1.5.h),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Call ID: $_callSid',
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                ),
              ],
            ],
          ),
        ),

        SizedBox(height: 3.h),

        ElevatedButton(
          onPressed: () => Navigator.of(context).pop(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF275135),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
          ),
          child: Text(
            'ठीक है (Close)',
            style: GoogleFonts.poppins(fontSize: 15.sp, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
