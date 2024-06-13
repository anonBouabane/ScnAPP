class ProfileModel {
  ProfileModel({
    this.firstname,
    this.lastname,
    this.phone,
    this.gender,
    this.bankId,
    this.bankName,
    this.accountName,
    this.accountNo,
  });

  String? firstname;
  String? lastname;
  String? phone;
  String? gender;
  int? bankId;
  String? bankName;
  String? accountName;
  String? accountNo;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        firstname: json["firstname"] == null ? null : json["firstname"],
        lastname: json["lastname"] == null ? null : json["lastname"],
        phone: json["phone"] == null ? null : json["phone"],
        gender: json["gender"] == null ? null : json["gender"],
        bankId: json["bankId"] == null ? null : json["bankId"],
        bankName: json["bankName"] == null ? null : json["bankName"],
        accountName: json["accountName"] == null ? null : json["accountName"],
        accountNo: json["accountNo"] == null ? null : json["accountNo"],
      );

  Map<String, dynamic> toJson() => {
        "firstname": firstname == null ? null : firstname,
        "lastname": lastname == null ? null : lastname,
        "phone": phone == null ? null : phone,
        "gender": gender == null ? null : gender,
        "bankId": bankId == null ? null : bankId,
        "bankName": bankName == null ? null : bankName,
        "accountName": accountName == null ? null : accountName,
        "accountNo": accountNo == null ? null : accountNo,
      };
}
