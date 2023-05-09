import 'package:flutter/material.dart';
import 'package:nirbhaya_service/color_constant.dart';

class MyTextFieldWithIcon extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final double fontSize;
  final VoidCallback click;
  const MyTextFieldWithIcon(
      {Key? key,
      required this.hintText,
      required this.controller,
      required this.validator,
      required this.fontSize,
      required this.click})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        TextFormField(
          controller: controller,
          style: TextStyle(
              height: 1.3,
              fontFamily: 'Gilroy',
              fontWeight: FontWeight.w500,
              fontSize: fontSize),
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.only(right: 15,left: 0,top: 10,bottom: 15),
            hintText: hintText,
            hintStyle: const TextStyle(
                fontWeight: FontWeight.w500, fontFamily: 'Gilroy'),
            labelStyle: const TextStyle(
                color: appBlue,
                fontFamily: 'Gilroy',
                fontWeight: FontWeight.w500),
          ),
          validator: validator,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 15),
          child: InkWell(
              onTap: click,
              child: Image.asset(
                'assets/current_locatin.png',
                width: 25,
                height: 25,
                color: appWhiteColor,
              )),
        ),
      ],
    );
  }
}
