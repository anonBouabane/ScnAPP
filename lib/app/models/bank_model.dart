// To parse this JSON data, do
//
//     final bankModel = bankModelFromJson(jsonString);

import 'dart:convert';

List<BankModel> bankModelFromJson(String str) =>
    List<BankModel>.from(json.decode(str).map((x) => BankModel.fromJson(x)));

String bankModelToJson(List<BankModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BankModel {
  int? bankId;
  String? bankName;
  String? mcId;
  String? accountName;
  String? accountNumber;
  int? companyId;
  String? accountCurrency;
  String? bankLogo;

  BankModel({
    this.bankId,
    this.bankName,
    this.mcId,
    this.accountName,
    this.accountNumber,
    this.companyId,
    this.accountCurrency,
    this.bankLogo,
  });

  BankModel copyWith({
    int? bankId,
    String? bankName,
    String? mcId,
    String? accountName,
    String? accountNumber,
    int? companyId,
    String? accountCurrency,
    String? bankLogo,
  }) =>
      BankModel(
        bankId: bankId ?? this.bankId,
        bankName: bankName ?? this.bankName,
        mcId: mcId ?? this.mcId,
        accountName: accountName ?? this.accountName,
        accountNumber: accountNumber ?? this.accountNumber,
        companyId: companyId ?? this.companyId,
        accountCurrency: accountCurrency ?? this.accountCurrency,
        bankLogo: bankLogo ?? this.bankLogo,
      );

  factory BankModel.fromJson(Map<String, dynamic> json) => BankModel(
        bankId: json["bankId"],
        bankName: json["bankName"],
        mcId: json["mcId"],
        accountName: json["accName"],
        accountNumber: json["accNo"],
        companyId: json["companyId"],
        accountCurrency: json["accCcy"],
        bankLogo: json["bankLogo"],
      );

  Map<String, dynamic> toJson() => {
        "bankId": bankId,
        "bankName": bankName,
        "mcId": mcId,
        "accName": accountName,
        "accNo": accountNumber,
        "companyId": companyId,
        "accCcy": accountCurrency,
        "bankLogo": bankLogo,
      };
}

class BankItem {
  int? id;
  String? bankName;

  BankItem({
    this.id,
    this.bankName,
  });

  factory BankItem.fromJson(Map<String, dynamic> json) => BankItem(
        id: json["id"],
        bankName: json["bankName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bankName": bankName,
      };
}
