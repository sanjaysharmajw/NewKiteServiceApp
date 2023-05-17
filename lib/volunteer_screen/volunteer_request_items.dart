

import 'package:flutter/material.dart';
import 'package:nirbhaya_service/volunteer_screen/request_widgets.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class VolunteerRequestItems extends StatelessWidget {
  const VolunteerRequestItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black,width: 1),
        borderRadius: const BorderRadius.all(Radius.circular(5))
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:  [
            const MyText(text: 'Sanjay Sharma', fontName: 'Gilroy', fontSize: 16, fontWeight: FontWeight.w700, textColor: Colors.black),
            const SizedBox(
              height: 8,
            ),
            const MyText(text: 'Drive: Amit, MH0412345', fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: Colors.black),
            const SizedBox(
              height: 8,
            ),
            const MyText(text: '10 Km', fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: Colors.black),
            const SizedBox(height: 15),
            Row(
              children:  [
                Flexible(
                    flex: 2,
                    child: RequestWidget(textValue: 'Ready to Go', onClick: () {  })),
               const  SizedBox(width: 10),
                Flexible(
                    flex: 2,
                    child: RequestWidget(textValue: 'Not ready to go', onClick: () {  })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
