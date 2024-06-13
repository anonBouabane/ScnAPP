class NotifyModel {
  List<NotifyItem>? notifications;

  NotifyModel({
    this.notifications,
  });

  factory NotifyModel.fromJson(Map<String, dynamic> json) => NotifyModel(
        notifications: json["notifications"] == null
            ? []
            : List<NotifyItem>.from(
                json["notifications"]!.map((x) => NotifyItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class NotifyItem {
  int? id;
  String? title;
  String? body;
  int? customerId;
  dynamic orderId;
  DateTime? pushDate;

  NotifyItem({
    this.id,
    this.title,
    this.body,
    this.customerId,
    this.orderId,
    this.pushDate,
  });

  factory NotifyItem.fromJson(Map<String, dynamic> json) => NotifyItem(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        customerId: json["customerId"],
        orderId: json["orderId"],
        pushDate:
            json["pushDate"] == null ? null : DateTime.parse(json["pushDate"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "customerId": customerId,
        "orderId": orderId,
        "pushDate": pushDate?.toIso8601String(),
      };
}
