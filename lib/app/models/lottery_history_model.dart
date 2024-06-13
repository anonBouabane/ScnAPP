class LotteryHistoryModel {
  LotteryHistoryModel({
    this.limit,
    this.offset,
    this.totalSize,
    this.drawTime,
    this.draws,
  });

  int? limit;
  int? offset;
  int? totalSize;
  String? drawTime;
  List<DrawItem>? draws;

  factory LotteryHistoryModel.fromJson(Map<String, dynamic> json) =>
      LotteryHistoryModel(
        limit: json["limit"],
        offset: json["offset"],
        totalSize: json["totalSize"],
        drawTime: json["drawtime"],
        draws:
            List<DrawItem>.from(json["draws"].map((x) => DrawItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "totalSize": totalSize,
        "drawtime": drawTime,
        "draws": List<dynamic>.from(draws!.map((x) => x.toJson())),
      };
}

class DrawItem {
  DrawItem({this.roundNo, this.roundDate, this.winNumber});

  int? roundNo;
  String? roundDate;
  String? winNumber;

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
