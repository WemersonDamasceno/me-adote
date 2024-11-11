import '../datasource/payment_datasource.dart';
import '../models/credit_card_model.dart';

abstract class PaymentRepository {
  Future<List<CreditCardModel>> getCards();
  Future<bool> createPaymentMethod(CreditCardModel card);
}

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentDatasource paymentDatasource;

  PaymentRepositoryImpl(this.paymentDatasource);

  @override
  Future<List<CreditCardModel>> getCards() async {
    return paymentDatasource.getCards();
  }

  @override
  Future<bool> createPaymentMethod(CreditCardModel card) {
    return paymentDatasource.createPaymentMethod(card);
  }
}
