class CreditCardModel {
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  CreditCardModel({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
  });

  factory CreditCardModel.fromJson(Map<String, dynamic> json) {
    return CreditCardModel(
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      cvv: json['cvv'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
    };
  }
}
