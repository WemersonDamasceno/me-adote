import 'package:flutter/material.dart';

class SnackbarFloating extends StatefulWidget {
  final BuildContext context;
  final String labelSnackbar;
  final String labelButton;
  final Color snackbarBackgroundColor;
  final Color snackbarFontColor;
  final Color buttonBackgroundColor;
  final EdgeInsets margin;
  final VoidCallback buttonCallback;

  const SnackbarFloating({
    super.key,
    required this.context,
    required this.labelSnackbar,
    required this.labelButton,
    required this.snackbarBackgroundColor,
    required this.snackbarFontColor,
    required this.buttonBackgroundColor,
    required this.margin,
    required this.buttonCallback,
  });

  void show() {
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.hideCurrentSnackBar();
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: this,
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
      ),
    );
  }

  @override
  State<SnackbarFloating> createState() => _SnackbarFloatingState();
}

class _SnackbarFloatingState extends State<SnackbarFloating> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: widget.snackbarBackgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.labelSnackbar,
              style: TextStyle(
                color: widget.snackbarFontColor,
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: widget.buttonCallback,
            style: TextButton.styleFrom(
              backgroundColor: widget.buttonBackgroundColor,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              widget.labelButton,
              style: TextStyle(
                color: widget.snackbarFontColor,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
