class LottoRewardIdResponse {
  int? custId;
  String? rewardId;
  DateTime? expAt;

  LottoRewardIdResponse({
    this.custId,
    this.rewardId,
    this.expAt,
  });

  factory LottoRewardIdResponse.fromJson(Map<String, dynamic> json) => LottoRewardIdResponse(
    custId: json["custId"],
    rewardId: json["rewardId"],
    expAt: DateTime.parse(json["expAt"]),
  );

  Map<String, dynamic> toJson() => {
    "custId": custId,
    "rewardId": rewardId,
    "expAt": expAt!.toIso8601String(),
  };
}
