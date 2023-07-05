import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:nirbhaya_service/Screens/registration.dart';
import 'package:nirbhaya_service/contoller/loginController.dart';
import 'package:otp_timer_button/otp_timer_button.dart';
import '../Utils/custom_bottom_nav.dart';
import '../Utils/loader.dart';
import '../Utils/preference.dart';
import '../color_constant.dart';
import '../widgets/MyText.dart';
import '../widgets/button.dart';
import '../widgets/images_set.dart';
import '../widgets/otp_pin.dart';

class OTPScreen extends StatefulWidget {
  final String mobile;
  const OTPScreen({Key? key, required this.mobile}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final otpController = TextEditingController();
  final otpApiController = Get.put(SendOtpController());
  OtpTimerButtonController controller = OtpTimerButtonController();
  final focusNode = FocusNode();
  String? firebaseToken="";

  requestOtp() {
    controller.loading();
    Future.delayed(const Duration(seconds: 2), () {
      resendOtpAPi(widget.mobile.toString());
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    firebaseTokenMethod();
  }

  void firebaseTokenMethod()async{
    firebaseToken = await FirebaseMessaging.instance.getToken();
    debugPrint("firebaseOTPVerify:....   ${firebaseToken}   ........");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));
    return SafeArea(
        child: Scaffold(
          backgroundColor: appWhiteColor,
          resizeToAvoidBottomInset: false,
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Column(
              children: [
                //const ImageSets(imagePath:'assets/back_icons.png', width: 50),
                const SizedBox(height: 100),
                // const ImageSets(
                //     imagePath: 'assets/servicenow_logo.png',
                //     width: 230,
                //     height: 50,
                //     color: appBlue),
                Image.asset('assets/service_logo.png',width: 130,height: 130),
                const SizedBox(height: 20),
                const MyText(
                    text: 'Enter OTP sent to your Mobile Number',
                    fontName: 'Gilroy',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    textColor: appBlack),
                MyText(
                    text: '+91 - ${widget.mobile.toString()} (Edit?)',
                    fontName: 'Gilroy',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    textColor: appBlack),
                const SizedBox(height: 50),
                OTPPin(otpController: otpController, focusNode: focusNode),
                const SizedBox(height: 10),
                OtpTimerButton(
                  controller: controller,
                  height: 60,
                  text: const Text(
                    'Resend OTP',
                    style: TextStyle(fontFamily: 'Gilroy'),
                  ),
                  duration: 30,
                  radius: 30,
                  backgroundColor: appBlue,
                  textColor: appBlue,
                  buttonType:
                      ButtonType.text_button, // or ButtonType.outlined_button
                  loadingIndicator: const CircularProgressIndicator(
                    strokeWidth: 2,
                    color: appBlue,
                  ),
                  loadingIndicatorColor: appBlue,
                  onPressed: () {
                    requestOtp();
                  },
                ),
                MyButton(
                    press: () {
                      //CustomLoader.message( firebaseToken!);
                      if (otpController.text.trim().isNotEmpty) {
                        verifyOTPApi(
                            widget.mobile, otpController.text.toString());
                      } else {
                        CustomLoader.message('Enter 4 Digits OTP');
                      }
                    },
                    buttonText: 'VERIFY'),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  void verifyOTPApi(String mobile, String otp) async {
    await otpApiController.verifyOtp(mobile, otp,firebaseToken!).then((value) async {
      if (value != null) {
        if(value.status==true){
            if(value.data.toString()=="[]"){
              Get.to(const RegistrationScreen());
            }else{
              share(value.token!, value.data![0].id.toString(), value.data![0].mobileNumber.toString());
              //share(value.token!,'','');

              Get.to(const CustomBottomNav());
            }
          }else{
            CustomLoader.message(value.message.toString());
          }



      }
    });
  }

  void resendOtpAPi(String mobile) async {
    await otpApiController.sendOtp(mobile).then((value) async {
      if (value != null) {
        if (value.status == true) {
          CustomLoader.showToast(value.message);
          controller.startTimer();
        } else {
          CustomLoader.showToast(value.message);
        }
      }
    });
  }

  void share(String token,String userId,String mobileNumber) async {
    await Preferences.setPreferences();
    Preferences.setToken(token).toString();
    Preferences.setUserId(userId).toString();
    Preferences.setMobileNo(mobileNumber).toString();

  }

}
