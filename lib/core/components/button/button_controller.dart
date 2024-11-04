import 'package:flutter/material.dart';

enum ButtonStateEnum {
  enabled,
  disabled,
  loading,
  success,
  error,
}

class ButtonController {
  final buttonState = ValueNotifier(ButtonStateEnum.disabled);

  void changeState(ButtonStateEnum state) {
    buttonState.value = state;
  }
}
