class AnimalModel {
  AnimalModel({
    this.name,
    this.lotteryNo,
    this.img,
  });

  String? name;
  String? lotteryNo;
  String? img;

  factory AnimalModel.fromJson(Map<String, dynamic> json) => AnimalModel(
        name: json["name"],
        lotteryNo: json["lotteryNo"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "lotteryNo": lotteryNo,
        "img": img,
      };
}
