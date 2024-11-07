import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class InputWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Color? color;
  final Color? corText;
  final bool? showPassword;
  final String labelInput;
  final IconData? sufixIcon;
  final Widget prefixIcon;
  final GestureTapCallback? onPressIconSufix;
  final Function(String) onChanged;
  final GestureTapCallback? onPressIconPrefix;

  const InputWidget({
    super.key,
    required this.labelInput,
    required this.controller,
    required this.keyboardType,
    this.showPassword = false,
    required this.prefixIcon,
    this.onPressIconSufix,
    this.sufixIcon,
    this.onPressIconPrefix,
    this.color,
    this.corText,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return TextField(
      controller: controller,
      onChanged: (value) => onChanged(value),
      obscureText: showPassword ?? false,
      keyboardType: keyboardType,
      cursorColor: const Color(0xFF656565),
      decoration: InputDecoration(
        labelText: labelInput,
        alignLabelWithHint: true,
        labelStyle: const TextStyle(color: Color(0xFF656565)),
        contentPadding: EdgeInsets.only(right: -size.width * 0.05),
        prefixIcon: prefixIcon,
        suffixIcon: sufixIcon != null
            ? IconButton(
                onPressed: onPressIconSufix,
                icon: Icon(
                  sufixIcon,
                  color: const Color(0xFF656565),
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppColors.grey,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(7),
        ),
      ),
    );
  }
}
