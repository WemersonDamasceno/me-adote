import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/credit_card_model.dart';

abstract class PaymentDatasource {
  Future<bool> createPaymentMethod(CreditCardModel card);
  Future<List<CreditCardModel>> getCards();
}

class PaymentDatasourceImpl implements PaymentDatasource {
  final storage = const FlutterSecureStorage();

  @override
  Future<bool> createPaymentMethod(CreditCardModel card) async {
    final cardId = DateTime.now().millisecondsSinceEpoch.toString();
    await storage.write(key: 'card_$cardId', value: json.encode(card.toJson()));
    return Future.value(true);
  }

  @override
  Future<List<CreditCardModel>> getCards() async {
    final allKeys = await storage.readAll();
    List<CreditCardModel> cards = [];

    allKeys.forEach((key, value) {
      if (key.startsWith('card_')) {
        final Map<String, dynamic> cardData = json.decode(value);
        cards.add(CreditCardModel.fromJson(cardData));
      }
    });

    return cards;
  }
}
