

import 'package:flutter/material.dart';
import 'package:nirbhaya_service/Models/get_volunteer_models.dart';
import 'package:nirbhaya_service/volunteer_screen/request_widgets.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';

class VolunteerRequestItems extends StatelessWidget {
  final VolunteerData volunteerData;
  final VoidCallback readyClick;
  final VoidCallback notReadyClick;
  const VolunteerRequestItems({Key? key, required this.volunteerData, required this.readyClick, required this.notReadyClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0,bottom: 8.0),
      child: Container(
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
              MyText(text: volunteerData.userName.toString(), fontName: 'Gilroy', fontSize: 16, fontWeight: FontWeight.w700, textColor: Colors.black),
              const SizedBox(
                height: 8,
              ),
              MyText(text: 'Drive: ${volunteerData.driverName.toString()}, ${volunteerData.vehicleNumber.toString()}', fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: Colors.black),
              const SizedBox(
                height: 8,
              ),
              const MyText(text: '10 Km', fontName: 'Gilroy', fontSize: 14, fontWeight: FontWeight.w500, textColor: Colors.black),
              const SizedBox(height: 15),
              Row(
                children:  [
                  Flexible(
                      flex: 2,
                      child: RequestWidget(textValue: 'Ready to Go', onClick: readyClick)),
                 const  SizedBox(width: 10),
                  Flexible(
                      flex: 2,
                      child: RequestWidget(textValue: 'Not ready to go', onClick: notReadyClick)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
