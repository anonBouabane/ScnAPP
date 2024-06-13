import 'dart:convert';

LottoLaoVietPaymentBody lottoLaoVietPaymentBodyFromJson(String str) => LottoLaoVietPaymentBody.fromJson(json.decode(str));

String lottoLaoVietPaymentBodyToJson(LottoLaoVietPaymentBody data) => json.encode(data.toJson());

class LottoLaoVietPaymentBody {
  LottoLaoVietPaymentBody({
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

  factory LottoLaoVietPaymentBody.fromJson(Map<String, dynamic> json) => LottoLaoVietPaymentBody(
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
