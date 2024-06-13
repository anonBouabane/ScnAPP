class LottoAnimalBookModel {
  LottoAnimalBookModel({
    this.name,
    this.lotteryNo,
    this.img,
  });

  String? name;
  String? lotteryNo;
  String? img;

  factory LottoAnimalBookModel.fromJson(Map<String, dynamic> json) => LottoAnimalBookModel(
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
