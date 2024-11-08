import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constants/app_colors.dart';

class SearchInput extends StatelessWidget {
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final Function(String value)? onChanged;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String hintText;
  final bool readOnly;
  final FocusNode? focusNode;
  final int? maxLength;

  const SearchInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.onTap,
    this.prefixIcon,
    this.onChanged,
    this.inputFormatters,
    this.readOnly = false,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.maxLength,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      focusNode: focusNode,
      maxLength: maxLength,
      readOnly: readOnly,
      keyboardType: keyboardType,
      onChanged: onChanged != null ? (value) => onChanged!(value) : null,
      inputFormatters: inputFormatters,
      cursorColor: AppColors.background,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.grey),
        alignLabelWithHint: true,
        filled: true,
        fillColor: Colors.white,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
        prefixIcon: prefixIcon,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(7),
          ),
        ),
      ),
    );
  }
}
