


import 'package:flutter/material.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class RequestWidget extends StatelessWidget {
  final String textValue;
  final VoidCallback onClick;
  const RequestWidget({Key? key, required this.textValue, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Container(
        width: double.infinity,
        height: 35,
        decoration: BoxDecoration(
          color: Colors.black,
            border: Border.all(color: Colors.black,width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(5))
        ),
        child: Center(child: MyText(text: textValue,fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: Colors.white)),
      ),
    );
  }
}
