class LottoPointPayment {
  LottoPointPayment({
    this.status,
    this.msg,
  });

  String? status;
  String? msg;

  factory LottoPointPayment.fromJson(Map<String, dynamic> json) => LottoPointPayment(
        status: json["status"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
      };
}
