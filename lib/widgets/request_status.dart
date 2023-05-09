

import 'package:flutter/material.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class RequestStatus extends StatelessWidget {
  final Color color;
  final String statusText;
  const RequestStatus({Key? key, required this.color, required this.statusText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 25,
      decoration:  BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        border: Border.all(
          color: color,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0,right: 8.0),
        child: Center(
          child: MyText(
            text: statusText,
            fontName: 'Gilroy',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            textColor: color),
        ),
      ),
    );
  }
}
