class BonusReferralModel {
  BonusReferralModel({
    this.point,
    this.bonus,
    this.referralCode,
  });

  int? point;
  int? bonus;
  String? referralCode;

  factory BonusReferralModel.fromJson(Map<String, dynamic> json) =>
      BonusReferralModel(
        point: json["point"],
        bonus: json["bonus"],
        referralCode: json["referralCode"],
      );

  Map<String, dynamic> toJson() => {
        "point": point,
        "bonus": bonus,
        "referralCode": referralCode,
      };
}
