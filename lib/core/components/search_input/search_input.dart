import 'package:flutter/material.dart';

import '../../constants/colors_constants.dart';

class SearchInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final VoidCallback? onTap;
  final bool readOnly;

  const SearchInput({
    super.key,
    required this.controller,
    required this.hintText,
    this.onTap,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      cursorColor: AppColors.grey,
      decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(right: -20),
          hintText: hintText,
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
          prefixIcon: const Icon(Icons.search_rounded),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(7),
            ),
          )),
    );
  }
}
