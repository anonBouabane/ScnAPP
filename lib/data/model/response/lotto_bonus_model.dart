class BonusModel {
  BonusModel({
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

  factory BonusModel.fromJson(Map<String, dynamic> json) => BonusModel(
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
