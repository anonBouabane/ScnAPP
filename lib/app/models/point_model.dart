class PointModel {
  PointModel({
    this.balance,
    this.limit,
    this.offset,
    this.customerPhone,
    this.points,
  });

  String? balance;
  int? limit;
  int? offset;
  String? customerPhone;
  List<PointItem>? points;

  factory PointModel.fromJson(Map<String, dynamic> json) => PointModel(
        balance: json["balance"],
        limit: json["limit"],
        offset: json["offset"],
        customerPhone: json["custPhone"],
        points: List<PointItem>.from(
            json["statements"].map((x) => PointItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "balance": balance,
        "limit": limit,
        "offset": offset,
        "custPhone": customerPhone,
        "statements": List<dynamic>.from(points!.map((x) => x.toJson())),
      };
}

class PointItem {
  PointItem({
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

  factory PointItem.fromJson(Map<String, dynamic> json) => PointItem(
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
