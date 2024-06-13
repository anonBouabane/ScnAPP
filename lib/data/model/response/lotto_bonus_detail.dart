class BonusDetailModel {
  BonusDetailModel({
    this.totaluser,
    this.totalreward,
    this.items,
  });

  int? totaluser;
  int? totalreward;
  List<ItemModel>? items;

  factory BonusDetailModel.fromJson(Map<String, dynamic> json) => BonusDetailModel(
        totaluser: json["totaluser"],
        totalreward: json["totalreward"],
        items: List<ItemModel>.from(json["items"].map((x) => ItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "totaluser": totaluser,
        "totalreward": totalreward,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class ItemModel {
  ItemModel({
    this.lottouser,
    this.totalreward,
  });

  String? lottouser;
  int? totalreward;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        lottouser: json["lottouser"],
        totalreward: json["totalreward"],
      );

  Map<String, dynamic> toJson() => {
        "lottouser": lottouser,
        "totalreward": totalreward,
      };
}
