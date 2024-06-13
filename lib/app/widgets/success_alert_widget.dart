import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../util/textStyle.dart';
import '../../view/base/fade_animation.dart';
import '../languages/translates.dart';

class SuccessAlertWidget extends StatelessWidget {
  const SuccessAlertWidget({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      0.1,
      Container(
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          contentPadding: const EdgeInsets.only(top: 10.0),
          content: SizedBox(
            height: 270,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: FadeAnimation(
                    0.2,
                    ClipOval(
                      child: Icon(
                        Icons.check_circle,
                        size: 100,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Center(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text(
                            Translates.SUCCESS.tr,
                            style: OptionTextStyle().optionStyle(
                                20, Colors.red.shade900, FontWeight.bold),
                          ),
                          Text(
                            message,
                            style: OptionTextStyle()
                                .optionStyle(14, null, FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade800,
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(32.0),
                        bottomRight: Radius.circular(32.0),
                      ),
                    ),
                    child: Text(
                      Translates.BUTTON_OK.tr,
                      style: OptionTextStyle()
                          .optionStyle(null, Colors.white, FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
