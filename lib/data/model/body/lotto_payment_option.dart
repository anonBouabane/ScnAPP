class LottoPaymentOptions {
  LottoPaymentOptions({this.bankImg, this.bankName});

  String? bankImg;
  String? bankName;

  factory LottoPaymentOptions.fromJson(Map<String, dynamic> json) => LottoPaymentOptions(
        bankImg: json["bank_img"],
        bankName: json["bank_name"],
      );

  Map<String, dynamic> toJson() => {
        "bank_img": bankImg,
        "bank_name": bankName,
      };
}


