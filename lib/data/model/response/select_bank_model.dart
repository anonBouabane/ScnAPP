import 'dart:convert';

List<SelectBankModel> selectBankModelFromJson(String str) => List<SelectBankModel>.from(json.decode(str).map((x) => SelectBankModel.fromJson(x)));

String selectBankModelToJson(List<SelectBankModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SelectBankModel {
  int? id;
  String? bankName;

  SelectBankModel({
    this.id,
    this.bankName,
  });

  factory SelectBankModel.fromJson(Map<String, dynamic> json) => SelectBankModel(
    id: json["id"],
    bankName: json["bankName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "bankName": bankName,
  };
}
