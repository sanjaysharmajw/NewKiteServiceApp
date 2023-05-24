import 'package:firebase_messaging/firebase_messaging.dart';
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
  final idFromFirstController = Get.put(FirebaseTokenController());
  final formKey = GlobalKey<FormState>();
  String? firebaseToken;

  // var idFromFirstController = Get.find<FirebaseTokenController>().getFirebaseToken();

  @override
  void initState() {
    super.initState();
    firebaseTokenMethod();

  }

  void firebaseTokenMethod()async{
     firebaseToken = await FirebaseMessaging.instance.getToken();
     debugPrint("loginFirebase${firebaseToken.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
      body: Form(
        key: formKey,
        child: Center(
          child: SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children:  [
                const SizedBox(height: 100),
                const ImageSets(imagePath: 'assets/servicenow_logo.png', width: 230, height: 50, color: appBlue),
                const SizedBox(height: 50),
                const MyText(text: 'Enter your Phone Number for Login', fontName: 'Gilroy', fontSize: 18, fontWeight: FontWeight.w500, textColor: appBlack),
                const MyText(text: 'or to Get Started', fontName: 'Gilroy', fontSize: 18, fontWeight: FontWeight.w500, textColor: appBlack),
                Padding(
                  padding: const EdgeInsets.all(30),
                  child: MyTextFieldForm(hintText: 'Mobile Number', controller: mobileController,
                    validator: (value) {
                      if (value.toString().length!=10) {
                        return "Enter 10 digits Mobile Number";
                      }else{
                        return null;
                      }
                    }, fontSize: 18, readOnly: false, onTap: () {  }, keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                      FilteringTextInputFormatter.deny(RegExp(r'^0+')),
                      LengthLimitingTextInputFormatter(10),
                    ],),
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
