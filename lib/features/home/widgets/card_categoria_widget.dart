import 'package:flutter/material.dart';

class CardCategoryWidget extends StatelessWidget {
  final Function() onPressed;

  final int categorySelected;
  final String pathImage;
  final int index;
  final String title;

  const CardCategoryWidget({
    super.key,
    required this.onPressed,
    required this.categorySelected,
    required this.pathImage,
    required this.index,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            height: 50,
            width: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7),
              color: categorySelected == index
                  ? const Color(0xFFFFB228)
                  : Colors.white,
            ),
            child: Image.asset(
              pathImage,
              color: categorySelected == index ? Colors.white : Colors.black,
            ),
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
