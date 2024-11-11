import 'package:flutter/material.dart';

import '../../../../core/components/button/button_controller.dart';
import '../../data/models/credit_card_model.dart';
import '../../data/repositories/payment_repository.dart';

class AddCreditController {
  final PaymentRepository paymentRepository;

  AddCreditController(this.paymentRepository);

  final statusButton = ValueNotifier(ButtonStateEnum.disabled);
  final ValueNotifier<List<CreditCardModel>> creditCards = ValueNotifier([]);

  Future<void> createPaymentMethod(
    String cardNumber,
    String expiryDate,
    String cvv,
  ) async {
    try {
      statusButton.value = ButtonStateEnum.loading;
      final card = CreditCardModel(
        cardNumber: cardNumber,
        expiryDate: expiryDate,
        cvv: cvv,
      );
      await paymentRepository.createPaymentMethod(card);

      await fetchCards();

      await Future.delayed(const Duration(seconds: 1));

      statusButton.value = ButtonStateEnum.success;
    } catch (e) {
      statusButton.value = ButtonStateEnum.error;
    }
  }

  Future<List<CreditCardModel>> fetchCards() async {
    try {
      final cardList = await paymentRepository.getCards();
      creditCards.value = cardList;
      return cardList;
    } catch (e) {
      return [];
    }
  }

  String getCardBrand(String cardNumber) {
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
}
