

import 'package:flutter/material.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import 'package:nirbhaya_service/widgets/images_set.dart';

class CurrentLocationBtn extends StatelessWidget {
  final VoidCallback click;
  const CurrentLocationBtn({Key? key, required this.click}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 15,right: 15),
      child: InkWell(
        onTap: click,
        child: Row(
          children: const [
            ImageSets(imagePath: 'assets/current_locatin.png', width: 25, height: 25, color: appBlue),
            SizedBox(width: 10),
            MyText(text: 'Current Loaction', fontName: 'Gilroy', fontSize: 18, fontWeight: FontWeight.w600, textColor: appBlue),
          ],
        ),
      ),
    );
  }
}
