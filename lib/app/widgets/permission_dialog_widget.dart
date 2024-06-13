import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scn_easy/util/dimensions.dart';

import '../../../../util/styles.dart';

class PermissionDialogWidget extends StatelessWidget {
  const PermissionDialogWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0))),
      contentPadding: const EdgeInsets.only(top: 10.0),
      content: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'ເປີດການແຈ້ງເຕືອນ',
                style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  'ກະລຸນາເປີດການແຈ້ງເຕືອນ ເພື່ອຮັບຂ່າວສານດີໆຈາກພວກເຮົາ.',
                  style: robotoRegular,
                ),
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
                            color: Colors.grey,
                            borderRadius: const BorderRadius.only(
                              // bottomRight: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'ບໍ່ເປີດ',
                            style: robotoRegular.copyWith(
                                fontSize: 18, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    // SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                          openAppSettings();
                        },
                        child: Container(
                          height: 50,
                          padding:
                              const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          decoration: BoxDecoration(
                            color: Colors.red.shade500,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(8.0),
                              // bottomLeft: Radius.circular(8.0),
                            ),
                          ),
                          child: Text(
                            'ເປີດ',
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
