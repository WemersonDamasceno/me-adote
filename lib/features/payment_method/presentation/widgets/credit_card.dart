import 'package:flutter/material.dart';

class CreditCard extends StatelessWidget {
  final String cardNumber;
  final String dateNumber;
  final String flagImage;
  final String cvv;
  final Animation<double> flipAnimation;

  const CreditCard({
    super.key,
    required this.cardNumber,
    required this.dateNumber,
    required this.cvv,
    this.flipAnimation = const AlwaysStoppedAnimation(0.0),
    required this.flagImage,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: flipAnimation,
      builder: (context, child) {
        // Animação para o giro do cartão
        final rotation =
            Tween<double>(begin: 0, end: 3.14).animate(flipAnimation);

        return Transform(
          transform: Matrix4.rotationY(rotation.value),
          alignment: Alignment.center,
          child: Container(
            width: double.infinity,
            height: 220,
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [
                Colors.lightBlueAccent,
                Colors.blueAccent,
                Colors.indigo,
              ]),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: rotation.value < 1.57
                ? _buildFront()
                : Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.rotationY(3.14),
                    child: _buildBack(),
                  ),
          ),
        );
      },
    );
  }

  Widget _buildFront() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topRight,
          child: Image.asset(
            'assets/images/flags_cards/$flagImage.png',
            width: 50,
            height: 50,
          ),
        ),
        Row(
          children: [
            Image.asset(
              'assets/images/chip.png',
              width: 40,
              height: 40,
            ),
            Image.asset(
              'assets/images/aproximacao.png',
              color: Colors.white,
              width: 40,
              height: 40,
            ),
          ],
        ),
        const SizedBox(height: 8),
        // Número do cartão
        Text(
          cardNumber.isEmpty ? '0000 0000 0000 0000' : cardNumber,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBack() {
    return Column(
      children: [
        const Spacer(),
        // Validade e CVV
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Validade',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  dateNumber.isEmpty ? 'MM/AA' : dateNumber,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text(
                  'CVV',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  cvv.isEmpty ? '***' : cvv,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
