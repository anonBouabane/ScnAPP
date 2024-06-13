import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scn_easy/app/modules/lottery_history/reward/lottery_reward_view.dart';
import 'package:scn_easy/controller/auth_controller.dart';
import 'package:scn_easy/controller/user_controller.dart';
import 'package:scn_easy/helper/price_converter.dart';
import 'package:scn_easy/util/dimensions.dart';
import 'package:scn_easy/util/styles.dart';

import '../../../../controller/lottery_controller.dart';
import '../../../../util/images.dart';
import '../../policy/lotto_policy.dart';

class LottoReward extends StatefulWidget {
  const LottoReward({Key? key}) : super(key: key);

  @override
  State<LottoReward> createState() => _LottoRewardState();
}

class _LottoRewardState extends State<LottoReward> {
  @override
  void initState() {
    super.initState();
    Get.find<LotteryController>()
        .getBonus(true, 0, Get.find<AuthController>().getUserNumber());
    // Get.find<UserController>().getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: GetBuilder<LotteryController>(builder: (lotCtrl) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Row(children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        "your_referral_number".tr,
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeExtraLarge,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        "${lotCtrl.bprModel != null ? lotCtrl.bprModel!.referralCode.toString() : ""}",
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
                      Get.to(() => LottoPolicy());
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
                        // image: DecorationImage(
                        //   image: AssetImage(Images.viewConditionBtn),
                        //   fit: BoxFit.fill,
                        // ),
                      ),
                      child: Center(
                        child: Text(
                          'ເບິ່ງເງື່ອນໄຂເງິນແນະນໍາ',
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
            ),
            buildBankAccountNumber(),
            buildBankAccountName(),
            Padding(
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
                              image: AssetImage(Images.amountBoxBg),
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
                                  "ທ່ານແນະນຳທັງໝົດ",
                                  style: robotoBold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 3),
                                Text.rich(
                                  TextSpan(
                                    children: <InlineSpan>[
                                      TextSpan(
                                        text:
                                            "${lotCtrl.bonuses != null ? PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.bonuses!.totalUser.toString())) : 0}",
                                        style: robotoBold.copyWith(
                                          fontSize:
                                              Dimensions.fontSizeExtraLarge,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' ${'people'.tr}',
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
                              image: AssetImage(Images.amountBoxBg),
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
                                  "ເງິນທີ່ແນະນຳທັງໝົດ",
                                  style: robotoBold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 3),
                                Text(
                                  "${lotCtrl.bonuses != null ? PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.bonuses!.totalReward.toString())) : 0}",
                                  // "${PriceConverter.convertPriceNoCurrency(0)}",
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
            ),
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Row(
                children: [
                  buildBoxReferralPending(lotCtrl),
                  SizedBox(width: 10),
                  buildBoxReferralPaid(lotCtrl),
                ],
              ),
            ),
            // --------------- history list ------------ //
            Container(
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
                // image: DecorationImage(
                //   image: AssetImage(Images.viewConditionBtn),
                //   fit: BoxFit.fill,
                // ),
              ),
              child: Center(
                child: Text(
                  'ປະຫວັດການແນະນໍາ',
                  style: robotoBlack.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              // decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage(Images.historyTitleBtn),
              //   ),
              // ),
            ),
            lotCtrl.bonusDraw.isNotEmpty
                ? Container(
                    child: ListView.builder(
                        itemCount: lotCtrl.bonusDraw.length,
                        shrinkWrap: true,
                        key: UniqueKey(),
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () => lotCtrl.bonusDraw[index].drawId == 0
                                ? null
                                : Get.to(
                                    () => LotteryRewardView(),
                                    arguments: {
                                      'drawId':
                                          lotCtrl.bonusDraw[index].drawId!,
                                      'drawDate': lotCtrl
                                          .bonusDraw[index].drawDate
                                          .toString(),
                                    },
                                  ),
                            // : Get.to(
                            //     () => LottoRewardDetail(
                            //       drawDate: lotCtrl.bonusDraw[index].drawDate.toString(),
                            //       drawId: lotCtrl.bonusDraw[index].drawId!,
                            //     ),
                            //   ),
                            child: Container(
                              height: 70,
                              margin: EdgeInsets.all(4),
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(Images.pointStatementBg),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              child: ListTile(
                                title: Text(
                                  lotCtrl.bonusDraw[index].drawId == 0
                                      ? "ເງິນແນະນໍາທີ່ຖືກຈ່າຍແລ້ວ"
                                      : "ໄດ້ຮັບເງິນຈາກການແນະນຳ",
                                  style: robotoBold,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${lotCtrl.bonusDraw[index].drawDate}",
                                      style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSizeDefault,
                                        color: Colors.grey,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      // "+${PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.bonusDraw[index].estimateReward.toString()))}",
                                      '${lotCtrl.bonusDraw[index].estimateReward?.replaceAll(',', '.')}',
                                      style: robotoBold.copyWith(
                                        color:
                                            lotCtrl.bonusDraw[index].drawId == 0
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
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 108.0),
                    child: Center(
                      child: Text(
                        "ບໍ່ມີລາຍການ",
                        style: robotoBold.copyWith(
                          fontSize: Dimensions.fontSizeOverLarge,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  )
          ],
        );
      }),
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
              image: AssetImage(Images.amountBoxBg),
              fit: BoxFit.fill,
            ),
          ),
        ),
        GetBuilder<UserController>(builder: (userProfile) {
          return Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "ບັນຊີຮັບເງິນແນະນຳຂອງທ່ານ",
                      style: robotoBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      "${userProfile.userInfoModel.accountNo.toString().replaceAll("null", "")}",
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraLarge,
                        color: Colors.redAccent.shade700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ));
        })
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
              image: AssetImage(Images.amountBoxBg),
              fit: BoxFit.fill,
            ),
          ),
        ),
        GetBuilder<UserController>(builder: (userProfile) {
          return Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "ຊື່ບັນຊີ",
                      style: robotoBold,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${userProfile.userInfoModel.accountName.toString().replaceAll("null", "")}',
                      style: robotoBold.copyWith(
                        fontSize: Dimensions.fontSizeExtraLarge,
                        color: Colors.redAccent.shade700,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ));
        })
      ]),
    );
  }

  Widget buildBoxReferralPending(LotteryController lotCtrl) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.amountBoxBg),
                fit: BoxFit.fill,
              ),
            ),
            // child: Column(
            //   children: [
            //     Text("ເງິນແນະນຳທີ່ລໍຖ້າຈ່າຍ", style: robotoBold),
            //     Text("${lotCtrl.bonuses != null ? PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.bonuses!.totalpendingreward.toString())) : 0}",
            //         style: robotoBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge, color: Colors.redAccent.shade700)),
            //   ],
            // ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "ເງິນແນະນຳທີ່ລໍຖ້າຈ່າຍ",
                    style: robotoBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3),
                  Text(
                    "${lotCtrl.bonuses != null ? PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.bonuses!.totalPendingReward.toString())) : 0}",
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

  Widget buildBoxReferralPaid(LotteryController lotCtrl) {
    return Expanded(
      child: Stack(
        children: [
          Container(
            height: 70,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(Images.amountBoxBg),
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
                    "ເງິນແນະນໍາທີ່ຖືກຈ່າຍແລ້ວ",
                    style: robotoBold,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3),
                  Text(
                    // "${PriceConverter.convertPriceNoCurrency(lotCtrl.bonuses!.totalPaidReward!.toDouble())}",
                    "${lotCtrl.bonuses != null ? PriceConverter.convertPriceNoCurrency(double.parse(lotCtrl.bonuses!.totalPaidReward.toString())) : 0}",
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
}
