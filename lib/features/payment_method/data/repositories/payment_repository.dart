import '../datasource/payment_datasource.dart';
import '../models/credit_card_model.dart';

abstract class PaymentRepository {
  Future<List<CreditCardEntity>> getCards();
  Future<bool> createPaymentMethod(CreditCardEntity card);
}

class PaymentRepositoryImpl implements PaymentRepository {
  final PaymentDatasource paymentDatasource;

  PaymentRepositoryImpl(this.paymentDatasource);

  @override
  Future<List<CreditCardEntity>> getCards() async {
    return paymentDatasource.getCards();
  }

  @override
  Future<bool> createPaymentMethod(CreditCardEntity card) {
    return paymentDatasource.createPaymentMethod(card);
  }
}
