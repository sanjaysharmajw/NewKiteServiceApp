import 'package:flutter/cupertino.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class EmptyScreen extends StatelessWidget {

  final String text;
  const EmptyScreen({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/no_data.png',width: 100,height: 100,fit: BoxFit.fill),
          const SizedBox(height: 10),
          MyText(text: text.toString(), fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: appBlack)
        ],
      ),
    );
  }
}
