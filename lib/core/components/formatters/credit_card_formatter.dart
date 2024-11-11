import 'package:flutter/services.dart';

class CreditCardFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Remove todos os caracteres que não sejam dígitos
    String newText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Armazena a posição atual do cursor
    int selectionIndex = newValue.selection.end;

    // Adiciona espaços após cada 4 dígitos
    final buffer = StringBuffer();
    for (int i = 0; i < newText.length; i++) {
      if (i != 0 && i % 4 == 0) {
        buffer.write(' ');

        // Ajusta a posição do cursor se ele for afetado pela adição de um espaço
        if (i < selectionIndex) {
          selectionIndex++;
        }
      }
      buffer.write(newText[i]);
    }

    // Converte o buffer para String
    String formattedText = buffer.toString();

    // Limita o tamanho máximo do texto em 19 caracteres (16 dígitos + 3 espaços)
    if (formattedText.length > 19) {
      formattedText = formattedText.substring(0, 19);
    }

    // Garante que a posição do cursor não ultrapasse o comprimento do texto formatado
    selectionIndex = selectionIndex.clamp(0, formattedText.length);

    // Ajusta o cursor se ele estiver em uma posição de espaço
    if (selectionIndex > 0 &&
        selectionIndex < formattedText.length &&
        formattedText[selectionIndex - 1] == ' ') {
      selectionIndex--;
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
