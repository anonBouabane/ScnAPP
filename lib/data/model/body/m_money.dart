import 'dart:convert';

MMoneyCashOutBody mMoneyCashOutBodyFromJson(String str) =>
    MMoneyCashOutBody.fromJson(json.decode(str));

String mMoneyCashOutBodyToJson(MMoneyCashOutBody data) =>
    json.encode(data.toJson());

class MMoneyCashOutBody {
  String? transId;
  String? transCashOutId;
  String? otpRefNo;
  String? otpRefCode;
  String? otp;
  String? topUpTransactionId;

  MMoneyCashOutBody(
      {this.transId,
      this.transCashOutId,
      this.otpRefNo,
      this.otpRefCode,
      this.otp,
      this.topUpTransactionId});

  factory MMoneyCashOutBody.fromJson(Map<String, dynamic> json) =>
      MMoneyCashOutBody(
        transId: json["transID"],
        transCashOutId: json["transCashOutID"],
        otpRefNo: json["otpRefNo"],
        otpRefCode: json["otpRefCode"],
        otp: json["otp"],
        topUpTransactionId: json["topUpTransactionId"],
      );

  Map<String, dynamic> toJson() => {
        "transID": transId,
        "transCashOutID": transCashOutId,
        "otpRefNo": otpRefNo,
        "otpRefCode": otpRefCode,
        "otp": otp,
        "topUpTransactionId": topUpTransactionId,
      };
}
