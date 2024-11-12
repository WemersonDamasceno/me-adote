import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/credit_card_model.dart';

abstract class PaymentDatasource {
  Future<bool> createPaymentMethod(CreditCardEntity card);
  Future<List<CreditCardEntity>> getCards();
}

class PaymentDatasourceImpl implements PaymentDatasource {
  final storage = const FlutterSecureStorage();

  @override
  Future<bool> createPaymentMethod(CreditCardEntity card) async {
    final cardId = DateTime.now().millisecondsSinceEpoch.toString();
    await storage.write(key: 'card_$cardId', value: json.encode(card.toJson()));
    return Future.value(true);
  }

  @override
  Future<List<CreditCardEntity>> getCards() async {
    final allKeys = await storage.readAll();
    List<CreditCardEntity> cards = [];

    allKeys.forEach((key, value) {
      if (key.startsWith('card_')) {
        final Map<String, dynamic> cardData = json.decode(value);
        cards.add(CreditCardEntity.fromJson(cardData));
      }
    });

    return cards;
  }
}
