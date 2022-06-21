import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Size size;
  final Function() onPressed;
  final String textoButton;

  const ButtonWidget(
      {Key? key,
      required this.size,
      required this.onPressed,
      required this.textoButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size.height * 0.07,
      width: size.width,
      child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            textoButton,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          )),
    );
  }
}
