class LotteryHistoryModel {
  LotteryHistoryModel({
    this.limit,
    this.offset,
    // this.servertime,
    this.totlaSize,
    this.drawtime,
    this.draws,
  });

  int? limit;
  int? offset;
  // String? servertime;
  int? totlaSize;
  String? drawtime;
  List<Draw>? draws;

  factory LotteryHistoryModel.fromJson(Map<String, dynamic> json) =>
      LotteryHistoryModel(
        limit: json["limit"],
        offset: json["offset"],
        // servertime: json["servertime"],
        totlaSize: json["totalSize"],
        drawtime: json["drawtime"],
        draws: List<Draw>.from(json["draws"].map((x) => Draw.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        // "servertime": servertime,
        "totalSize": totlaSize,
        "drawtime": drawtime,
        "draws": List<dynamic>.from(draws!.map((x) => x.toJson())),
      };
}

class Draw {
  Draw({this.roundNo, this.roundDate, this.winNumber});

  int? roundNo;
  String? roundDate;
  String? winNumber;

  factory Draw.fromJson(Map<String, dynamic> json) => Draw(
        roundNo: json["roundNo"],
        roundDate: json["roundDate"],
        winNumber: json["winNumber"],
      );

  Map<String, dynamic> toJson() => {
        "roundNo": roundNo,
        "roundDate": roundDate,
        "winNumber": winNumber,
      };
}
