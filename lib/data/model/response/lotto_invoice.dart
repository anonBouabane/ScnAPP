class LottoInvoice {
  LottoInvoice({
    this.limit,
    this.offset,
    this.totalSize,
    this.invoicese,
  });

  int? limit;
  int? offset;
  int? totalSize;
  List<Invoicese>? invoicese;

  factory LottoInvoice.fromJson(Map<String, dynamic> json) => LottoInvoice(
        limit: json["limit"],
        offset: json["offset"],
        totalSize: json["totalSize"],
        invoicese: List<Invoicese>.from(json["invoicese"].map((x) => Invoicese.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "totalSize": totalSize,
        "invoicese": List<dynamic>.from(invoicese!.map((x) => x.toJson())),
      };
}

class Invoicese {
  Invoicese({
    this.ticketId,
    this.totalAmount,
    this.custPhone,
    this.expireDate,
    this.lotoBillNo,
    this.billNo,
    this.lottoStatusId,
    this.drawId,
    this.drawResult,
    this.drawDate,
    this.orderDate,
    this.saleDate,
    this.orderStatus,
    this.payBy,
    this.winStatus,
    this.totalWinAmount,
    this.paymentRef,
    this.details,
  });

  String? ticketId;
  int? totalAmount;
  String? custPhone;
  DateTime? expireDate;
  String? lotoBillNo;
  dynamic billNo;
  String? lottoStatusId;
  int? drawId;
  dynamic drawResult;
  DateTime? drawDate;
  DateTime? orderDate;
  DateTime? saleDate;
  String? orderStatus;
  String? payBy;
  dynamic winStatus;
  dynamic totalWinAmount;
  String? paymentRef;
  List<Detail>? details;

  factory Invoicese.fromJson(Map<String, dynamic> json) => Invoicese(
        ticketId: json["ticketId"],
        totalAmount: json["totalAmount"],
        custPhone: json["custPhone"],
        expireDate: DateTime.parse(json["expireDate"]),
        lotoBillNo: json["lotoBillNo"],
        billNo: json["billNo"],
        lottoStatusId: json["lottoStatusId"],
        drawId: json["drawId"],
        drawResult: json["drawResult"],
        drawDate: json["drawDate"] == null ? null : DateTime.parse(json["drawDate"]),
        orderDate: json["orderDate"] == null ? null : DateTime.parse(json["orderDate"]),
        saleDate: json["saleDate"] == null ? null : DateTime.parse(json["saleDate"]),
        orderStatus: json['orderStatus'],
        payBy: json["payBy"],
        winStatus: json["winStatus"],
        totalWinAmount: json["totalWinAmount"],
        paymentRef: json["paymentRef"],
        details: List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "totalAmount": totalAmount,
        "custPhone": custPhone,
        "expireDate": expireDate!.toIso8601String(),
        "lotoBillNo": lotoBillNo,
        "billNo": billNo,
        "lottoStatusId": lottoStatusId,
        "drawId": drawId,
        "drawResult": drawResult,
        "drawDate": drawDate!.toIso8601String(),
        "orderDate": orderDate!.toIso8601String(),
        "saleDate": saleDate!.toIso8601String(),
        "orderStatus": orderStatus,
        "payBy": payBy,
        "winStatus": winStatus,
        "totalWinAmount": totalWinAmount,
        "paymentRef": paymentRef,
        "details": List<dynamic>.from(details!.map((x) => x.toJson())),
      };
}

class Detail {
  Detail({
    this.ticketId,
    this.digit,
    this.digitType,
    this.amount,
    this.winStatus,
  });

  String? ticketId;
  String? digit;
  String? digitType;
  int? amount;
  dynamic winStatus;

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        ticketId: json["ticketId"],
        digit: json["digit"],
        digitType: json["digitType"],
        amount: json["amount"],
        winStatus: json["winStatus"],
      );

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "digit": digit,
        "digitType": digitType,
        "amount": amount,
        "winStatus": winStatus,
      };
}
