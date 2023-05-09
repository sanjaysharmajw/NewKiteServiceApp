
import 'package:flutter/material.dart';
import 'package:nirbhaya_service/color_constant.dart';

class AddButton extends StatelessWidget {
  final VoidCallback click;
  final String text;
  const AddButton({Key? key, required this.click, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: click,
      child: Container(
        height: 30,
        width: 80,
        decoration: const BoxDecoration(
          color: appBlue,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child:  Center(child: Text(text,style: const TextStyle(color: appWhiteColor,
          fontFamily: 'Gilroy',fontSize: 16,
        ),)),
      ),
    );
  }
}
