import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controller/localization_controller.dart';
import '../../../util/textStyle.dart';
import '../../base/fade_animation.dart';

class LanguagePickerWidget extends StatelessWidget {
  const LanguagePickerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      0.1,
      AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32.0))),
          content: GetBuilder<LocalizationController>(
              builder: (localizationController) {
            return SizedBox(
              height: 250.0,
              child: Column(
                children: [
                  Expanded(
                    child: Text(
                      localizationController.locale == Locale('en', 'US')
                          ? '🇬🇧'
                          : '🇱🇦',
                      style: OptionTextStyle().optionStyle(100, null, null),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          localizationController.locale == const Locale('en')
                              ? 'selectLanguage'.tr
                              : 'selectLanguage'.tr,
                          style: OptionTextStyle().optionStyle(
                              18, Colors.orange.shade900, FontWeight.bold),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton.icon(
                                label: Text('English ',
                                    style: OptionTextStyle().optionStyle(
                                        null, null, FontWeight.bold)),
                                onPressed: () {
                                  // appLanguage.changeLanguage(const Locale("en"));
                                  localizationController
                                      .setLanguage(Locale("en", "US"));
                                  Navigator.pop(context);
                                },
                                icon: Image.asset(
                                  'assets/images/flag_en.png',
                                  width: 36,
                                  height: 36,
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TextButton.icon(
                                label: Text(
                                  'ພາສາລາວ',
                                  style: OptionTextStyle()
                                      .optionStyle(null, null, FontWeight.bold),
                                ),
                                onPressed: () {
                                  localizationController
                                      .setLanguage(Locale("lo", "LA"));
                                  Navigator.pop(context);
                                },
                                icon: Image.asset(
                                  'assets/images/flag_la.png',
                                  width: 36,
                                  height: 36,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          })),
    );
  }
}
