import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:nirbhaya_service/Utils/dummay_data.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/widgets/MyText.dart';
import 'package:nirbhaya_service/widgets/images_set.dart';

class AboutUsScreen extends StatefulWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  State<AboutUsScreen> createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appWhiteColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              const SizedBox(height: 25),
              InkWell( onTap: (){
                Get.back();
              },child: Image.asset('assets/back_icons.png',width: 17,height: 17)),
              const SizedBox(height: 25),
               MyText(text: 'about_us'.tr, fontName: 'Gilroy',
                  fontSize: 20, fontWeight: FontWeight.w800, textColor: appBlack),
              const SizedBox(height: 25),
              Column(
                children: [
                  Image.asset('assets/service_logo.png',width: 130,height: 130),
                  40.height,
                  const Text(
                      serviceLongText,style: TextStyle(fontFamily: 'Gilroy',fontSize: 15,fontWeight: FontWeight.w500,height: 1.3,color: appBlack)),
                  16.height,
                  const Text(serviceLongText,style: TextStyle(fontFamily: 'Gilroy',fontSize: 15,height: 1.3,fontWeight: FontWeight.w500,color: appBlack))
                ],
              )
            ],
          ).paddingSymmetric(horizontal: 16).center(),
        ),
      ),
    );
  }

}
