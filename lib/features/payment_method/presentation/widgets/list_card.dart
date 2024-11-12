import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

import '../../data/models/credit_card_model.dart';
import 'credit_card.dart';

class RotatingCardSwiper extends StatelessWidget {
  final List<CreditCardEntity> creditCards;

  const RotatingCardSwiper({super.key, required this.creditCards});

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemCount: creditCards.length,
      itemWidth: MediaQuery.of(context).size.width,
      itemHeight: 250,
      layout: SwiperLayout.STACK,
      scrollDirection: Axis.vertical,
      onIndexChanged: (index) {},
      duration: 500,
      itemBuilder: (context, index) {
        final card = creditCards[index];

        return AnimatedBuilder(
          animation: SwiperController(),
          builder: (context, child) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: CreditCard(
                cardNumber: card.cardNumber,
                cvv: card.cvv,
                dateNumber: card.expiryDate,
                flagImage: CreditCardEntity.getCardBrand(card.cardNumber),
              ),
            );
          },
        );
      },
    );
  }
}
