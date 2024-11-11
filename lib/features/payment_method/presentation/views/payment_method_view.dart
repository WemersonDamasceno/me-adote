import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/add_credit_controller.dart';
import '../widgets/credit_card.dart';
import 'add_credit_card.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  late AddCreditController addCreditController;

  @override
  void initState() {
    super.initState();

    addCreditController =
        Provider.of<AddCreditController>(context, listen: false);
    addCreditController.fetchCards();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        foregroundColor: Colors.white,
        title: const Text('Meus cartões'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddCreditCard()),
              ),
              child: Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add,
                      size: 32,
                      color: Colors.black54,
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Adicionar cartão de crédito',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Lista dos cartões
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: addCreditController.creditCards,
                builder: (_, creditCards, __) {
                  return ListView.builder(
                    itemCount: creditCards.length,
                    itemBuilder: (context, index) {
                      final card = creditCards[index];

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CreditCard(
                          cardNumber: card.cardNumber,
                          dateNumber: card.expiryDate,
                          cvv: card.cvv,
                        ),
                      );
                    },
                  );
                }),
          ),
        ],
      ),
    );
  }
}
