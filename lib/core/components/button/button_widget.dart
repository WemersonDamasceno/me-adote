import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import 'button_controller.dart';

class ButtonWidget extends StatelessWidget {
  final ButtonStateEnum buttonState;
  final Function() onPressed;
  final String textButton;
  final Color backgroundColor;

  const ButtonWidget({
    super.key,
    required this.onPressed,
    required this.textButton,
    required this.buttonState,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Color getBackgroundColor() {
      switch (buttonState) {
        case ButtonStateEnum.success:
          return Colors.green;
        case ButtonStateEnum.error:
          return Colors.red;
        case ButtonStateEnum.enabled:
          return backgroundColor;
        case ButtonStateEnum.disabled:
          return AppColors.grey;
        default:
          return backgroundColor;
      }
    }

    Widget getChild() {
      switch (buttonState) {
        case ButtonStateEnum.loading:
          return const CircularProgressIndicator(
            color: Colors.white,
          );
        case ButtonStateEnum.success:
          return const Icon(
            Icons.check,
            color: Colors.white,
            size: 28,
          );
        case ButtonStateEnum.error:
          return const Icon(
            Icons.error,
            color: Colors.white,
            size: 28,
          );
        case ButtonStateEnum.enabled:
        case ButtonStateEnum.disabled:
        default:
          return Text(
            textButton,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          );
      }
    }

    return Center(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: size.height * 0.07,
        width: buttonState == ButtonStateEnum.loading ||
                buttonState == ButtonStateEnum.success ||
                buttonState == ButtonStateEnum.error
            ? size.height * 0.07
            : size.width,
        decoration: BoxDecoration(
          color: getBackgroundColor(),
          borderRadius: BorderRadius.circular(
              buttonState == ButtonStateEnum.loading ||
                      buttonState == ButtonStateEnum.success ||
                      buttonState == ButtonStateEnum.error
                  ? 1000
                  : 8),
        ),
        child: buttonState == ButtonStateEnum.enabled
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed:
                    buttonState == ButtonStateEnum.enabled ? onPressed : null,
                child: getChild(),
              )
            : Center(child: getChild()),
      ),
    );
  }
}
