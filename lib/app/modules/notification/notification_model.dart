import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  List<NotificationItem>? notifications;

  NotificationModel({
    this.notifications,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        notifications: json["notifications"] == null
            ? []
            : List<NotificationItem>.from(json["notifications"]!
                .map((x) => NotificationItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "notifications": notifications == null
            ? []
            : List<dynamic>.from(notifications!.map((x) => x.toJson())),
      };
}

class NotificationItem {
  int? id;
  String? title;
  String? body;
  int? customerId;
  dynamic orderId;
  DateTime? pushDate;

  NotificationItem({
    this.id,
    this.title,
    this.body,
    this.customerId,
    this.orderId,
    this.pushDate,
  });

  factory NotificationItem.fromJson(Map<String, dynamic> json) =>
      NotificationItem(
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
