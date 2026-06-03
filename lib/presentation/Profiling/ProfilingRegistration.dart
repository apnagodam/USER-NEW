import 'package:apnagodam/core/utils/color_constant.dart';
import 'package:apnagodam/core/utils/image_constant.dart';
import 'package:apnagodam/presentation/BusinessProfile/BusinessProfile.dart';
import 'package:apnagodam/presentation/GstProfile/GstProfileScreen.dart';
import 'package:apnagodam/presentation/MandiTaxProfile/MandiTaxProfileScreen.dart';
import 'package:apnagodam/presentation/home_screen/kyc.dart';
import 'package:assorted_layout_widgets/assorted_layout_widgets.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_onboarding_slider/flutter_onboarding_slider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';

class Profilingregistration extends ConsumerStatefulWidget {
  const Profilingregistration({super.key});

  @override
  ConsumerState<Profilingregistration> createState() =>
      _ProfilingregistrationState();
}

class _ProfilingregistrationState extends ConsumerState<Profilingregistration> {
  final PageController _pageController = PageController();
  final currentIndexProvider = StateProvider((ref) => 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Complete your profile')),
      body: Column(
        children: [
          EasyStepper(
            activeStep: ref.watch(currentIndexProvider),
            stepShape: StepShape.rRectangle,
            stepBorderRadius: 15,
            borderThickness: 2,
            padding: Pad(all: 0),
            stepRadius: 28,
            finishedStepBorderColor: ColorConstant.maingreen,
            finishedStepTextColor: ColorConstant.maingreen,
            finishedStepBackgroundColor: ColorConstant.maingreen,
            activeStepIconColor: ColorConstant.maingreen,
            showLoadingAnimation: false,
            steps: [
              EasyStep(
                customStep: ClipOval(
                  child: Opacity(
                    opacity: ref.watch(currentIndexProvider) >= 0 ? 1 : 0.3,
                    child: SvgPicture.asset(
                      ImageConstant.mandiTax,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
                customTitle: const Text(
                  'Mandi Tax Profile',
                  textAlign: TextAlign.center,
                ),
              ),
              EasyStep(
                customStep: ClipOval(
                  child: Opacity(
                    opacity: ref.watch(currentIndexProvider) >= 1 ? 1 : 0.3,
                    child: Icon(Icons.person),
                  ),
                ),
                customTitle: const Text(
                  'Gst Profile',
                  textAlign: TextAlign.center,
                ),
              ),
              EasyStep(
                customStep: ClipOval(
                  child: Opacity(
                    opacity: ref.watch(currentIndexProvider) >= 2 ? 1 : 0.3,
                    child: Icon(Icons.person),
                  ),
                ),
                customTitle: const Text(
                  'Business Profile',
                  textAlign: TextAlign.center,
                ),
              ),
            ],
            onStepReached: (index) {
              ref.watch(currentIndexProvider.notifier).state = index;
              _pageController.animateToPage(
                index,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeIn,
              );
            },
          ),
          Expanded(
            child: Padding(
              padding: Pad(top: 10),
              child: PageView(
                pageSnapping: true,
                controller: _pageController,
                onPageChanged: (index) {
                  ref.watch(currentIndexProvider.notifier).state = index;
                },
                children: [
                  Manditaxprofilescreen(isAppbarVisible: false),
                  Gstprofilescreen(isAppbarVisible: false),
                  Businessprofile(isAppbarVisible: false),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
