import 'package:flutter/material.dart';

import '../../../../core/components/button/button_controller.dart';
import '../../data/models/credit_card_model.dart';
import '../../data/repositories/payment_repository.dart';

class AddCreditController {
  final PaymentRepository paymentRepository;

  AddCreditController(this.paymentRepository);

  final statusButton = ValueNotifier(ButtonStateEnum.disabled);
  final ValueNotifier<List<CreditCardEntity>> creditCards = ValueNotifier([]);

  Future<void> createPaymentMethod(
    String cardNumber,
    String expiryDate,
    String cvv,
  ) async {
    try {
      statusButton.value = ButtonStateEnum.loading;
      final card = CreditCardEntity(
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

  Future<List<CreditCardEntity>> fetchCards() async {
    try {
      final cardList = await paymentRepository.getCards();
      creditCards.value = cardList;
      return cardList;
    } catch (e) {
      return [];
    }
  }
}
