import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:pubnub/networking.dart';
import 'package:pubnub/pubnub.dart';
import 'package:scn_easy/app/controllers/user_controller.dart';
import 'package:scn_easy/app/routes/app_pages.dart';
import 'package:scn_easy/data/model/body/m_money.dart';
import 'package:scn_easy/helper/date_converter.dart';
import 'package:scn_easy/util/app_constants.dart';
import 'package:scn_easy/util/utils.dart';
import 'package:scn_easy/view/base/m_money_confirm_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../apis/api_exception.dart';
import '../../controllers/cart_controller.dart';
import '../../languages/translates.dart';
import '../../models/bank_model.dart';
import '../../models/bonus_referral_model.dart';
import '../../models/buy_lottery_model.dart';
import '../../models/invoice_model.dart';
import '../../models/reward_model.dart';
import '../../services/bonus_service.dart';
import '../../widgets/error_alert_widget.dart';
import 'buy_lottery_body.dart';
import 'buy_lottery_result_model.dart';
import 'payment_service.dart';

class PaymentController extends GetxController {
  final PaymentService paymentService = Get.find<PaymentService>();
  final BonusService bonusService = Get.find<BonusService>();
  final UserController userController = Get.find<UserController>();
  final CartController cartController = Get.find<CartController>();
  late TextEditingController txtReferralCode;
  RxBool isBuyLoading = false.obs;
  RxBool isReferralLoading = false.obs;
  RxBool isRewardLoading = false.obs;
  RxBool isPointLoading = false.obs;
  RxBool isBankLoading = false.obs;
  RxBool isShowReferralTextFormField = false.obs;
  RxString onePayMCID = ''.obs;
  RxString customerPhone = ''.obs;
  Rx<RewardModel?> rewardModel = RewardModel().obs;
  Rx<BonusReferralModel?> referralModel = BonusReferralModel().obs;
  Rx<PointItem?> pointModel = PointItem().obs;
  RxList<Statement> pointList = <Statement>[].obs;
  RxList<BankModel> bankList = <BankModel>[].obs;

  @override
  void onInit() async {
    super.onInit();
    txtReferralCode = TextEditingController();
    loadBanks();
    loadReferral();
    loadReward();
    loadPoints();
    // txtReferralCode.text = referralModel.value!.referralCode!;
    customerPhone.value = userController.userInfoModel.phone!;
    Logger().i('pointModel: ${pointModel.value?.balance}');
    Logger().w('rewardModel: ${rewardModel.value?.rewardId}\n'
        '${rewardModel.value?.custId}'
        '${rewardModel.value?.expAt}');
  }

  @override
  void onClose() {
    super.onClose();
    txtReferralCode.dispose();
  }

  loadReferral() async {
    try {
      isReferralLoading.value = true;
      final response = await bonusService.getBonusReferral(
          customerPhone: userController.userInfoModel.phone!);

      if (response.statusCode == 200) {
        final item = BonusReferralModel.fromJson(response.data);
        referralModel.value = item;
        isReferralLoading.value = false;
      }
    } on DioException catch (error) {
      isReferralLoading.value = false;
      final apiException = ApiException.fromDioError(error);
      if (kDebugMode) {
        Logger().e('apiException: ${apiException.message}');
      }
    }
  }

  loadReward() async {
    try {
      isRewardLoading.value = true;
      final response = await bonusService.checkRewardId(
          customerPhone: userController.userInfoModel.phone!);

      if (response.statusCode == 200) {
        final item = RewardModel.fromJson(response.data);
        rewardModel.value = item;
        isShowReferralTextFormField.value = item.custId == 0 ||
                int.parse(DateConverter.dateToDate(kCurrentDate)
                        .replaceAll('-', '')
                        .trim()) >=
                    int.parse(DateConverter.dateToDate(item.expAt)
                        .replaceAll('-', '')
                        .trim())
            ? true
            : false;
      } else {
        rewardModel.value = RewardModel(custId: 0, rewardId: null, expAt: null);
      }
      isRewardLoading.value = false;
    } on DioException catch (error) {
      isRewardLoading.value = false;
      final apiException = ApiException.fromDioError(error);
      if (kDebugMode) {
        Logger().e('apiException: ${apiException.message}');
      }
      //   Get.dialog(ErrorAlertWidget(message: apiException.message));
    }
  }

  Future<void> loadBanks() async {
    if (kDebugMode) {
      Logger().w('loadBanksForPayment');
    }
    isBankLoading.value = true;
    final response = await paymentService.loadBanks();

    if (response.statusCode == 200) {
      bankList.clear();
      for (var item in response.data) {
        bankList.add(BankModel.fromJson(item));
      }
      // final items = bankModelFromJson(response.data.toString());
      // Logger().w(items);
      // bankList.addAll(items);
      isBankLoading.value = false;
    } else {
      isBankLoading.value = false;
      Get.dialog(ErrorAlertWidget(
          message: Translates.ERROR_UNABLE_TO_LOAD_PAYMENT_OPTION.tr));
    }
  }

  Future<BuyLotteryResultModel?> buyingLottery() async {
    isBuyLoading.value = true;
    BuyLotteryResultModel? buyLotteryResultModel;

    List<LotteryNumberItem> orders = [];
    cartController.carts.forEach((item) {
      orders.add(LotteryNumberItem(number: item.number, amount: item.amount));
    });

    BuyLotteryModel buyLotteryModel = BuyLotteryModel();
    buyLotteryModel.customerPhone = userController.userInfoModel.phone!;
    buyLotteryModel.rewardId = txtReferralCode.text.toString();
    buyLotteryModel.orders = orders;

    final response = await paymentService.buyLottery(buyLotteryModel);
    if (kDebugMode) {
      Logger().i('buy response:: ${response.data}');
    }

    if (response.statusCode == 200) {
      buyLotteryResultModel = BuyLotteryResultModel.fromJson(response.data);
    } else if (response.statusCode == 400) {
      isBuyLoading.value = false;
      Get.dialog(ErrorAlertWidget(message: response.data['msg']));
    } else if (response.statusCode == 401) {
      isBuyLoading.value = false;
      Get.dialog(ErrorAlertWidget(message: 'Unauthorized'));
    } else if (response.statusCode == 504) {
      isBuyLoading.value = false;
      Get.dialog(ErrorAlertWidget(message: '504 Gateway Time-out'));
    } else if (response.statusCode == 404) {
      isBuyLoading.value = false;
      if (response.data['status'] == 025) {
        Get.dialog(ErrorAlertWidget(message: 'ບໍ່ສາມາດຂາຍເລກ ລໍຖ້າເປີດການຂາຍ'));
      } else {
        Get.dialog(ErrorAlertWidget(message: response.data['msg']));
      }
    }
    isBuyLoading.value = false;
    return buyLotteryResultModel;
  }

  void payByPoint({required String ticketId}) async {
    isBuyLoading.value = true;
    final response = await paymentService.payByPoint(
        userController.userInfoModel.phone!, ticketId);
    if (kDebugMode) {
      Logger().i(
        'Point payment ticketId: $ticketId\n'
        'status: ${response.statusCode}\n'
        'body: ${response.data}',
      );
    }
    if (response.statusCode == 200) {
      isBuyLoading.value = false;
      Future.delayed(Duration(seconds: 1), () async {
        await getInvoiceDetail(userController.userInfoModel.phone!, ticketId);
        loadPoints();
        cartController.clearCart();
      });
    } else if (response.statusCode == 400) {
      isBuyLoading.value = false;
      Get.dialog(ErrorAlertWidget(message: response.data['msg']));
    }
    isBuyLoading.value = false;
  }

  Future<void> getInvoiceDetail(String customPhone, String ticketId) async {
    final response = await paymentService.loadInvoiceDetail(
      customPhone,
      ticketId,
    );

    if (response.statusCode == 200) {
      InvoiceItem invoiceItem = InvoiceItem.fromJson(response.data);
      Get.toNamed(Routes.INVOICE_DETAIL, arguments: invoiceItem);
    } else {
      Get.dialog(ErrorAlertWidget(message: response.statusMessage.toString()));
    }
  }

  Future<void> loadPoints() async {
    isPointLoading.value = true;
    final response =
        await paymentService.loadPoints(userController.userInfoModel.phone!);

    if (response.statusCode == 200) {
      pointList.clear();
      pointModel.value = PointItem.fromJson(response.data);
      pointList.addAll(PointItem.fromJson(response.data).statements!);
    }
    isPointLoading.value = false;
  }

  Future<void> submitPayment(BuyLotteryBody request) async {
    isBuyLoading.value = true;
    final response = await paymentService.submitPayment(request);
    if (kDebugMode) {
      Logger().w("payment request:: ${request.toJson()}");
      Logger().e('get-payment-code: ${response.data}');
    }

    if (response.statusCode == 200) {
      if (request.bankId == 3) {
        ///BCEL Payment
        if (kDebugMode) {
          Logger().i('BCEL: $request');
          Logger().i('BCEL: ${response.data}');
        }
        String qrCode = response.data['paymentCode'];
        String uuidKey = response.data['paymentTransactionId'];
        String mcid = onePayMCID.value;
        var channel = '';
        var pubnub = PubNub(
          defaultKeyset: Keyset(
            subscribeKey: AppConstants.BCEL_SUBSCRIBE_KEY,
            userId: UserId(AppConstants.BCEL_USER_KEY),
          ),
          networking: NetworkingModule(ssl: true),
        );
        channel = 'uuid-$mcid-$uuidKey';
        var subscription = pubnub.subscribe(channels: {channel});
        subscription.messages.listen((envelope) async {
          switch (envelope.messageType) {
            case MessageType.normal:
              // final Map parsed = json.decode(envelope.payload);
              if (kDebugMode) {
                Logger().i("callback:: ${envelope.payload}");
              }
              Get.back();
              Future.delayed(Duration(seconds: 2), () async {
                await getInvoiceDetail(
                  request.custPhone.toString(),
                  request.transactionNo.toString(),
                );
                cartController.clearCart();
              });
              break;
            default:
              if (kDebugMode) {
                Logger().d(
                    'default ${envelope.publishedAt} sent a message: ${envelope.content}');
              }
          }
        });
        if (await canLaunchUrl(Uri.parse("onepay://qr/$qrCode"))) {
          await launchUrl(Uri.parse("onepay://qr/$qrCode"));
        } else {
          Get.dialog(ErrorAlertWidget(
              message: Translates.ERROR_CAN_NOT_LAUNCH_BANK_PAYMENT.tr));
        }
      } else if (request.bankId == 4) {
        ///Lao viet Bank payment
        pubnubSubscript(
          request.transactionNo.toString(),
          request.custPhone.toString(),
        );
        if (kDebugMode) {
          Logger().i('LVB: $request');
          Logger().i('LVB: ${response.data}');
        }
        if (response.data['paymentCode'] != null) {
          // await launchUrl(
          //   Uri.parse(response.body['paymentCode']),
          //   mode: LaunchMode.externalApplication,
          // );
          // if (await canLaunchUrl(Uri.parse(response.body['paymentCode']))) {
          await launchUrl(
            Uri.parse(response.data['paymentCode']),
            mode: LaunchMode.externalApplication,
          );
          // } else {
          //   _buyLoading = false;
          //   showDialog(
          //     barrierDismissible: false,
          //     context: Get.context!,
          //     builder: (context) => MessageAlertMsg(
          //       'error',
          //       'ທ່ານຍັງບໍ່ມີແອັບທະນາຄານ LVB\nກະລຸນາຕິດຕັ້ງແອັບທະນາຄານ ແລ້ວລອງໃໝ່ອີກຄັ້ງ.',
          //       Icons.error_outline,
          //       Colors.red,
          //     ),
          //   );
          // }
        } else {
          isBuyLoading.value = false;
          Get.dialog(ErrorAlertWidget(
              message: Translates.ERROR_CAN_NOT_LAUNCH_BANK_PAYMENT.tr));
        }
      } else if (request.bankId == 21) {
        /// LDB
        pubnubSubscript(
          request.transactionNo.toString(),
          request.custPhone.toString(),
        );
        if (kDebugMode) {
          Logger().i('LDB: ${request.toJson()}');
          Logger().i('LDB: ${response.data}');
        }
        if (response.data['paymentCode'] != null) {
          // if (await canLaunchUrl(Uri.parse(response.body['paymentCode']))) {
          await launchUrl(
            Uri.parse(response.data['paymentCode']),
            mode: LaunchMode.externalApplication,
          );
          // } else {
          //   _buyLoading = false;
          //   showDialog(
          //     barrierDismissible: false,
          //     context: Get.context!,
          //     builder: (context) => MessageAlertMsg(
          //       'error',
          //       'ທ່ານຍັງບໍ່ມີແອັບທະນາຄານ LDB Trust\nກະລຸນາຕິດຕັ້ງແອັບທະນາຄານ ແລ້ວລອງໃໝ່ອີກຄັ້ງ.',
          //       Icons.error_outline,
          //       Colors.red,
          //     ),
          //   );
          // }
        } else {
          isBuyLoading.value = false;
          Get.dialog(ErrorAlertWidget(
              message: Translates.ERROR_CAN_NOT_LAUNCH_BANK_PAYMENT.tr));
        }
      } else if (request.bankId == 2) {
        /// APB
        pubnubSubscript(
          request.transactionNo.toString(),
          request.custPhone.toString(),
        );
        if (kDebugMode) {
          Logger().i('APB: $request');
          Logger().i('APB: ${response.data}');
        }

        if (response.data['paymentCode'] != null) {
          try {
            // await launchUrl(
            //   Uri.parse(
            //       "apb://mobile.apb.com.la/qr_payment?qr=${response.body['paymentCode']}"),
            //   mode: LaunchMode.externalApplication,
            // );
            if (await canLaunchUrl(Uri.parse(
                "apb://mobile.apb.com.la/qr_payment?qr=${response.data['paymentCode']}"))) {
              await launchUrl(
                Uri.parse(
                    "apb://mobile.apb.com.la/qr_payment?qr=${response.data['paymentCode']}"),
                mode: LaunchMode.externalApplication,
              );
            } else {
              isBuyLoading.value = false;
              Get.dialog(ErrorAlertWidget(
                message: 'ທ່ານຍັງບໍ່ມີແອັບທະນາຄານ APB\n'
                        'ກະລຸນາຕິດຕັ້ງແອັບທະນາຄານ ແລ້ວລອງໃໝ່ອີກຄັ້ງ.'
                    .tr,
              ));
            }
          } catch (e) {
            Get.dialog(ErrorAlertWidget(
                message: Translates.ERROR_CAN_NOT_LAUNCH_BANK_PAYMENT.tr));
          }
        } else {
          Get.dialog(ErrorAlertWidget(
              message: Translates.ERROR_CAN_NOT_LAUNCH_BANK_PAYMENT.tr));
        }
        isBuyLoading.value = false;
      } else if (request.bankId == 1) {
        /// M-Money
        MMoneyCashOutBody cashOutBody = new MMoneyCashOutBody();
        cashOutBody.transCashOutId = response.data['transCashOutID'];
        cashOutBody.transId = response.data['paymentTransactionId'];
        cashOutBody.otpRefNo = response.data['otpRefNo'];
        cashOutBody.otpRefCode = response.data['otpRefCode'];
        cashOutBody.topUpTransactionId = request.transactionNo;
        showGeneralDialog(
          context: Get.context!,
          pageBuilder: (context, animation, secondaryAnimation) =>
              MMoneyConfirmDialog(request: cashOutBody),
        );
      }
      isBuyLoading.value = false;
    } else {
      isBuyLoading.value = false;
      Get.dialog(ErrorAlertWidget(message: response.statusMessage.toString()));
    }
    isBuyLoading.value = false;
  }

  void pubnubSubscript(String transactionId, String customerPhone) {
    var pubnub = PubNub(
      defaultKeyset: Keyset(
        publishKey: AppConstants.PUBNUB_PUBLIC_KEY,
        subscribeKey: AppConstants.PUBNUB_SUBSCRIBE_KEY,
        userId: UserId(AppConstants.PUBNUB_USER_ID),
      ),
      networking: NetworkingModule(ssl: true),
    );
    var subscription =
        pubnub.subscribe(channels: {'bank_callback_$transactionId'});
    subscription.messages.listen((envelope) async {
      if (kDebugMode) {
        Logger().w(envelope.payload);
      }
      switch (envelope.messageType) {
        case MessageType.normal:
          update();
          Future.delayed(Duration(seconds: 2), () async {
            await getInvoiceDetail(
              customerPhone,
              transactionId,
            );
            cartController.clearCart();
          });
          break;
        default:
          if (kDebugMode) {
            Logger().w(
              'default ${envelope.publishedAt} sent a message: ${envelope.content}',
            );
          }
      }
    });
  }

  Future<bool> saveRewardId(String customerPhone, String referralId) async {
    bool isSaveComplete = false;
    final response =
        await paymentService.saveRewardId(customerPhone, referralId);
    if (kDebugMode) {
      Logger().i(
        'save referral code ${response.statusCode}\n'
        'completed ${response.data}',
      );
    }

    if (response.statusCode == 200) {
      isSaveComplete = true;
      loadReferral();
    } else {
      isSaveComplete = false;
      Get.dialog(ErrorAlertWidget(message: response.data['msg']));
    }
    return isSaveComplete;
  }
}
