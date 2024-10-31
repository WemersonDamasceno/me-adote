import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController entradaController;
  final TextInputType entradaTipo;
  final Color? color;
  final Color? corText;
  final bool? mostrarSenha;
  final String labelInput;
  final IconData? sufixIcon;
  final Widget prefixIcon;
  final GestureTapCallback? onPressIconSufix;
  final GestureTapCallback? onPressIconPrefix;

  const InputWidget({
    Key? key,
    required this.labelInput,
    required this.entradaController,
    required this.entradaTipo,
    required this.mostrarSenha,
    required this.prefixIcon,
    this.onPressIconSufix,
    this.sufixIcon,
    this.onPressIconPrefix,
    this.color,
    this.corText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return TextFormField(
      obscureText: mostrarSenha ?? false,
      controller: entradaController,
      keyboardType: entradaTipo,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(right: -size.width * 0.05),
        labelText: labelInput,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        prefixIcon: prefixIcon,
        suffixIcon: IconButton(
          icon: Icon(
            sufixIcon,
            color: const Color(0xFF656565),
          ),
          onPressed: onPressIconSufix,
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Preencha este campo!";
        }
        //Se for email, verificar se possui mais de 6 caracteres!
        if (entradaTipo.toString() ==
                TextInputType.visiblePassword.toString() &&
            value.length < 6) {
          return "A senha deve ter no minimo 6 digitos!";
        }

        //Se for email, verificar se o formato é valido!
        if (entradaTipo.toString() == TextInputType.emailAddress.toString()) {
          String pattern =
              r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
          RegExp regExp = RegExp(pattern);
          if (!regExp.hasMatch(value)) {
            return "Este formato de email é inválido!";
          } else {
            return null;
          }
        }

        return null;
      },
    );
  }
}
