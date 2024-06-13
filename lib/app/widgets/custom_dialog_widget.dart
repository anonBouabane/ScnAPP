import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/util/dimensions.dart';

import '../../../../util/styles.dart';

class CustomDialogWidget extends StatelessWidget {
  final String? title;
  final String? message;
  final String? buttonText;

  const CustomDialogWidget(
      {Key? key, this.title, this.message, this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),
      contentPadding: const EdgeInsets.only(top: 10.0),
      content: SizedBox(
          width: Get.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.toString(),
                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                message.toString(),
                style: robotoRegular,
              ),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.red.shade500,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            buttonText.toString(),
                            style: robotoRegular.copyWith(
                                fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}
