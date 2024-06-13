class ContactModel {
  int? cid;
  String? address;
  String? tel;
  String? fb;
  String? wa;

  ContactModel({
    this.cid,
    this.address,
    this.tel,
    this.fb,
    this.wa,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        cid: json["cid"],
        address: json["address"],
        tel: json["tel"],
        fb: json["fb"],
        wa: json["wa"],
      );

  Map<String, dynamic> toJson() => {
        "cid": cid,
        "address": address,
        "tel": tel,
        "fb": fb,
        "wa": wa,
      };
}
