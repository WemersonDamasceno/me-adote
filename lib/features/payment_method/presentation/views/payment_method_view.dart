import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/app_colors.dart';
import '../controllers/add_credit_controller.dart';
import '../widgets/credit_card.dart';
import '../widgets/item_list_tile.dart';
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
              onTap: () => _openAddCreditCard(context),
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
                      'Adicionar cartão',
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
                return Swiper(
                  itemWidth: 400,
                  layout: SwiperLayout.CUSTOM,
                  customLayoutOption:
                      CustomLayoutOption(startIndex: -1, stateCount: 3)
                        ..addRotate([-45.0 / 180, 0.0, 45.0 / 180])
                        ..addTranslate([
                          const Offset(-370.0, -40.0),
                          const Offset(0.0, 0.0),
                          const Offset(370.0, -40.0)
                        ]),
                  itemHeight: 250,
                  loop: true,
                  duration: 500,
                  itemCount: creditCards.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final card = creditCards[index];

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CreditCard(
                        cardNumber: card.cardNumber,
                        cvv: card.cvv,
                        dateNumber: card.expiryDate,
                        flagImage: addCreditController.getCardBrand(
                          card.cardNumber,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  _openAddCreditCard(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (context) => SizedBox(
        height: 300,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            Text(
              'Adicionar cartão',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const Spacer(),
            ItemListTile(
                label: 'Cartão de crédito',
                iconData: Icons.add_card,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddCreditCard(),
                    ),
                  );
                }),
            const Divider(color: AppColors.grey),
            ItemListTile(
              isDisabled: true,
              label: 'Cartão de debito',
              iconData: Icons.add_card,
              onTap: () {},
            ),
            const Divider(color: AppColors.grey),
            ItemListTile(
              onTap: () => Navigator.of(context).pop(),
              label: 'Cancelar',
              iconData: Icons.close,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
