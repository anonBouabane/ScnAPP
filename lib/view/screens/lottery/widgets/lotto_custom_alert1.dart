import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../util/images.dart';
import '../../../../util/styles.dart';

class LottoCustomAlert1 extends StatelessWidget {
  final String message;
  final bool isError;
  final bool isOkText;

  const LottoCustomAlert1({Key? key, required this.message, this.isError = false, this.isOkText = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: const EdgeInsets.only(top: 10.0),
      content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              isError ? Image.asset(Images.cloudDisconnected, color: Colors.red) : Icon(Icons.info_outline, size: 60, color: Colors.grey),
              SizedBox(height: 10),
              Text(message, style: robotoRegular),
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
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.red.shade500,
                            borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8.0), bottomLeft: Radius.circular(8.0)),
                          ),
                          child: Text(
                            isOkText ? 'ok'.tr : 'close'.tr,
                            style: robotoRegular.copyWith(fontSize: 18, color: Colors.white),
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
