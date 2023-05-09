import 'package:flutter/material.dart';
import 'package:nirbhaya_service/Utils/validators.dart';
import 'package:nirbhaya_service/color_constant.dart';

class MyTextFieldForm extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final double fontSize;
  final bool  readOnly;
  final VoidCallback onTap;
  final int? maxLength;
  final TextInputType keyboardType;
  const MyTextFieldForm(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.validator, required this.fontSize, required this.readOnly, required this.onTap, required this.keyboardType, this.maxLength})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      onTap: onTap,
      maxLength: maxLength,
      style:
           TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w500,fontSize: fontSize),
      keyboardType: keyboardType,
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText,
        hintStyle:
            const TextStyle(fontWeight: FontWeight.w500, fontFamily: 'Gilroy'),
        labelStyle: const TextStyle(
            color: appBlue, fontFamily: 'Gilroy', fontWeight: FontWeight.w500),
      ),
      validator: validator,
    );
  }
}
