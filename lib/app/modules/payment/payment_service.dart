import 'package:dio/dio.dart';
import 'package:scn_easy/app/apis/api_payment_client.dart';
import 'package:scn_easy/util/app_constants.dart';

import '../../apis/api_client.dart';
import '../../models/buy_lottery_model.dart';
import 'buy_lottery_body.dart';

class PaymentService {
  final ApiClient apiLotteryClient = ApiClient();
  final ApiPaymentClient apiPaymentClient = ApiPaymentClient();

  Future<Response> loadBanks() async {
    try {
      final params = <String, dynamic>{
        'company_id': 1,
      };

      final Response response = await apiPaymentClient.get(
        AppConstants.PAYMENT_BANK_LIST_BY_THIN,
        queryParameters: params,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> checkLotteryOpen() async {
    try {
      final Response response = await apiLotteryClient.post(
        AppConstants.CHECK_LOT_OPEN_CLOSE,
        data: null,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> buyLottery(BuyLotteryModel buyLotteryModel) async {
    try {
      final data = <String, dynamic>{
        'CustPhone': buyLotteryModel.customerPhone,
        'RewardId': buyLotteryModel.rewardId,
        'Orders': buyLotteryModel.orders,
      };

      final Response response = await apiLotteryClient.post(
        AppConstants.LOTTERY_BUY_BY_THIN,
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> payByPoint(String customerPhone, String ticketId) async {
    try {
      final params = <String, dynamic>{
        'CustPhone': customerPhone,
        'ticketId': ticketId,
        'paymentType': 'POINT',
        'paymentRefNo': 'NULL'
      };

      final Response response = await apiLotteryClient.post(
        AppConstants.LOTTERY_PAY_WITH_POINT_BY_THIN,
        queryParameters: params,
        data: {},
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadInvoiceDetail(
      String customerPhone, String ticketId) async {
    try {
      final params = <String, dynamic>{
        'CustPhone': customerPhone,
        'ticketId': ticketId,
      };

      final Response response = await apiLotteryClient.get(
        AppConstants.LOTTERY_INVOICE_DETAIL_BY_THIN,
        queryParameters: params,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> loadPoints(String customerPhone) async {
    try {
      final params = <String, dynamic>{
        'custPhone': customerPhone,
        'limit': 30,
      };

      final Response response = await apiLotteryClient.get(
        AppConstants.LOTTERY_POINT_BY_THIN,
        queryParameters: params,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> submitPayment(BuyLotteryBody body) async {
    try {
      final data = <String, dynamic>{
        'company_id': 1,
        'bank_id': body.bankId,
        'amount': body.amount,
        'pay_for': 'LOTTERY',
        'transaction_no': body.transactionNo,
        "cust_phone": body.custPhone,
      };

      final Response response = await apiPaymentClient.post(
        AppConstants.PAYMENT_GET_PAYMENT_CODE_BY_THIN,
        data: data,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> saveRewardId(String customerPhone, String rewardId) async {
    try {
      final params = <String, dynamic>{
        "cust_phone": customerPhone,
        'rewardID': rewardId,
      };

      final Response response = await apiPaymentClient.post(
        AppConstants.PAYMENT_GET_PAYMENT_CODE_BY_THIN,
        queryParameters: params,
        data: {},
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
