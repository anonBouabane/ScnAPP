import 'dart:convert';

BuyLotteryBody lottoLaoVietPaymentBodyFromJson(String str) =>
    BuyLotteryBody.fromJson(json.decode(str));

String lottoLaoVietPaymentBodyToJson(BuyLotteryBody data) =>
    json.encode(data.toJson());

class BuyLotteryBody {
  BuyLotteryBody({
    this.companyId,
    this.bankId,
    this.amount,
    this.payFor,
    this.transactionNo,
    this.custPhone,
  });

  int? companyId;
  int? bankId;
  int? amount;
  String? payFor;
  String? transactionNo;
  String? custPhone;

  factory BuyLotteryBody.fromJson(Map<String, dynamic> json) => BuyLotteryBody(
        companyId: json["company_id"],
        bankId: json["bank_id"],
        amount: json["amount"],
        payFor: json["pay_for"],
        transactionNo: json["transaction_no"],
        custPhone: json["cust_phone"],
      );

  Map<String, dynamic> toJson() => {
        "company_id": companyId,
        "bank_id": bankId,
        "amount": amount,
        "pay_for": payFor,
        "transaction_no": transactionNo,
        "cust_phone": custPhone,
      };
}
