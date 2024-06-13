class LotteryResultHistoryModel {
  int? limit;
  int? offset;
  int? totalSize;
  String? serverTime;
  String? drawTime;
  List<DrawItem>? draws;

  LotteryResultHistoryModel({
    this.limit,
    this.offset,
    this.totalSize,
    this.serverTime,
    this.drawTime,
    this.draws,
  });

  factory LotteryResultHistoryModel.fromJson(Map<String, dynamic> json) =>
      LotteryResultHistoryModel(
        limit: json["limit"],
        offset: json["offset"],
        totalSize: json["totalSize"],
        serverTime: json["servertime"],
        drawTime: json["drawtime"],
        draws: json["draws"] == null
            ? []
            : List<DrawItem>.from(
                json["draws"]!.map((x) => DrawItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "totalSize": totalSize,
        "servertime": serverTime,
        "drawtime": drawTime,
        "draws": draws == null
            ? []
            : List<dynamic>.from(draws!.map((x) => x.toJson())),
      };
}

class DrawItem {
  int? roundNo;
  String? roundDate;
  String? winNumber;

  DrawItem({
    this.roundNo,
    this.roundDate,
    this.winNumber,
  });

  factory DrawItem.fromJson(Map<String, dynamic> json) => DrawItem(
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
