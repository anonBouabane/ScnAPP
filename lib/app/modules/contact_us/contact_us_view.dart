import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/modules/contact_us/contact_us_controller.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/images.dart';
import 'package:scn_easy/util/styles.dart';

class ContactUsView extends StatelessWidget {
  const ContactUsView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(
      init: ContactUsController(),
      builder: (controller) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text('ຕິດຕໍ່ພວກເຮົາ'),
            centerTitle: true,
            backgroundColor: Colors.redAccent.shade700,
          ),
          body: SafeArea(
            child: Stack(
              children: [
                Image(
                  image: AssetImage(Images.scnBackgroundPng),
                  fit: BoxFit.fill,
                  width: Get.width,
                  height: Get.height,
                ),
                SingleChildScrollView(
                  child: controller.obx(
                    (state) {
                      return Column(
                        children: [
                          const SizedBox(height: 20),
                          Image.asset(
                            Images.logo,
                            height: 160,
                            width: 150,
                            fit: BoxFit.fill,
                          ),
                          const SizedBox(height: 30),
                          Container(
                            width: Get.width,
                            padding: EdgeInsets.only(top: 10, bottom: 10),
                            margin: EdgeInsets.only(left: 16.0, right: 16),
                            decoration: BoxDecoration(
                              color: Colors.red.shade800,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(32.0),
                                topRight: Radius.circular(32.0),
                              ),
                            ),
                            child: Text(
                              "ຕິດຕໍ່ພວກເຮົາ",
                              style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeOverLarge,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 16.0, right: 16),
                            padding: EdgeInsets.only(bottom: 25),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage(Images.scnBackgroundPng),
                                fit: BoxFit.fill,
                              ),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(23),
                                bottomRight: Radius.circular(23),
                              ),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  height: 70,
                                  margin: EdgeInsets.only(
                                    top: 20,
                                    right: 6,
                                    left: 6,
                                  ),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Images.inputBg),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(Images.contactHomeIcon),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          state?.address ??
                                              'ບ. ດອນກອຍ ມ. ສີສັດຕະນາກ ຂ. ນະຄອນຫຼວງວຽງຈັນ',
                                          style: robotoBold.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeDefault,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 2,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // const Divider(height: 20, thickness: 1.5),
                                Container(
                                  height: 70,
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.only(
                                      top: 20, right: 6, left: 6),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Images.inputBg),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(Images.contactPhoneIcon),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () => controller
                                                .hasCallSupport.value
                                            ? controller.makePhoneCall(
                                                '+856${state?.tel?.replaceAll(' ', '')}')
                                            : null,
                                        child: Text(
                                          state?.tel ?? '020 57281248',
                                          style: robotoBold.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeDefault,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 70,
                                  margin: EdgeInsets.only(
                                      top: 20, right: 6, left: 6),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Images.inputBg),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(Images.contactFacebookIcon),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: InkWell(
                                          onTap: () =>
                                              controller.openFacebook(),
                                          child: Text(
                                            state?.fb ?? 'SCN Easy',
                                            style: robotoBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeDefault,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 70,
                                  margin: EdgeInsets.only(
                                      top: 20, right: 6, left: 6),
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(Images.inputBg),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.asset(Images.contactWhatsappIcon),
                                      const SizedBox(width: 10),
                                      InkWell(
                                        onTap: () => controller
                                                .hasCallSupport.value
                                            ? controller.makePhoneCall(
                                                '+856${state?.wa?.replaceAll(' ', '')}')
                                            : null,
                                        child: Text(
                                          state?.wa ?? '020 57281248',
                                          style: robotoBold.copyWith(
                                            fontSize:
                                                Dimensions.fontSizeDefault,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 100),
                        ],
                      );
                    },
                    onLoading: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.3,
                      ),
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    onEmpty: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.height * 0.3,
                      ),
                      child: const Center(child: Text("Data is Empty")),
                    ),
                    onError: (e) => Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.height * 0.3,
                        horizontal: 20,
                      ),
                      child: Center(
                        child: Text(
                          "$e",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
