import 'package:flutter/material.dart';

import '../../../../core/utils/extensions/money_extension.dart';

class BottomItemWidget extends StatelessWidget {
  final String label;
  final double value;
  const BottomItemWidget({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value.toString().money,
          style: const TextStyle(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
