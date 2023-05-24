
import 'package:flutter/material.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
class HomePageItems extends StatelessWidget {
  final Color backgroundColor;
  final String title;
  final String subtitle;
  final int completed;

  const HomePageItems(
      {Key? key,
        required this.backgroundColor,
        required this.completed, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 125,
      decoration: BoxDecoration(color:backgroundColor,
      borderRadius: const BorderRadius.all(Radius.circular(3.0))
      ),
      padding: const EdgeInsets.only(bottom: 20, left: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: MyText(text: subtitle, fontName: 'Gilroy', fontSize: 20, fontWeight: FontWeight.w600, textColor: appWhiteColor),
              )),
         const Spacer(),
          MyText(text: title, fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w600, textColor: appWhiteColor),
        ],
      ),
    );
  }
}
