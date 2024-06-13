class BuyLotteryResultModel {
  String? ticketId;
  int? totalAmount;
  String? sessionExpired;

  BuyLotteryResultModel({
    this.ticketId,
    this.totalAmount,
    this.sessionExpired,
  });

  factory BuyLotteryResultModel.fromJson(Map<String, dynamic> json) =>
      BuyLotteryResultModel(
        ticketId: json["ticketId"],
        totalAmount: json["totalAmount"],
        sessionExpired: json["sessionExpired"],
      );

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "totalAmount": totalAmount,
        "sessionExpired": sessionExpired,
      };
}
