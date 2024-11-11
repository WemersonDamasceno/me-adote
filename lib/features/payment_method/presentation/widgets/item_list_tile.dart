import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class ItemListTile extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool isDisabled;
  final VoidCallback onTap;

  const ItemListTile({
    super.key,
    required this.label,
    required this.iconData,
    required this.onTap,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      enabled: !isDisabled,
      leading: Icon(
        iconData,
        color: isDisabled ? AppColors.grey : AppColors.background,
      ),
      title: Text(
        label,
        style: TextStyle(
          color: isDisabled ? AppColors.grey : AppColors.background,
          fontSize: 20,
        ),
      ),
    );
  }
}
