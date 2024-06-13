import 'package:app_version_update/app_version_update.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:scn_easy/app/modules/contact_us/contact_us_view.dart';
import 'package:scn_easy/app/modules/notification/notification_view.dart';
import 'package:scn_easy/app/modules/profile/profile_view.dart';
import 'package:scn_easy/generated/assets.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/app_constants.dart';
import 'package:scn_easy/view/base/image_picker.dart';
import 'package:scn_easy/view/base/permission_dialog.dart';
import 'package:scn_easy/view/screens/auth/signin_screen.dart';
import 'package:scn_easy/view/screens/lottery/widgets/top_navigation_item.dart';
import 'package:scn_easy/view/screens/policy/scn_policy.dart';

import '../../../controller/auth_controller.dart';
import '../../../controller/lottery_controller.dart';
import '../../../controller/user_controller.dart';
import '../../../util/dimensions.dart';
import '../../../util/images.dart';
import '../../../util/styles.dart';
import '../../base/message_alert_message.dart';
import 'lotto_main.dart';
import 'reward_point/lotto_reward_and_point_main.dart';
import 'widgets/lotto_change_referral_number.dart';

class LotteryMainPage extends StatefulWidget {
  LotteryMainPage({Key? key}) : super(key: key);

  @override
  _LotteryMainPageState createState() => _LotteryMainPageState();
}

class _LotteryMainPageState extends State<LotteryMainPage> {
  String policyContent = "";
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    // if (kReleaseMode) {
    getUpdate();
    checkNotificationPermission();
    // }

    Get.find<UserController>().getUserInfo();

    Get.find<LotteryController>()
        .getBonusPointReferral(Get.find<AuthController>().getUserNumber());
  }

  getUpdate() async {
    final appleId =
        '1613030945'; // If this value is null, its package name will be considered
    final playStoreId =
        'com.sit.scng_app'; // If this value is null, its package name will be considered
    final country = 'la'; // default is 'us'
    await AppVersionUpdate.checkForUpdates(
      appleId: appleId,
      playStoreId: playStoreId,
      country: country,
    ).then((data) async {
      if (kDebugMode) {
        Logger().i(
            'StoreUrl: ${data.storeUrl}\nStoreVersion: ${data.storeVersion}');
      }

      if (data.canUpdate!) {
        AppVersionUpdate.showAlertUpdate(
          appVersionResult: data,
          context: context,
          mandatory: true,
          title: 'new_version_available'.tr,
          content: 'you_must_update_the_app_to_use_new_feature'.tr,
          contentTextStyle: robotoMedium,
          updateButtonText: 'update'.tr,
          titleTextStyle: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeExtraLarge,
          ),
        );
      }
    });
  }

  checkNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (kDebugMode) {
      Logger().i('=====> Permission status: ${settings.authorizationStatus}');
    }

    if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      showDialog(
          context: Get.context!, builder: (context) => PermissionDialog());
    } else if (settings.authorizationStatus == AuthorizationStatus.denied) {
      showDialog(
          context: Get.context!, builder: (context) => PermissionDialog());
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.notDetermined) {
      showDialog(
          context: Get.context!, builder: (context) => PermissionDialog());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Image(
              image: AssetImage(Images.scnBackgroundPng),
              fit: BoxFit.fill,
              height: Get.height,
              width: Get.width,
            ),
            Container(
                child: GetBuilder<UserController>(
              builder: (userCtrl) =>
                  GetBuilder<LotteryController>(builder: (lotCtrl) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: 45,
                        padding: EdgeInsets.only(left: 8, right: 8),
                        decoration: BoxDecoration(color: Colors.white),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Row(
                                children: [
                                  ImagePickerWidget(
                                    image:
                                        '${AppConstants.BASE_URL}/${userCtrl.userInfoModel.image}',
                                    onTap: () => userCtrl.pickImage(),
                                    rawFile: userCtrl.rawFile,
                                  ),
                                  Gap(4),
                                  Flexible(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${userCtrl.userInfoModel.firstname ?? "User"} ${userCtrl.userInfoModel.lastname ?? "name"}",
                                          style: robotoBold.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Text(
                                              "ສະຖານະ: ".tr,
                                              style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeExtraSmall),
                                            ),
                                            Text(
                                              "ຢືນຢັນຕົວຕົນແລ້ວ".tr,
                                              style: robotoBold.copyWith(
                                                color: Colors.green.shade700,
                                                fontSize: Dimensions
                                                    .fontSizeExtraSmall,
                                              ),
                                            ),
                                            Icon(
                                              Icons.check_circle,
                                              color: Colors.green.shade700,
                                              size: Dimensions.fontSizeLarge,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  // Wrap(
                                  //   direction: Axis.horizontal,
                                  //   children: [
                                  //     ImagePickerWidget(
                                  //       image:
                                  //           '${AppConstants.BASE_URL}/${userCtrl.userInfoModel.image}',
                                  //       onTap: () => userCtrl.pickImage(),
                                  //       rawFile: userCtrl.rawFile,
                                  //     ),
                                  //     Gap(4),
                                  //
                                  //     Wrap(
                                  //       direction: Axis.vertical,
                                  //       spacing: -5,
                                  //       children: [
                                  //         Text(
                                  //           // userCtrl.userInfoModel != null ?
                                  //           "${userCtrl.userInfoModel.firstname ?? "User"} ${userCtrl.userInfoModel.lastname ?? "name"}",
                                  //           // : "",
                                  //           style: robotoBold.copyWith(
                                  //               fontSize:
                                  //                   Dimensions.fontSizeSmall),
                                  //           overflow: TextOverflow.ellipsis,
                                  //         ),
                                  //         Row(
                                  //           crossAxisAlignment:
                                  //               CrossAxisAlignment.center,
                                  //           mainAxisAlignment:
                                  //               MainAxisAlignment.center,
                                  //           children: [
                                  //             Text(
                                  //               "ສະຖານະ: ".tr,
                                  //               style: robotoBold.copyWith(
                                  //                   fontSize: Dimensions
                                  //                       .fontSizeExtraSmall),
                                  //             ),
                                  //             Text(
                                  //               "ຢືນຢັນຕົວຕົນແລ້ວ".tr,
                                  //               style: robotoBold.copyWith(
                                  //                 color: Colors.green.shade700,
                                  //                 fontSize: Dimensions
                                  //                     .fontSizeExtraSmall,
                                  //               ),
                                  //             ),
                                  //             Icon(
                                  //               Icons.check_circle,
                                  //               color: Colors.green.shade700,
                                  //               size: Dimensions.fontSizeLarge,
                                  //             ),
                                  //           ],
                                  //         )
                                  //       ],
                                  //     )
                                  //   ],
                                  // ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                /// --- profile --- //
                                TopNavigationItem(
                                  showImageNormal:
                                      Assets.imagesMainButtonProfileNormal,
                                  onTap: () async {
                                    await Get.to(() => ProfileView());
                                    Get.find<UserController>().getUserInfo();
                                  },
                                ),
                                Gap(4),

                                /// --- dashboard --- //
                                TopNavigationItem(
                                  showImageNormal:
                                      Assets.imagesMainButtonDashboardSelected,
                                  onTap: () => null,
                                ),
                                Gap(4),

                                /// --- contact us --- //
                                TopNavigationItem(
                                  showImageNormal:
                                      Assets.imagesMainButtonContactNormal,
                                  onTap: () => Get.to(() => ContactUsView()),
                                ),
                                Gap(4),

                                /// --- notification --- //
                                InkWell(
                                  onTap: () async {
                                    Get.to(() => NotificationScreen());
                                    // openAppSettings();
                                  },
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          Assets.imagesMainButtonNotification,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),

                                /// --- notification --- //
                                // InkWell(
                                //   onTap: () async {
                                //     Get.to(() => NotificationScreen());
                                //     // openAppSettings();
                                //   },
                                //   child: Icon(
                                //     Icons.notifications_none,
                                //     size: 30,
                                //     weight: 10,
                                //     color: Colors.black54,
                                //   ),
                                // ),
                                Gap(4),

                                /// --- exit app --- //
                                InkWell(
                                  onTap: () async {
                                    var remove = Get.find<AuthController>()
                                        .clearSharedData();
                                    if (remove) {
                                      Get.offAll(() => SignInScreen());
                                      // if (Platform.isIOS) {
                                      //   try {
                                      //     Logger().d('exit app');
                                      //     SystemChannels.platform.invokeMethod(
                                      //         'SystemNavigator.pop');
                                      //   } catch (e) {
                                      //     Logger().d('app terminate');
                                      //     exit(0);
                                      //   }
                                      // } else {
                                      //   try {
                                      //     exit(0);
                                      //   } catch (e) {
                                      //     SystemChannels.platform.invokeMethod(
                                      //         'SystemNavigator.pop');
                                      //   }
                                      // }
                                    }
                                  },
                                  // child: Icon(
                                  //   Icons.power_settings_new_outlined,
                                  //   size: 30,
                                  //   weight: 10,
                                  //   color: Colors.black54,
                                  // ),
                                  child: Container(
                                    width: 32,
                                    height: 32,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                          Assets.imagesMainButtonSignOut,
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                          top: 20,
                          left: 8,
                          right: 8,
                          bottom: 20,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              Images.logo,
                              height: 75,
                              width: 65,
                              fit: BoxFit.fill,
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Container(
                                height: 56,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(Images.pointBar),
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Row(
                                    children: [
                                      // SizedBox(width: 15),
                                      // Text("point_collection".tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                      SizedBox(width: 5),
                                      Image.asset(
                                        Images.scnPoint,
                                        height: 20,
                                        width: 20,
                                      ),
                                      SizedBox(width: 5),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 4.0),
                                        child: Text(
                                          "${lotCtrl.bprModel != null ? PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.bprModel!.point.toString())) : 0}",
                                          style: robotoBold.copyWith(
                                            fontSize: Dimensions.fontSizeSmall,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        " ${"points".tr}",
                                        style: robotoBold.copyWith(
                                          fontSize: Dimensions.fontSizeSmall,
                                        ),
                                      ),
                                      // Padding(
                                      //   padding: const EdgeInsets.only(left: 10),
                                      //   child: Wrap(
                                      //     direction: Axis.horizontal,
                                      //     children: [
                                      //Text("point_collection".tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                      // Text("point_collection".tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                      // SizedBox(width: 5),
                                      // Image.asset(Images.scnPoint, height: 20, width: 20),
                                      // SizedBox(width: 5),
                                      // Text("230.000.000.000.000.000.000.000", style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                                      // maxLines: 1,
                                      //   softWrap: true,
                                      //   overflow: TextOverflow.ellipsis,
                                      // ),
                                      // Text("points".tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                      // Text.rich(
                                      //   TextSpan(
                                      //     children: <InlineSpan>[
                                      //       TextSpan(
                                      //         // text: "230.000.000.000.000.000.000.000",
                                      //         text: "${lotCtrl.bprModel != null ? PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.bprModel!.point.toString())) : 0}",
                                      //         style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                                      //       ),
                                      //       TextSpan(text: ' ${'points'.tr}', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall))
                                      //     ],
                                      //   ),
                                      // ),
                                      // Row(
                                      //   crossAxisAlignment: CrossAxisAlignment.center,
                                      //   mainAxisAlignment: MainAxisAlignment.center,
                                      //   children: [
                                      //     Text("point_collection".tr, style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall)),
                                      //     SizedBox(width: 5),
                                      //     Image.asset(Images.scnPoint, height: 20, width: 20),
                                      //     SizedBox(width: 5),
                                      //
                                      //     Padding(
                                      //       padding: const EdgeInsets.only(top: 4.0),
                                      //       child: Text.rich(
                                      //         TextSpan(
                                      //           children: <InlineSpan>[
                                      //             TextSpan(
                                      //               // text: "230.000.000.000\n.000.000.000.000",
                                      //               text: "${lotCtrl.bprModel != null ? PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.bprModel!.point.toString())) : 0}",
                                      //               style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall),
                                      //             ),
                                      //             TextSpan(text: ' ${'points'.tr}', style: robotoBold.copyWith(fontSize: Dimensions.fontSizeSmall))
                                      //           ],
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                      //     ],
                                      //   ),
                                      // ),
                                      Spacer(),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => LottoRewardAndPointMain(
                                              fromViewPoint: true));
                                        },
                                        child: Container(
                                          height: 30,
                                          width: 80,
                                          margin: EdgeInsets.only(
                                            left: 8,
                                            right: 8,
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(5)),
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                Color(0xffdf0000),
                                                Color(0xffc00303)
                                              ],
                                            ),
                                            // image: DecorationImage(
                                            //   image: AssetImage(Images.viewConditionBtn),
                                            //   fit: BoxFit.fill,
                                            // ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'ເບິ່ງຄະແນນ',
                                              style: robotoRegular.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 170,
                        width: Get.width,
                        margin: EdgeInsets.only(
                          top: 3,
                          left: 8,
                          right: 8,
                          bottom: 20,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: AssetImage(Images.introFriends),
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "referral_content".tr,
                              style: robotoBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 6),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.center,
                              // crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 90,
                                  padding: EdgeInsets.only(left: 10),
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "ເລກແນະນຳທ່ານ",
                                      style: robotoBold.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                                // Wrap(runSpacing: -8, children: [
                                //   Center(child: Text("ເລກແນະນຳ", style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault))),
                                //   Center(child: Text("ຂອງທ່ານ", style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault))),
                                // ])),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: InkWell(
                                      onTap: () async {
                                        if (lotCtrl.bprModel != null) {
                                          await Clipboard.setData(
                                            ClipboardData(
                                              text:
                                                  '${lotCtrl.bprModel!.referralCode}',
                                            ),
                                          );
                                          if (Get.isSnackbarOpen) {
                                            Get.back();
                                          }
                                          Get.snackbar(
                                            'ເລກແນະນໍາ',
                                            'Copy ເລກແນະນໍາແລ້ວ',
                                            snackPosition: SnackPosition.BOTTOM,
                                          );
                                          // ScaffoldMessenger.of(context)
                                          //     .showSnackBar(
                                          //   SnackBar(
                                          //     content: Text(
                                          //       "Referral Code copied to clipboard",
                                          //     ),
                                          //   ),
                                          // );
                                        }
                                      },
                                      child: Container(
                                        height: 40,
                                        padding: EdgeInsets.only(top: 4),
                                        // width: MediaQuery.of(context).size.width / 1.7,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          image: DecorationImage(
                                            image:
                                                AssetImage(Images.referralCode),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          "${lotCtrl.bprModel != null ? lotCtrl.bprModel!.referralCode : ""}",
                                          style: robotoBold.copyWith(
                                            color: Colors.white,
                                            fontSize: Dimensions.fontSizeLarge,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 10),
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => LottoRewardAndPointMain());
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 110,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(5),
                                        ),
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color(0xffdf0000),
                                            Color(0xffc00303)
                                          ],
                                        ),
                                      ),
                                      // decoration: BoxDecoration(
                                      //   borderRadius: BorderRadius.circular(3),
                                      //   color: Colors.redAccent.shade700,
                                      // ),
                                      child: Center(
                                          child: Text(
                                        "ເບິ່ງລາຍຮັບ".tr,
                                        style: robotoBold.copyWith(
                                          fontSize: Dimensions.fontSizeLarge,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            lotCtrl.lottoRewardIdResponse?.rewardId == null
                                ? GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        barrierDismissible: false,
                                        context: context,
                                        builder: (context) =>
                                            LottoChangeReferralNumber(),
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 90,
                                          padding: EdgeInsets.only(left: 15),
                                          child: Center(
                                            child: Align(
                                              alignment: Alignment.centerRight,
                                              child: Text(
                                                "ໃສ່ເລກແນະນຳ".tr,
                                                style: robotoBold.copyWith(
                                                  fontSize: Dimensions
                                                      .fontSizeDefault,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Container(
                                            margin: EdgeInsets.only(
                                                left: 18, right: 10),
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image:
                                                    AssetImage(Images.inputBg),
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            height: 45,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Row(
                                    children: [
                                      Container(
                                        width: 90,
                                        padding: EdgeInsets.only(left: 10),
                                        child: Align(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "ເລກຜູ້ທີ່ແນະນຳ",
                                            style: robotoBold.copyWith(
                                              fontSize:
                                                  Dimensions.fontSizeDefault,
                                              letterSpacing: 0.2,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          margin: EdgeInsets.only(
                                            left: 18,
                                            right: 10,
                                          ),
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            image: DecorationImage(
                                              image: AssetImage(
                                                  Images.referralCode),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                          child: Center(
                                              child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 4.0),
                                                child: Text(
                                                  "${lotCtrl.lottoRewardIdResponse!.rewardId.toString()}",
                                                  style: robotoBold.copyWith(
                                                    color: Colors.white,
                                                    fontSize: Dimensions
                                                        .fontSizeLarge,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ],
                                          )),
                                        ),
                                      ),
                                    ],
                                  ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Image.asset(Images.lottery,
                                    width: double.infinity,
                                    height: double.infinity,
                                    fit: BoxFit.fill),
                                iconSize: context.isTablet ? 270 : 170.0,
                                onPressed: () async {
                                  await Get.to(() => LottoMain());
                                  Get.find<UserController>().getUserInfo();
                                },
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: Image.asset(
                                  Images.scnFiLogo,
                                  width: double.infinity,
                                  height: double.infinity,
                                  fit: BoxFit.fill,
                                ),
                                iconSize: context.isTablet ? 270 : 170.0,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => MessageAlertMsg(
                                      'error',
                                      "Coming soon...",
                                      Icons.error_outline,
                                      Colors.red,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white54, // background
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onPressed: () {
                          Get.to(() => PolicyScreen());
                        },
                        child: Text(
                          'scn_group_policy'.tr,
                          style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeDefault,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            )),
          ],
        ),
      ),
    );
  }
}
