import 'package:flutter/material.dart';
import 'package:nirbhaya_service/Utils/validators.dart';
import 'package:nirbhaya_service/color_constant.dart';

class SearchBoxWidgets extends StatelessWidget {
  final String hintText;
  final double fontSize;
  final ValueChanged<String>  changed;
  const SearchBoxWidgets(
      {Key? key,
        required this.hintText,required this.fontSize, required this.changed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FocusNode focusNode = FocusNode();
    return TextFormField(
      onChanged: changed,
      autofocus:true,
      focusNode: focusNode,
      style: TextStyle(fontFamily: 'Gilroy', fontWeight: FontWeight.w600,fontSize: fontSize,),
      keyboardType: TextInputType.streetAddress,

      decoration: InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appLightGrey),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 18),
        hintText: hintText,
        hintStyle:
        const TextStyle(fontWeight: FontWeight.w500,fontSize: 16, fontFamily: 'Gilroy'),
        labelStyle: const TextStyle(
            color: appBlue, fontFamily: 'Gilroy', fontWeight: FontWeight.w500),
      ),
    );
  }
}
