class UserInfoModel {
  UserInfoModel({
    this.id,
    this.firstname,
    this.lastname,
    this.phone,
    this.image,
    this.bankName,
    this.bankId,
    this.accountName,
    this.accountNo,
    this.gender,
    this.accStatus, // ---- add by thin
  });

  int? id;
  String? firstname;
  String? lastname;
  String? phone;
  String? image;
  String? bankName;
  int? bankId;
  String? accountName;
  String? accountNo;
  String? gender;
  int? accStatus; // ---- add by thin

  factory UserInfoModel.fromJson(Map<String, dynamic> json) => UserInfoModel(
        id: json["id"] == null ? null : json["id"],
        firstname: json["firstName"] == null ? null : json["firstName"],
        lastname: json["lastName"] == null ? null : json["lastName"],
        phone: json["phone"] == null ? null : json["phone"],
        image: json["image"] == null ? null : json["image"],
        bankName: json["bankName"] == null ? null : json["bankName"],
        bankId: json["bankId"] == null ? null : json["bankId"],
        accountName: json["accountName"] == null ? null : json["accountName"],
        accountNo: json["accountNo"] == null ? null : json["accountNo"],
        gender: json["gender"] == null ? null : json["gender"],
        accStatus: json["accStatus"] == null
            ? null
            : json["accStatus"], // ---- add by thin
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "firstName": firstname == null ? null : firstname,
        "lastName": lastname == null ? null : lastname,
        "phone": phone == null ? null : phone,
        "image": image == null ? null : image,
        "bankName": bankName == null ? null : bankName,
        "bankId": bankId == null ? null : bankId,
        "accountName": accountName == null ? null : accountName,
        "accountNo": accountNo == null ? null : accountNo,
        "gender": gender == null ? null : gender,
        "accStatus": accStatus == null ? null : accStatus, // ---- add by thin
      };
}
