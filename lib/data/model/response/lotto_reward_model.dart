class LotteryRewardModel {
  LotteryRewardModel({
    this.result,
    this.totaluser,
    this.totalreward,
    this.totalpendingreward,
    this.draws,
    this.topups,
  });

  int? result;
  int? totaluser;
  int? totalreward;
  int? totalpendingreward;
  List<DrawReward>? draws;
  List<Topup>? topups;

  factory LotteryRewardModel.fromJson(Map<String, dynamic> json) => LotteryRewardModel(
        result: json["result"],
        totaluser: json["totaluser"],
        totalreward: json["totalreward"],
        totalpendingreward: json["totalpendingreward"],
        draws: List<DrawReward>.from(json["draws"].map((x) => DrawReward.fromJson(x))),
        topups: List<Topup>.from(json["topups"].map((x) => Topup.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "totaluser": totaluser,
        "totalreward": totalreward,
        "totalpendingreward": totalpendingreward,
        "draws": List<dynamic>.from(draws!.map((x) => x.toJson())),
        "topups": List<dynamic>.from(topups!.map((x) => x.toJson())),
      };
}

class DrawReward {
  DrawReward({
    this.drawId,
    this.drawDate,
    this.totaluser,
    this.totalamount,
    this.estimatereward,
    this.paidreward,
    this.fccref,
  });

  String? drawId;
  DateTime? drawDate;
  int? totaluser;
  int? totalamount;
  int? estimatereward;
  int? paidreward;
  String? fccref;

  factory DrawReward.fromJson(Map<String, dynamic> json) => DrawReward(
        drawId: json["draw_id"],
        drawDate: DateTime.parse(json["draw_date"]),
        totaluser: json["totaluser"],
        totalamount: json["totalamount"],
        estimatereward: json["estimatereward"],
        paidreward: json["paidreward"],
        fccref: json["fccref"],
      );

  Map<String, dynamic> toJson() => {
        "draw_id": drawId,
        "draw_date": drawDate!.toIso8601String(),
        "totaluser": totaluser,
        "totalamount": totalamount,
        "estimatereward": estimatereward,
        "paidreward": paidreward,
        "fccref": fccref,
      };
}

class Topup {
  Topup({
    this.month,
    this.totaluser,
    this.totalamount,
    this.estimatereward,
    this.paidreward,
    this.fccref,
  });

  DateTime? month;
  int? totaluser;
  int? totalamount;
  int? estimatereward;
  int? paidreward;
  String? fccref;

  factory Topup.fromJson(Map<String, dynamic> json) => Topup(
        month: DateTime.parse(json["month"]),
        totaluser: json["totaluser"],
        totalamount: json["totalamount"],
        estimatereward: json["estimatereward"],
        paidreward: json["paidreward"],
        fccref: json["fccref"],
      );

  Map<String, dynamic> toJson() => {
        "month": month!.toIso8601String(),
        "totaluser": totaluser,
        "totalamount": totalamount,
        "estimatereward": estimatereward,
        "paidreward": paidreward,
        "fccref": fccref,
      };
}
