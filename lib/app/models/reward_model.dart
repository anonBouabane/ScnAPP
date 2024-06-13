class RewardModel {
  int? custId;
  String? rewardId;
  DateTime? expAt;

  RewardModel({
    this.custId,
    this.rewardId,
    this.expAt,
  });

  factory RewardModel.fromJson(Map<String, dynamic> json) => RewardModel(
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

class RewardItem {
  RewardItem({
    this.totalUser,
    this.totalReward,
    this.totalPendingReward,
    this.totalPaidReward,
    this.limit,
    this.offset,
    this.totalSizeDraws,
    this.totalSizeTopups,
    this.draws,
    this.topups,
  });

  int? totalUser;
  int? totalReward;
  int? totalPendingReward;
  int? totalPaidReward;
  int? limit;
  int? offset;
  int? totalSizeDraws;
  int? totalSizeTopups;
  List<DrawModel>? draws;
  List<dynamic>? topups;

  factory RewardItem.fromJson(Map<String, dynamic> json) => RewardItem(
        totalUser: json["totaluser"],
        totalReward: json["totalreward"],
        totalPendingReward: json["totalpendingreward"],
        totalPaidReward: json["totalpaidreward"],
        limit: json["limit"],
        offset: json["offset"],
        totalSizeDraws: json["totalSizeDraws"],
        totalSizeTopups: json["totalSizeTopups"],
        draws: List<DrawModel>.from(
            json["draws"].map((x) => DrawModel.fromJson(x))),
        topups: List<dynamic>.from(json["topups"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "totaluser": totalUser,
        "totalreward": totalReward,
        "totalpendingreward": totalPendingReward,
        "totalpaidreward": totalPaidReward,
        "limit": limit,
        "offset": offset,
        "totalSizeDraws": totalSizeDraws,
        "totalSizeTopups": totalSizeTopups,
        "draws": List<dynamic>.from(draws!.map((x) => x.toJson())),
        "topups": List<dynamic>.from(topups!.map((x) => x)),
      };
}

class DrawModel {
  DrawModel({
    this.drawId,
    this.drawDate,
    this.totalUser,
    this.totalAmount,
    this.estimateReward,
    this.createdDate,
  });

  int? drawId;
  String? drawDate;
  int? totalUser;
  int? totalAmount;
  String? estimateReward;
  String? createdDate;

  factory DrawModel.fromJson(Map<String, dynamic> json) => DrawModel(
        drawId: json["drawId"],
        drawDate: json["drawDate"],
        totalUser: json["totaluser"],
        totalAmount: json["totalamount"],
        estimateReward: json["estimatereward"],
        createdDate: json["createdDate"],
      );

  Map<String, dynamic> toJson() => {
        "drawId": drawId,
        "drawDate": drawDate,
        "totaluser": totalUser,
        "totalamount": totalAmount,
        "estimatereward": estimateReward,
        "createdDate": createdDate,
      };
}

class PointItem {
  PointItem({
    this.balance,
    this.limit,
    this.offset,
    this.custPhone,
    this.statements,
  });

  String? balance;
  int? limit;
  int? offset;
  String? custPhone;
  List<Statement>? statements;

  factory PointItem.fromJson(Map<String, dynamic> json) => PointItem(
        balance: json["balance"],
        limit: json["limit"],
        offset: json["offset"],
        custPhone: json["custPhone"],
        statements: List<Statement>.from(
            json["statements"].map((x) => Statement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "limit": limit,
        "offset": offset,
        "custPhone": custPhone,
        "statements": List<dynamic>.from(statements!.map((x) => x.toJson())),
      };
}

class Statement {
  Statement({
    this.datetime,
    this.paymentReferenceNo,
    this.debit,
    this.credit,
    this.description,
  });

  DateTime? datetime;
  String? paymentReferenceNo;
  String? debit;
  String? credit;
  String? description;

  factory Statement.fromJson(Map<String, dynamic> json) => Statement(
        datetime: DateTime.parse(json["datetime"]),
        paymentReferenceNo: json["paymentReferenceNo"],
        debit: json["debit"],
        credit: json["credit"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "datetime": datetime!.toIso8601String(),
        "paymentReferenceNo": paymentReferenceNo,
        "debit": debit,
        "credit": credit,
        "description": description,
      };
}

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
