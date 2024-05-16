import 'package:flutter/material.dart';

class TextForm extends StatelessWidget {
  TextForm({super.key,
    this.icon,
    this.hint,
    this.prefixWidget,
    this.prefixText,
    this.keyboardType,
    this.controller,
    this.validator,
    this.fillColor,
    this.onTapIcon});

  IconData? icon;
  String? hint;
  Widget? prefixWidget;
  String? prefixText;
  TextInputType? keyboardType;
  TextEditingController? controller;
  Color? fillColor;
  void Function()? onTapIcon;

  String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextFormField(
        controller: controller,
        textCapitalization: TextCapitalization.words,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixText: prefixText,
          prefix: prefixWidget,
          hintText: hint,
          prefixIcon: GestureDetector(
              onTap: onTapIcon,
              child: Icon(icon)),
            border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(50)
            ),
          filled: true,
          fillColor: fillColor
        ),
        validator: validator,
      ),
    );
  }
}
