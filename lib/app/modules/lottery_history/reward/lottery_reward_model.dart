class LotteryRewardModel {
  int? totalUser;
  int? totalReward;
  List<LotteryRewardItem>? items;

  LotteryRewardModel({
    this.totalUser,
    this.totalReward,
    this.items,
  });

  LotteryRewardModel copyWith({
    int? totalUser,
    int? totalReward,
    List<LotteryRewardItem>? items,
  }) =>
      LotteryRewardModel(
        totalUser: totalUser ?? this.totalUser,
        totalReward: totalReward ?? this.totalReward,
        items: items ?? this.items,
      );

  factory LotteryRewardModel.fromJson(Map<String, dynamic> json) =>
      LotteryRewardModel(
        totalUser: json["totaluser"],
        totalReward: json["totalreward"],
        items: json["items"] == null
            ? []
            : List<LotteryRewardItem>.from(
                json["items"]!.map((x) => LotteryRewardItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totaluser": totalUser,
        "totalreward": totalReward,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class LotteryRewardItem {
  int? lottoUser;
  int? totalReward;

  LotteryRewardItem({
    this.lottoUser,
    this.totalReward,
  });

  LotteryRewardItem copyWith({
    int? lottoUser,
    int? totalReward,
  }) =>
      LotteryRewardItem(
        lottoUser: lottoUser ?? this.lottoUser,
        totalReward: totalReward ?? this.totalReward,
      );

  factory LotteryRewardItem.fromJson(Map<String, dynamic> json) =>
      LotteryRewardItem(
        lottoUser: json["lottouser"],
        totalReward: json["totalreward"],
      );

  Map<String, dynamic> toJson() => {
        "lottouser": lottoUser,
        "totalreward": totalReward,
      };
}
