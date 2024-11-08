import 'package:flutter/services.dart';

class DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove todos os caracteres que não são dígitos
    final newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    // Limitar o tamanho a 4 caracteres (MMYY)
    if (newText.length > 4) {
      return oldValue;
    }

    // Adicionar a barra após o segundo dígito (MM/AA)
    String formattedText = '';
    if (newText.length >= 2) {
      formattedText = '${newText.substring(0, 2)}/${newText.substring(2)}';
    } else {
      formattedText = newText;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
