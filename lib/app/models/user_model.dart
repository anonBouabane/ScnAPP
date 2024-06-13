class UserModel {
  String? firstName;
  String? lastName;
  String? phone;
  String? gender;
  int? bankId;
  String? bankName;
  String? accountName;
  String? accountNumber;
  int? accountStatus;

  UserModel({
    this.firstName,
    this.lastName,
    this.phone,
    this.gender,
    this.bankId,
    this.bankName,
    this.accountName,
    this.accountNumber,
    this.accountStatus,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["firstName"] == null ? null : json["firstName"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        phone: json["phone"] == null ? null : json["phone"],
        gender: json["gender"] == null ? null : json["gender"],
        bankId: json["bankId"] == null ? null : json["bankId"],
        bankName: json["bankName"] == null ? null : json["bankName"],
        accountName: json["accountName"] == null ? null : json["accountName"],
        accountNumber: json["accountNo"] == null ? null : json["accountNo"],
        accountStatus: json["accStatus"] == null ? null : json["accStatus"],
      );

  Map<String, dynamic> toJson() => {
        "firstName": firstName == null ? null : firstName,
        "lastName": lastName == null ? null : lastName,
        "phone": phone == null ? null : phone,
        "gender": gender == null ? null : gender,
        "bankId": bankId == null ? null : bankId,
        "bankName": bankName == null ? null : bankName,
        "accountName": accountName == null ? null : accountName,
        "accountNo": accountNumber == null ? null : accountNumber,
        "accStatus": accountStatus == null ? null : accountStatus,
      };
}

class UserProfile {
  UserProfile({
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

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
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
