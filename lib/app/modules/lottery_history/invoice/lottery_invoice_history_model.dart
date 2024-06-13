class LotteryInvoiceHistoryModel {
  int? limit;
  int? offset;
  int? totalSize;
  List<LotteryInvoiceHistoryItem>? lotteryHistories;

  LotteryInvoiceHistoryModel({
    this.limit,
    this.offset,
    this.totalSize,
    this.lotteryHistories,
  });

  factory LotteryInvoiceHistoryModel.fromJson(Map<String, dynamic> json) =>
      LotteryInvoiceHistoryModel(
        limit: json["limit"],
        offset: json["offset"],
        totalSize: json["totalSize"],
        lotteryHistories: json["invoicese"] == null
            ? []
            : List<LotteryInvoiceHistoryItem>.from(json["invoicese"]!
                .map((x) => LotteryInvoiceHistoryItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "limit": limit,
        "offset": offset,
        "totalSize": totalSize,
        "invoicese": lotteryHistories == null
            ? []
            : List<dynamic>.from(lotteryHistories!.map((x) => x.toJson())),
      };
}

class LotteryInvoiceHistoryItem {
  String? ticketId;
  int? totalAmount;
  String? customerPhone;
  DateTime? expireDate;
  String? lotteryBillNumber;
  String? billNumber;
  String? lotteryStatusId;
  int? drawId;
  String? drawResult;
  DateTime? drawDate;
  DateTime? orderDate;
  DateTime? saleDate;
  String? orderStatus;
  String? payBy;
  String? paymentReference;
  bool? winStatus;
  int? totalWinAmount;
  List<LotteryInvoiceHistoryDetailItem>? lotteryHistoryDetails;

  LotteryInvoiceHistoryItem({
    this.ticketId,
    this.totalAmount,
    this.customerPhone,
    this.expireDate,
    this.lotteryBillNumber,
    this.billNumber,
    this.lotteryStatusId,
    this.drawId,
    this.drawResult,
    this.drawDate,
    this.orderDate,
    this.saleDate,
    this.orderStatus,
    this.payBy,
    this.paymentReference,
    this.winStatus,
    this.totalWinAmount,
    this.lotteryHistoryDetails,
  });

  factory LotteryInvoiceHistoryItem.fromJson(Map<String, dynamic> json) =>
      LotteryInvoiceHistoryItem(
        ticketId: json["ticketId"],
        totalAmount: json["totalAmount"],
        customerPhone: json["custPhone"],
        expireDate: json["expireDate"] == null
            ? null
            : DateTime.parse(json["expireDate"]),
        lotteryBillNumber: json["lotoBillNo"],
        billNumber: json["billNo"],
        lotteryStatusId: json["lottoStatusId"],
        drawId: json["drawId"],
        drawResult: json["drawResult"],
        drawDate:
            json["drawDate"] == null ? null : DateTime.parse(json["drawDate"]),
        orderDate: json["orderDate"] == null
            ? null
            : DateTime.parse(json["orderDate"]),
        saleDate:
            json["saleDate"] == null ? null : DateTime.parse(json["saleDate"]),
        orderStatus: json["orderStatus"],
        payBy: json["payBy"],
        paymentReference: json["paymentRef"],
        winStatus: json["winStatus"],
        totalWinAmount: json["totalWinAmount"],
        lotteryHistoryDetails: json["details"] == null
            ? []
            : List<LotteryInvoiceHistoryDetailItem>.from(json["details"]!
                .map((x) => LotteryInvoiceHistoryDetailItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "totalAmount": totalAmount,
        "custPhone": customerPhone,
        "expireDate": expireDate?.toIso8601String(),
        "lotoBillNo": lotteryBillNumber,
        "billNo": billNumber,
        "lottoStatusId": lotteryStatusId,
        "drawId": drawId,
        "drawResult": drawResult,
        "drawDate": drawDate?.toIso8601String(),
        "orderDate": orderDate?.toIso8601String(),
        "saleDate": saleDate?.toIso8601String(),
        "orderStatus": orderStatus,
        "payBy": payBy,
        "paymentRef": paymentReference,
        "winStatus": winStatus,
        "totalWinAmount": totalWinAmount,
        "details": lotteryHistoryDetails == null
            ? []
            : List<dynamic>.from(lotteryHistoryDetails!.map((x) => x.toJson())),
      };
}

class LotteryInvoiceHistoryDetailItem {
  String? ticketId;
  String? digit;
  String? digitType;
  int? amount;
  bool? winStatus;

  LotteryInvoiceHistoryDetailItem({
    this.ticketId,
    this.digit,
    this.digitType,
    this.amount,
    this.winStatus,
  });

  factory LotteryInvoiceHistoryDetailItem.fromJson(Map<String, dynamic> json) =>
      LotteryInvoiceHistoryDetailItem(
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
