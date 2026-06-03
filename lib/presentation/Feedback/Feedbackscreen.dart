import 'package:apnagodam/auth_provider/AuthProvider.dart';
import 'package:apnagodam/core/utils/SharedPrefs/SharedUtility.dart';
import 'package:apnagodam/extensions/extensions.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_impl/service/my_stock_impl.dart';
import 'package:apnagodam/presentation/my_Stock/my_stock_screen.dart';
import 'package:apnagodam/widgets/CommonTextField.dart';
import 'package:apnagodam/widgets/DioInterceptor.dart';
import 'package:apnagodam/widgets/widgets.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:apnagodam/l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final feedbackTextProvider = StateProvider<String>((ref) => '');
final feedbackRatingProvider = StateProvider<int>((ref) => 0);

class FeedbackScreen extends ConsumerWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final feedback = ref.watch(feedbackTextProvider);
    final rating = ref.watch(feedbackRatingProvider);

    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.feedback)),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ref.watch(authProvider).when(
            data: (data) => data == AuthStatus.loggedOut
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset('assets/images/mainlogopng.png',
                            height: 150, width: 150),
                        simpleButton(
                            text: AppLocalizations.of(context)!
                                .loginToProvideFeedback,
                            callback: () {
                              showLoginBottomsheet(context);
                            }),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      Text(
                        AppLocalizations.of(context)!.pleaseRateYourExperienceWithApnaGodam2,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          final selected = index < rating;
                          return IconButton(
                            icon: Icon(
                              selected ? Icons.star : Icons.star_border,
                              color: selected ? Colors.amber : Colors.grey,
                              size: 32,
                            ),
                            onPressed: () {
                              ref.read(feedbackRatingProvider.notifier).state =
                                  index + 1;
                            },
                          );
                        }),
                      ),
                      SizedBox(height: 24),
                      CommonTextField(
                        maxLines: 5,
                        label: AppLocalizations.of(context)!.yourFeedback,
                        hintText:
                            AppLocalizations.of(context)!.letUsKnowYourThoughts,
                        onEditComplete: (value) {
                          debouncer.call(() {
                            ref.read(feedbackTextProvider.notifier).state =
                                value;
                          });
                        },
                      ),
                      SizedBox(height: 24),
                      simpleButton(
                          text: AppLocalizations.of(context)!.submitFeedback2,
                          callback: () async {
                            if (rating == 0 || feedback.trim().isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        AppLocalizations.of(context)!.pleaseProvideRatingAndFeedback2)),
                              );
                            } else {
                              Dio dio = Dio(BaseOptions(
                                  baseUrl: _getBaseUrl(ref),
                                  connectTimeout: Duration(minutes: 10),
                                  sendTimeout: Duration(minutes: 10),
                                  receiveTimeout: Duration(minutes: 10)))
                                ..interceptors.addAll([PrettyDioLogger()]);

                              var response = await dio.post('feedback', data: {
                                "rating": ref.watch(feedbackRatingProvider),
                                "feedback": ref.watch(feedbackTextProvider),
                                "userName": ref
                                    .watch(sharedUtilityProvider)
                                    .getUser()
                                    ?.firmName,
                                "phone": ref
                                    .watch(sharedUtilityProvider)
                                    .getUser()
                                    ?.phone,
                                "userId": ref
                                    .watch(sharedUtilityProvider)
                                    .getUser()
                                    ?.id
                              });

                              if (response.data['success']) {
                                context.successToast(
                                    response.data['message'].toString());
                                ref.invalidate(feedbackTextProvider);
                                ref.invalidate(feedbackRatingProvider);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          AppLocalizations.of(context)!.thankYouForYourFeedback2)),
                                );
                                Get.back(canPop: true);
                              } else {
                                context.errorToast(
                                    response.data['message'].toString());
                              }
                            }
                          }),
                    ],
                  ),
            error: (e, s) => Container(),
            loading: () => Container()),
      ),
    );
  }

  String _getBaseUrl(WidgetRef ref) {
    final url = ref.watch(dioProvider).options.baseUrl.toLowerCase();
    if (url.contains('test') || url.contains('demo')) {
      return 'https://swlpl-next.vercel.app/api/';
    } else {
      return 'https://swlpl-next.vercel.app/api/';
    }
  }
}
