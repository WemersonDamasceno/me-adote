import 'package:flutter/material.dart';

import 'snackbar_floating.dart';

mixin SnackbarMixin {
  showSnackbarWithError({
    required BuildContext context,
    required String message,
    required String buttonLabel,
    required Color buttonColor,
    required Color backgroundColor,
    required Color fontColor,
  }) {
    return SnackbarFloating(
      context: context,
      labelSnackbar: message,
      labelButton: buttonLabel,
      snackbarBackgroundColor: backgroundColor,
      snackbarFontColor: fontColor,
      buttonBackgroundColor: buttonColor,
      margin: const EdgeInsets.only(
        bottom: 82,
        left: 24,
        right: 24,
      ),
      buttonCallback: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ).show();
  }
}
