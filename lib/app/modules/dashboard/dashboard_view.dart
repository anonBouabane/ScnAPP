import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/languages/translates.dart';
import 'package:scn_easy/app/routes/app_pages.dart';
import 'package:scn_easy/app/widgets/background_widget.dart';
import 'package:scn_easy/helper/price_converter.dart';

import '../../../generated/assets.dart';
import '../../../util/app_constants.dart';
import '../../../util/dimensions.dart';
import '../../../util/styles.dart';
import '../../../view/base/image_picker.dart';
import '../../../view/screens/lottery/widgets/top_navigation_item.dart';
import '../../widgets/error_alert_widget.dart';
import '../policy/policy_lottery_view.dart';
import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              BackgroundWidget(),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      height: 45,
                      padding: EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(color: Colors.white),
                      child: Row(
                        children: [
                          buildAppHeaderProfile(),
                          buildAppHeaderMenu(),
                        ],
                      ),
                    ),

                    /// Bonus --------
                    Container(
                      margin: EdgeInsets.only(
                        top: 20,
                        left: 8,
                        right: 8,
                        bottom: 20,
                      ),
                      child: buildBonusContent(),
                    ),

                    /// Referral -------
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
                          image: AssetImage(Assets.newDesignIntroFriends),
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            Translates.REFERRAL_CONTENT.tr,
                            style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeLarge,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 6),
                          buildUserReferral(),
                          const Gap(15),
                          controller.isRewardLoading.value
                              ? Center(
                                  child: SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : controller.rewardModel.value?.rewardId == null
                                  ? buildReferralUpdate()
                                  : buildReferralDefault(),
                        ],
                      ),
                    ),

                    /// Buy Lottery and Insurance -----
                    buildLotteryAndFinanceButton(),

                    const Gap(32),

                    /// Policy Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white54, // background
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Get.to(() => PolicyLotteryView());
                      },
                      child: Text(
                        Translates.BUTTON_TERM_AND_CONDITION.tr,
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget buildAppHeaderProfile() {
    return Expanded(
      flex: 3,
      child: Row(
        children: [
          ImagePickerWidget(
            image:
                '${AppConstants.BASE_URL}/${controller.userController.userInfoModel.image}',
            onTap: () {},
            rawFile: controller.userController.rawFile,
          ),
          Gap(4),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                controller.userController.isLoading
                    ? SizedBox(
                        width: 10,
                        height: 10,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(
                        '${controller.firstName.value} ${controller.lastName.value}',
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeSmall,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'ສະຖານະ: '.tr,
                      style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraSmall),
                    ),
                    Text(
                      'ຢືນຢັນຕົວຕົນແລ້ວ'.tr,
                      style: robotoBold.copyWith(
                        color: Colors.green.shade700,
                        fontSize: Dimensions.fontSizeExtraSmall,
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
        ],
      ),
    );
  }

  Widget buildAppHeaderMenu() {
    return Row(
      children: [
        /// --- profile --- //
        TopNavigationItem(
          showImageNormal: Assets.imagesMainButtonProfileNormal,
          onTap: () async {
            await Get.toNamed(Routes.USER_INFO);
            controller.userController.getUserInfo();
          },
        ),
        Gap(4),

        /// --- dashboard --- //
        TopNavigationItem(
          showImageNormal: Assets.imagesMainButtonDashboardSelected,
          onTap: () => null,
        ),
        Gap(4),

        /// --- contact us --- //
        TopNavigationItem(
          showImageNormal: Assets.imagesMainButtonContactNormal,
          onTap: () => Get.toNamed(Routes.CONTACT),
        ),
        Gap(4),

        /// --- notification --- //
        InkWell(
          onTap: () => Get.toNamed(Routes.NOTIFY),
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
        const Gap(4),

        /// --- exit app --- //
        InkWell(
          onTap: () => controller.logout(),
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
    );
  }

  Widget buildBonusContent() {
    return Row(
      children: [
        Image.asset(
          Assets.newDesignScnLogo,
          height: 70,
          width: 65,
          fit: BoxFit.fill,
        ),
        const Gap(10),
        Expanded(
          child: Container(
            height: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.newDesignPointBar),
                fit: BoxFit.fill,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  Gap(5),
                  Image.asset(
                    Assets.newDesignScnPoint,
                    height: 20,
                    width: 20,
                  ),
                  const Gap(5),
                  Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: controller.isBonusLoading.isTrue
                        ? Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          )
                        : Text(
                            '${PriceConverter.convertPriceNoCurrency(double.parse(controller.bonusReferralModel.value!.point.toString()))}',
                            style: robotoBold.copyWith(
                              fontSize: Dimensions.fontSizeSmall,
                            ),
                          ),
                  ),
                  const Gap(5),
                  Text(
                    Translates.POINTS.tr,
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeSmall,
                    ),
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: () => Get.toNamed(Routes.REWARD_POINT, arguments: 1),
                    child: Container(
                      height: 30,
                      width: 80,
                      margin: EdgeInsets.only(
                        left: 8,
                        right: 8,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(5),
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xffdf0000), Color(0xffc00303)],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          Translates.BUTTON_VIEW_POINT.tr,
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
    );
  }

  Widget buildUserReferral() {
    return Row(
      children: [
        Container(
          width: 90,
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'ເລກແນະນຳທ່ານ',
              style: robotoBold.copyWith(
                fontSize: Dimensions.fontSizeDefault,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: InkWell(
              onTap: () async {
                if (controller.isBonusLoading.isFalse) {
                  await Clipboard.setData(
                    ClipboardData(
                      text:
                          '${controller.bonusReferralModel.value!.referralCode}',
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
                }
              },
              child: Container(
                height: 40,
                padding: EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3),
                  image: DecorationImage(
                    image: AssetImage(Assets.newDesignReferalCode),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Center(
                  child: controller.isBonusLoading.value
                      ? SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          '${controller.bonusReferralModel.value!.referralCode}',
                          style: robotoBold.copyWith(
                            color: Colors.white,
                            fontSize: Dimensions.fontSizeLarge,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 10),
          child: GestureDetector(
            onTap: () => Get.toNamed(Routes.REWARD_POINT, arguments: 0),
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
                  colors: [Color(0xffdf0000), Color(0xffc00303)],
                ),
              ),
              child: Center(
                  child: Text(
                'ເບິ່ງລາຍຮັບ'.tr,
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
    );
  }

  Widget buildReferralUpdate() {
    return GestureDetector(
      onTap: () async {
        final result = await Get.toNamed(Routes.REFERRAL);
        if (result != null && result) {
          await controller.userController.getUserInfo();
          await controller.loadReward();
        }
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
                  'ໃສ່ເລກແນະນຳ'.tr,
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 18, right: 10),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(Assets.newDesignInputBg),
                  fit: BoxFit.fill,
                ),
              ),
              height: 45,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildReferralDefault() {
    return Row(
      children: [
        Container(
          width: 90,
          padding: EdgeInsets.only(left: 10),
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              'ເລກຜູ້ທີ່ແນະນຳ',
              style: robotoBold.copyWith(
                fontSize: Dimensions.fontSizeDefault,
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
              borderRadius: BorderRadius.circular(3),
              image: DecorationImage(
                image: AssetImage(Assets.newDesignReferalCode),
                fit: BoxFit.fill,
              ),
            ),
            child: Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    '${controller.rewardModel.value!.rewardId}',
                    style: robotoBold.copyWith(
                      color: Colors.white,
                      fontSize: Dimensions.fontSizeLarge,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            )),
          ),
        ),
      ],
    );
  }

  Widget buildLotteryAndFinanceButton() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () async {
                await Get.toNamed(Routes.BUY_LOTTERY);
                controller.userController.getUserInfo();
              },
              child: Container(
                child: Image.asset(Assets.newDesignLottery),
              ),
            ),
          ),
          const Gap(16),
          Expanded(
            child: GestureDetector(
              onTap: () {
                Get.dialog(ErrorAlertWidget(message: 'Coming soon...'));
              },
              child: Container(
                child: Image.asset(Assets.imagesScnFiLogo),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
