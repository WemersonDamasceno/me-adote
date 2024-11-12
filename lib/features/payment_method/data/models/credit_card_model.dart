class CreditCardEntity {
  final String cardNumber;
  final String expiryDate;
  final String cvv;

  CreditCardEntity({
    required this.cardNumber,
    required this.expiryDate,
    required this.cvv,
  });

  factory CreditCardEntity.fromJson(Map<String, dynamic> json) {
    return CreditCardEntity(
      cardNumber: json['cardNumber'],
      expiryDate: json['expiryDate'],
      cvv: json['cvv'],
    );
  }

  static String getCardBrand(String cardNumber) {
    // Remove espaços em branco
    cardNumber = cardNumber.replaceAll(' ', '');

    // Verifica se o número do cartão é válido
    if (cardNumber.isEmpty || cardNumber.length < 13) {
      return 'no_flag';
    }

    // Identificação da bandeira com base nos prefixos
    if (RegExp(r'^4[0-9]{6,}$').hasMatch(cardNumber)) {
      return 'visa';
    } else if (RegExp(r'^5[1-5][0-9]{5,}$').hasMatch(cardNumber)) {
      return 'mastercard';
    } else if (RegExp(r'^(606282|637095|627780|504175|451416|636297)[0-9]{0,}$')
        .hasMatch(cardNumber)) {
      return 'elo';
    } else if (RegExp(
            r'^(6061|4011|438935|4576|5041|5067|5090|6361|6275)[0-9]{0,}$')
        .hasMatch(cardNumber)) {
      return 'hipercard';
    }

    return 'no_flag';
  }

  Map<String, dynamic> toJson() {
    return {
      'cardNumber': cardNumber,
      'expiryDate': expiryDate,
      'cvv': cvv,
    };
  }
}
