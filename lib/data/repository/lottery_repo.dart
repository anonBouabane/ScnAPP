import 'dart:convert';

import 'package:get/get.dart';
import 'package:scn_easy/data/api/api_client_lottery.dart';
import 'package:scn_easy/util/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/body/lotto_buy_number.dart';
import '../model/body/lotto_laoviet_payment.dart';
import '../model/body/m_money.dart';

class LotteryRepo {
  final ApiClientLottery apiClient;
  final SharedPreferences sharedPreferences;

  LotteryRepo({required this.apiClient, required this.sharedPreferences});

  void addToNumberList(List<LottoNumber> number) {
    List<String> carts = [];
    for (int i = 0; i < number.length; i++) {
      carts.add(jsonEncode(number[i]));
    }
    sharedPreferences.setStringList(AppConstants.NUMBER_LIST, carts);
  }

  List<LottoNumber> getNumberList() {
    List<String> numbers = [];
    if (sharedPreferences.containsKey(AppConstants.NUMBER_LIST)) {
      numbers = sharedPreferences.getStringList(AppConstants.NUMBER_LIST)!;
    }
    List<LottoNumber> numberList = [];
    for (int i = 0; i < numbers.length; i++) {
      numberList.add(LottoNumber.fromJson(jsonDecode(numbers[i])));
    }
    return numberList;
  }

  void clearNumber() {
    sharedPreferences.remove(AppConstants.NUMBER_LIST);
  }

  Future<Response> lotteryHistory(int offset) async {
    return await apiClient.lottoPost(
        "${AppConstants.LOTTERY_HISTORY}limit=50&offset=$offset", {});
  }

  Future<Response> lotteryDashboard() async {
    return await apiClient.lottoPost("${AppConstants.LOTTERY_DASHBOARD}", {});
  }

  Future<Response> bonusPointReferral(String phoneNo) async {
    return await apiClient
        .lottoGet("${AppConstants.LOTTERY_BONUS_POINT_REFERRAL}$phoneNo");
  }

  Future<Response> points(String phoneNo) async {
    return await apiClient.lottoGet("${AppConstants.LOTTERY_POINT}$phoneNo");
  }

  Future<Response> buyLottery(LottoBuyNumber lottoBuyNumber) async {
    return await apiClient.lottoPost("${AppConstants.LOTTERY_BUY}", {
      "CustPhone": lottoBuyNumber.custPhone,
      "RewardId": lottoBuyNumber.rewardId,
      "Orders": lottoBuyNumber.orders,
    });
  }

  Future<Response> pointPayment(String custPhone, String ticketId) async {
    return await apiClient.lottoPost(
        "${AppConstants.LOTTERY_POINT_PAYMENT}$custPhone&ticketId=$ticketId&paymentType=POINT&paymentRefNo=NULL",
        {});
  }

  Future<Response> checkRewardId(String custPhone) async {
    return await apiClient
        .lottoGet("${AppConstants.LOTTERY_CHECK_REWARD_ID}$custPhone");
  }

  Future<Response> saveRewardId(String custPhone, String rewardId) async {
    return await apiClient.lottoPost(
        "${AppConstants.LOTTERY_CHECK_REWARD_ID}$custPhone&rewardID=$rewardId",
        {});
  }

  Future<Response> checkLotOpenClose() async {
    return await apiClient
        .lottoPost("${AppConstants.CHECK_LOT_OPEN_CLOSE}", {});
  }

  Future<Response> lotteryInvoice(int offset, String phone) async {
    return await apiClient
        .lottoGet("${AppConstants.LOTTERY_INVOICE}$phone&offset=$offset");
  }

  Future<Response> lotteryInvoiceDetail(customPhone, String ticketId) async {
    return await apiClient.lottoGet(
        "${AppConstants.LOTTERY_INVOICE_DETAIL}$customPhone&ticketId=$ticketId");
  }

  Future<Response> bonus(int offset, String phoneNo) async {
    return await apiClient
        .lottoGet("${AppConstants.LOTTERY_BONUS}$phoneNo&offset=$offset");
  }

  Future<Response> bonusDetail(int drawId, String phoneNo) async {
    return await apiClient.lottoGet(
        "${AppConstants.LOTTERY_BONUS_DETAILS}$drawId&custPhone=$phoneNo&limit=20&offset=0");
  }

  ///Payment Section
  Future<Response> getBankPaymentOptions(int companyId) async {
    return await apiClient.lottoGet("${AppConstants.GET_BANK_LIST}$companyId",
        isPayment: true,
        headers: {
          "Content-type": 'application/json; charset=UTF-8',
          'Authorization': AppConstants.PAYMENT_KEY
        });
  }

  Future<Response> bankPayment(LottoLaoVietPaymentBody request) async {
    return await apiClient.lottoPost(
        "${AppConstants.LAO_VIET_PAYMENT}",
        {
          "company_id": 1,
          "bank_id": request.bankId,
          "amount": request.amount,
          "pay_for": "LOTTERY",
          "transaction_no": request.transactionNo,
          "cust_phone": request.custPhone,
        },
        isPayment: true,
        headers: {
          "Content-type": 'application/json; charset=UTF-8',
          'Authorization': AppConstants.PAYMENT_KEY
        });
  }

  Future<Response> mMoneyCashOut(MMoneyCashOutBody request) async {
    return await apiClient.lottoPost(
        "${AppConstants.CONFIRM_CASH_OUT}",
        {
          "transID": "${request.transId}",
          "transCashOutID": "${request.transCashOutId}",
          "otpRefNo": "${request.otpRefNo}",
          "otpRefCode": "${request.otpRefCode}",
          "otp": "${request.otp}",
        },
        isPayment: true,
        headers: {
          "Content-type": 'application/json; charset=UTF-8',
          'Authorization': AppConstants.PAYMENT_KEY
        });
  }
}
