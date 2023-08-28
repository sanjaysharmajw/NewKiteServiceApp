
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/route_manager.dart';
import 'package:nirbhaya_service/Utils/validators.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:nirbhaya_service/contoller/firebase_token_controller.dart';
import 'package:nirbhaya_service/contoller/loginController.dart';
import 'package:nirbhaya_service/widgets/images_set.dart';

import '../Utils/loader.dart';
import '../contoller/place_details_controller.dart';
import '../widgets/MyText.dart';
import '../widgets/MyTextFieldForm.dart';
import '../widgets/button.dart';
import 'otp_screen.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({Key? key}) : super(key: key);

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final mobileController=TextEditingController();
  final controller = Get.put(SendOtpController());
  //final idFromFirstController = Get.put(FirebaseTokenController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: appWhiteColor,
          //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Center(
            child: Container(

              child: Column(
                children:  [
                  const SizedBox(height: 50),
                 // const ImageSets(imagePath: 'assets/servicenow_logo.png', width: 230, height: 50, color: appBlue),
                  Image.asset('assets/service_logo.png',width: 130,height: 130),
                  const SizedBox(height: 20),
                  const MyText(text: 'Enter your Phone Number for Login', fontName: 'Gilroy', fontSize: 18, fontWeight: FontWeight.w500, textColor: appBlack),
                  const MyText(text: 'or to Get Started', fontName: 'Gilroy', fontSize: 18, fontWeight: FontWeight.w500, textColor: appBlack),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                            RegExp("[0-9]")),
                        FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                        LengthLimitingTextInputFormatter(10),
                        FilteringTextInputFormatter.deny('  ')
                      ],
                      style:  TextStyle(
                        fontSize: 16,
                        fontFamily: 'Gilroy',
                        fontWeight: FontWeight.normal,
                      ),
                      controller: mobileController,
                      keyboardType: TextInputType.number,
                      decoration:  InputDecoration(
                        labelText: "mobile_number".tr,
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Gilroy',
                          fontWeight: FontWeight.normal,
                        ),
                        prefixText: "+91",
                        // hintText: widget.dlMobNumber ,
                        border: UnderlineInputBorder(),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 1, color: appBlack)),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              width: 1, color: appBlue),
                        ),
                      ),

                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length != 10) {
                          return 'please_enter_10_digit_number'.tr;
                        }
                        return null;
                      },

                    ),
                  ),
                   MyButton(press: () {
                     if (formKey.currentState!.validate()) {
                     sendOtpAPi(mobileController.text.trim().toString());
                     }
                   }, buttonText: 'SEND OTP'),
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
  void sendOtpAPi(String mobile)async{
    await controller.sendOtp(mobile).then((value) async {
      if (value != null) {
        if (value.status == true) {
          CustomLoader.showToast(value.message);
          Get.to(OTPScreen(mobile: mobileController.text.trim().toString()));
        }
      }
    });
  }
}
