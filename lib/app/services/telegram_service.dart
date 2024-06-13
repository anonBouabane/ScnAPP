import 'dart:developer';

import 'package:dio/dio.dart';

class TelegramService {
  static void sendMessage({
    required String customerPhone,
    required String transactionNo,
    required int companyId,
    required String payFor,
    required int bankId,
    required int amount,
  }) {
    try {
      final String errorMessage = 'SCN Response\n'
          'customerPhone: $customerPhone\n'
          'transactionNo: $transactionNo\n'
          'companyId: $companyId\n'
          'payFor: $payFor\n'
          'bankId: $bankId\n'
          'amount: $amount';

      const chatId = '-4094296918';
      const botToken = '6228352286:AAFsRgFEjFRo3RQU7wvQ6_e9BjM6vjNHE4Y';
      final String url =
          'https://api.telegram.org/bot$botToken/sendMessage?chat_id=$chatId&text=$errorMessage';
      final response = Dio().post(url);
      log(response.toString());
    } catch (e) {
      log(e.toString());
    }
  }
}
