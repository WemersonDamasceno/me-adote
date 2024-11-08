import 'package:flutter/services.dart';

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove todos os caracteres que não sejam dígitos
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Adiciona espaços após cada 4 dígitos
    if (newText.length > 4) {
      newText = newText.replaceAllMapped(
          RegExp(r'.{4}'), (match) => '${match.group(0)} ');
    }

    // Limita o tamanho máximo do texto em 19 caracteres (16 dígitos + 3 espaços)
    if (newText.length > 19) {
      newText = newText.substring(0, 19);
    }

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
