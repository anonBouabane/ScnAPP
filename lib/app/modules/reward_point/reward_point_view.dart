import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:scn_easy/generated/assets.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../languages/translates.dart';
import '../../models/reward_model.dart';
import '../../routes/app_pages.dart';
import '../../widgets/background_widget.dart';
import '../policy/policy_referral_view.dart';
import 'reward_point_controller.dart';

class RewardPointView extends GetView<RewardPointController> {
  const RewardPointView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.redAccent.shade700,
        ),
        body: Stack(
          children: [
            BackgroundWidget(),
            IndexedStack(
              index: controller.currentTabIndex.value,
              children: [
                buildRewardList(),
                buildPointList(),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget buildRewardList() {
    return CustomScrollView(
      shrinkWrap: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverToBoxAdapter(child: buildTabBar()),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                controller.bonusController.isBonusLoading.isTrue
                    ? Center(child: CircularProgressIndicator())
                    : buildReferral(
                        referralCode: controller.bonusController
                            .bonusReferralModel.value!.referralCode!),
                buildBankAccountNumber(),
                buildBankAccountName(),
                buildTotalReferral(),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Row(
                    children: [
                      buildBoxReferralPending(),
                      const Gap(10),
                      buildBoxReferralPaid(),
                    ],
                  ),
                ),
                buildReferralHistoryTitle(),
                controller.drawList.isNotEmpty
                    ? buildHasBonusFromReferral()
                    : buildHasNoBonus(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTabBar() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () => controller.currentTabIndex.value = 0,
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.only(bottomRight: Radius.circular(20)),
                    image: DecorationImage(
                      image: AssetImage(controller.currentTabIndex.value != 0
                          ? Assets.newDesignBonusTab
                          : Assets.newDesignBonusTabSelected),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      Translates.BONUS.tr,
                      style: robotoBold.copyWith(
                        color: controller.currentTabIndex.value != 1
                            ? Colors.white
                            : Colors.black,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: InkWell(
                onTap: () => controller.currentTabIndex.value = 1,
                child: Container(
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                    ),
                    image: DecorationImage(
                      image: AssetImage(
                        controller.currentTabIndex.value != 1
                            ? Assets.newDesignPointTab
                            : Assets.newDesignPointTabSelected,
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      Translates.POINTS.tr,
                      style: robotoBold.copyWith(
                        color: controller.currentTabIndex.value != 0
                            ? Colors.white
                            : Colors.black,
                        fontSize: Dimensions.fontSizeLarge,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildReferral({
    required String referralCode,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Row(children: [
        Expanded(
          child: Column(
            children: [
              Text(
                Translates.YOUR_REFERRAL_NUMBER.tr,
                style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeExtraLarge,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                referralCode,
                style: robotoBold.copyWith(
                  fontSize: Dimensions.fontSizeHugeLarge2,
                  color: Colors.red.shade800,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              Get.to(() => PolicyReferralView());
            },
            child: Container(
              height: 45,
              margin: EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xffdf0000), Color(0xffc00303)],
                ),
              ),
              child: Center(
                child: Text(
                  'ເບິ່ງເງື່ອນໄຂເງິນແນະນໍາ'.tr,
                  style: robotoBlack.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget buildBankAccountNumber() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Stack(children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.newDesignAmountBoxBg),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'ບັນຊີຮັບເງິນແນະນຳຂອງທ່ານ'.tr,
                  style: robotoBold,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  '${controller.userController.userInfoModel.accountNo.toString().replaceAll('null', '')}',
                  style: robotoBold.copyWith(
                    fontSize: Dimensions.fontSizeExtraLarge,
                    color: Colors.redAccent.shade700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }

  Widget buildBankAccountName() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Stack(children: [
        Container(
          height: 70,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.newDesignAmountBoxBg),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'ຊື່ບັນຊີ'.tr,
                    style: robotoBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 2),
                  Text(
                    '${controller.userController.userInfoModel.accountName.toString().replaceAll('null', '')}',
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                      color: Colors.redAccent.shade700,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ))
      ]),
    );
  }

  Widget buildTotalReferral() {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.newDesignAmountBoxBg),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'ທ່ານແນະນຳທັງໝົດ'.tr,
                          style: robotoBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3),
                        controller.isRewardLoading.isTrue
                            ? Center(child: CircularProgressIndicator())
                            : Text.rich(
                                TextSpan(
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text:
                                          '${PriceConverter.convertPriceNoCurrency(double.parse(controller.rewardItem.value.totalUser.toString()))}',
                                      style: robotoBold.copyWith(
                                        fontSize: Dimensions.fontSizeExtraLarge,
                                      ),
                                    ),
                                    TextSpan(
                                      text: Translates.PEOPLE.tr,
                                      style: robotoBold.copyWith(
                                        fontSize: Dimensions.fontSizeSmall,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: 70,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(Assets.newDesignAmountBoxBg),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'ເງິນທີ່ແນະນຳທັງໝົດ'.tr,
                          style: robotoBold,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 3),
                        controller.isRewardLoading.isTrue
                            ? Center(child: CircularProgressIndicator())
                            : Text(
                                '${PriceConverter.convertPriceNoCurrency(double.parse(controller.rewardItem.value.totalReward.toString()))}',
                                style: robotoBold.copyWith(
                                  fontSize: Dimensions.fontSizeExtraLarge,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBoxReferralPending() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.newDesignAmountBoxBg),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'ເງິນແນະນຳທີ່ລໍຖ້າຈ່າຍ'.tr,
                    style: robotoBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(3),
                  controller.isRewardLoading.isTrue
                      ? Center(child: CircularProgressIndicator())
                      : Text(
                          '${PriceConverter.convertPriceNoCurrency(double.parse(controller.rewardItem.value.totalPendingReward.toString()))}',
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Colors.redAccent.shade700,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildBoxReferralPaid() {
    return Expanded(
      child: Stack(
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Assets.newDesignAmountBoxBg),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'ເງິນແນະນໍາທີ່ຖືກຈ່າຍແລ້ວ'.tr,
                    style: robotoBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(3),
                  controller.isRewardLoading.isTrue
                      ? Center(child: CircularProgressIndicator())
                      : Text(
                          '${PriceConverter.convertPriceNoCurrency(double.parse(controller.rewardItem.value.totalPaidReward.toString()))}',
                          style: robotoBold.copyWith(
                            fontSize: Dimensions.fontSizeExtraLarge,
                            color: Colors.green,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildReferralHistoryTitle() {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      width: Get.width * 0.4,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffdf0000), Color(0xffc00303)],
        ),
      ),
      child: Center(
        child: Text(
          'ປະຫວັດການແນະນໍາ'.tr,
          style: robotoBlack.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }

  Widget buildHasBonusFromReferral() {
    return Container(
      child: ListView.builder(
          itemCount: controller.drawList.length,
          shrinkWrap: true,
          key: UniqueKey(),
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            DrawModel item = controller.drawList[index];
            return InkWell(
              onTap: () => item.drawId == 0
                  ? null
                  : Get.toNamed(
                      Routes.REWARD_DETAIL,
                      arguments: {
                        'drawId': item.drawId!,
                        'drawDate': item.drawDate.toString(),
                      },
                    ),
              child: Container(
                height: 70,
                margin: EdgeInsets.all(4),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(Assets.newDesignPointStatementBg),
                    fit: BoxFit.fill,
                  ),
                ),
                child: ListTile(
                  title: Text(
                    item.drawId == 0
                        ? 'ເງິນແນະນໍາທີ່ຖືກຈ່າຍແລ້ວ'.tr
                        : 'ໄດ້ຮັບເງິນຈາກການແນະນຳ'.tr,
                    style: robotoBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${item.drawDate}',
                        style: robotoRegular.copyWith(
                          fontSize: Dimensions.fontSizeDefault,
                          color: Colors.grey,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        '${item.estimateReward?.replaceAll(',', '.')}',
                        style: robotoBold.copyWith(
                          color: item.drawId == 0
                              ? Colors.redAccent.shade700
                              : Colors.green.shade700,
                          fontSize: Dimensions.fontSizeLarge,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Widget buildHasNoBonus() {
    return Padding(
      padding: const EdgeInsets.only(top: 108.0),
      child: Center(
        child: Text(
          'ບໍ່ມີລາຍການ'.tr,
          style: robotoBold.copyWith(
            fontSize: Dimensions.fontSizeOverLarge,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget buildPointList() {
    return CustomScrollView(
      shrinkWrap: true,
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      slivers: [
        SliverToBoxAdapter(child: buildTabBar()),
        SliverToBoxAdapter(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    Translates.POINT_THAT_YOU_HAVE.tr,
                    style: robotoBold.copyWith(
                      fontSize: Dimensions.fontSizeExtraLarge,
                    ),
                  ),
                ),
                controller.isPointLoading.value
                    ? Center(child: CircularProgressIndicator())
                    : Text(
                        '${PriceConverter.convertPriceNoCurrency(double.parse(controller.pointItem.value.balance.toString()))}',
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeOverLarge,
                          color: Colors.redAccent.shade700,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                controller.pointList.isNotEmpty
                    ? buildPointItemList()
                    : buildHasNoBonus()
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildPointItemList() {
    return Container(
      child: ListView.builder(
          itemCount: controller.pointList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            Statement item = controller.pointList[i];
            return Column(
              children: [
                Container(
                    height: 85,
                    margin: EdgeInsets.only(
                      left: 10,
                      right: 10,
                    ),
                    padding: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      image: DecorationImage(
                        image: AssetImage(
                          Assets.newDesignPointStatementBg,
                        ),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                item.description
                                    .toString()
                                    .replaceAll(new RegExp(r"\d"), "")
                                    .replaceAll('//', '')
                                    .replaceAll('::', '')
                                    .replaceAll('AM', '')
                                    .replaceAll('PM', '')
                                    .replaceAll("|", ""),
                                style: robotoBold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "${DateConverter.dateToDateAndTime1(item.datetime)}",
                              style: robotoRegular.copyWith(
                                fontSize: Dimensions.fontSizeSmall,
                              ),
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            buildReferenceText(item),
                            const Gap(10),
                            buildScoreText(item),
                          ],
                        ),
                      ],
                    )),
                SizedBox(height: 4)
              ],
            );
          }),
    );
  }

  Widget buildReferenceText(Statement item) {
    String? text = item.paymentReferenceNo;
    if (text == 'end_year_clear_point') {
      text = item.description.toString();
    } else if (text == null) {
      text = item.description.toString();
    }

    return Flexible(
      child: Text(
        '${Translates.REFERENCE_NUMBER.tr} $text',
        style: robotoRegular.copyWith(
          color: Colors.grey,
          fontSize: Dimensions.fontSizeDefault,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget buildScoreText(Statement item) {
    String text = '';
    Color color = Colors.transparent;
    String credit = item.credit.toString();
    String debit = item.debit.toString();
    String? referenceText = item.paymentReferenceNo;

    if (int.parse(credit) == 0 && referenceText == 'end_year_clear_point') {
      text =
          '${PriceConverter.convertPriceNoCurrency(double.parse(credit))} ${Translates.POINTS.tr}';
      color = Colors.black;
    } else if (int.parse(credit) > 0 && int.parse(debit) == 0) {
      text =
          '+${PriceConverter.convertPriceNoCurrency(double.parse(credit))} ${Translates.POINTS.tr}';
      color = Colors.green.shade900;
    } else {
      text =
          '-${PriceConverter.convertPriceNoCurrency(double.parse(debit.replaceAll('-', '')))} ${Translates.POINTS.tr}';
      color = Colors.redAccent.shade700;
    }
    return Text(
      text,
      style: robotoRegular.copyWith(
        color: color,
        fontSize: Dimensions.fontSizeDefault,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
