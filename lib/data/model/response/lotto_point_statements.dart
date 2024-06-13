class PointsModel {
  PointsModel({
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

  factory PointsModel.fromJson(Map<String, dynamic> json) => PointsModel(
        balance: json["balance"],
        limit: json["limit"],
        offset: json["offset"],
        custPhone: json["custPhone"],
        statements: List<Statement>.from(json["statements"].map((x) => Statement.fromJson(x))),
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
