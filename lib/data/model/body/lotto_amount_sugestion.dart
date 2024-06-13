class LottoAmountSuggestion {
  LottoAmountSuggestion({
    this.amount,
  });

  String? amount;

  factory LottoAmountSuggestion.fromJson(Map<String, dynamic> json) => LottoAmountSuggestion(
    amount: json["amount"],
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
  };
}