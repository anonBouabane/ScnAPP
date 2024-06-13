import 'dart:convert';

List<LottoBankPaymentOptions> lottoBankPaymentOptionsFromJson(String str) => List<LottoBankPaymentOptions>.from(json.decode(str).map((x) => LottoBankPaymentOptions.fromJson(x)));

String lottoBankPaymentOptionsToJson(List<LottoBankPaymentOptions> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class LottoBankPaymentOptions {
  LottoBankPaymentOptions({
    this.bankId,
    this.bankName,
    this.mcId,
    this.accName,
    this.accNo,
    this.companyId,
    this.accCcy,
    this.bankLogo,
  });

  int? bankId;
  String? bankName;
  String? mcId;
  String? accName;
  String? accNo;
  int? companyId;
  String? accCcy;
  String? bankLogo;

  factory LottoBankPaymentOptions.fromJson(Map<String, dynamic> json) => LottoBankPaymentOptions(
    bankId: json["bankId"],
    bankName: json["bankName"],
    mcId: json["mcId"],
    accName: json["accName"],
    accNo: json["accNo"],
    companyId: json["companyId"],
    accCcy: json["accCcy"],
    bankLogo: json["bankLogo"],
  );

  Map<String, dynamic> toJson() => {
    "bankId": bankId,
    "bankName": bankName,
    "mcId": mcId,
    "accName": accName,
    "accNo": accNo,
    "companyId": companyId,
    "accCcy": accCcy,
    "bankLogo": bankLogo,
  };
}
