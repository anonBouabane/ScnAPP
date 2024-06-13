class LottoBuyNumber {
  LottoBuyNumber({
    this.custPhone,
    this.rewardId,
    this.orders,
  });

  String? custPhone;
  String? rewardId;
  List<LottoNumber>? orders;

  factory LottoBuyNumber.fromJson(Map<String, dynamic> json) => LottoBuyNumber(
        custPhone: json["CustPhone"],
        rewardId: json["RewardId"],
        orders: List<LottoNumber>.from(
            json["Orders"].map((x) => LottoNumber.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CustPhone": custPhone,
        "RewardId": rewardId,
        "Orders": List<dynamic>.from(orders!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'CustPhone: $custPhone, RewardId: $rewardId, Orders: $orders';
  }
}

class LottoNumber {
  LottoNumber({
    this.number,
    this.amount,
  });

  String? number;
  int? amount;

  factory LottoNumber.fromJson(Map<String, dynamic> json) => LottoNumber(
        number: json["Number"],
        amount: json["Amount"],
      );

  Map<String, dynamic> toJson() => {
        "Number": number,
        "Amount": amount,
      };
}
