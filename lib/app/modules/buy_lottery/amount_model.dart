class AmountModel {
  AmountModel({
    this.amount,
  });

  String? amount;

  factory AmountModel.fromJson(Map<String, dynamic> json) => AmountModel(
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
      };
}
