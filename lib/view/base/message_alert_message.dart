import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/languages/translates.dart';
import 'package:scn_easy/util/textStyle.dart';

import 'fade_animation.dart';

class MessageAlertMsg extends StatelessWidget {
  const MessageAlertMsg(this.title, this.msg, this.ico, this.icoColor);

  final String title;
  final String msg;
  final IconData ico;
  final Color icoColor;

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
            height: 270.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: FadeAnimation(
                    0.2,
                    ClipOval(
                      child: Icon(ico, size: 100, color: icoColor),
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
                            title.tr,
                            style: OptionTextStyle().optionStyle(
                                20, Colors.red.shade900, FontWeight.bold),
                          ),
                          Text(
                            msg.tr,
                            style: OptionTextStyle()
                                .optionStyle(14, null, FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop(false);
                  },
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
