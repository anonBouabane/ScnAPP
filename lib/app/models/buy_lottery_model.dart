class BuyLotteryModel {
  String? customerPhone;
  String? rewardId;
  List<LotteryNumberItem>? orders;

  BuyLotteryModel({
    this.customerPhone,
    this.rewardId,
    this.orders,
  });

  factory BuyLotteryModel.fromJson(Map<String, dynamic> json) =>
      BuyLotteryModel(
        customerPhone: json["CustPhone"],
        rewardId: json["RewardId"],
        orders: List<LotteryNumberItem>.from(
            json["Orders"].map((x) => LotteryNumberItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CustPhone": customerPhone,
        "RewardId": rewardId,
        "Orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'CustPhone: $customerPhone, RewardId: $rewardId, Orders: $orders';
  }
}

class LotteryNumberItem {
  LotteryNumberItem({
    this.number,
    this.amount,
  });

  String? number;
  int? amount;

  factory LotteryNumberItem.fromJson(Map<String, dynamic> json) =>
      LotteryNumberItem(
        number: json["Number"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "Number": number,
        "Amount": amount,
      };
}
