
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nirbhaya_service/volunteer_screen/volunteer_request_items.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class VolunteerRequestList extends StatefulWidget {
  const VolunteerRequestList({Key? key}) : super(key: key);

  @override
  State<VolunteerRequestList> createState() => _VolunteerRequestListState();
}

class _VolunteerRequestListState extends State<VolunteerRequestList> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(body: Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell( highlightColor: Colors.black38,onTap: (){
            Get.back();
          },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
          const SizedBox(height: 20),
          const MyText(text: 'Volunteer', fontName: 'Gilroy',
              fontSize: 20, fontWeight: FontWeight.w700, textColor: Colors.black),
          const SizedBox(height: 20),
          const  VolunteerRequestItems(),

        ],
      ),
    )));
  }
}
