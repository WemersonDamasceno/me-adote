import 'package:flutter/material.dart';

class CardCategoriaWidget extends StatelessWidget {
  final Function() onPressed;

  final int indexCategoriaSelecionada;
  final String pathImage;
  final int index;
  final String titulo;

  const CardCategoriaWidget({
    Key? key,
    required this.onPressed,
    required this.indexCategoriaSelecionada,
    required this.pathImage,
    required this.index,
    required this.titulo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: onPressed,
            child: Container(
              height: 50,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: indexCategoriaSelecionada == index
                    ? const Color(0xFFFFB228)
                    : Colors.white,
              ),
              child: Image.asset(
                pathImage,
                color: indexCategoriaSelecionada == index
                    ? Colors.white
                    : Colors.black,
              ),
            ),
          ),
          Text(
            titulo,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
