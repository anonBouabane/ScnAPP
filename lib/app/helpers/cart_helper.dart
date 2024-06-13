// import 'dart:convert';
//
// import 'package:scn_easy/util/app_constants.dart';
//
// class CartHelper {
//   CartHelper._();
//
//   List<LotteryNumberItem> getCartList() {
//     List<String> numbers = [];
//     if (sharedPreferences.containsKey(AppConstants.NUMBER_LIST)) {
//       numbers = sharedPreferences.getStringList(AppConstants.NUMBER_LIST)!;
//     }
//     List<LotteryNumberItem> numberList = [];
//     for (int i = 0; i < numbers.length; i++) {
//       numberList.add(LotteryNumberItem.fromJson(jsonDecode(numbers[i])));
//     }
//     return numberList;
//   }
// }
//
// class LotteryNumberItem {
//   LotteryNumberItem({
//     this.number,
//     this.amount,
//   });
//
//   String? number;
//   int? amount;
//
//   factory LotteryNumberItem.fromJson(Map<String, dynamic> json) =>
//       LotteryNumberItem(
//         number: json["Number"],
//         amount: json["Amount"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "Number": number,
//         "Amount": amount,
//       };
// }
