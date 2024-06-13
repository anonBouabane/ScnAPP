// To parse this JSON data, do
import 'dart:convert';

LottoBuyResponse lottoBuyResponseFromJson(String str) => LottoBuyResponse.fromJson(json.decode(str));

String lottoBuyResponseToJson(LottoBuyResponse data) => json.encode(data.toJson());

class LottoBuyResponse {
  String? ticketId;
  int? totalAmount;
  String? sessionExpired;

  LottoBuyResponse({
    this.ticketId,
    this.totalAmount,
    this.sessionExpired,
  });

  factory LottoBuyResponse.fromJson(Map<String, dynamic> json) => LottoBuyResponse(
        ticketId: json["ticketId"],
        totalAmount: json["totalAmount"],
        sessionExpired: json["sessionExpired"],
      );

  Map<String, dynamic> toJson() => {
        "ticketId": ticketId,
        "totalAmount": totalAmount,
        "sessionExpired": sessionExpired,
      };
}
