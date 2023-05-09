
import 'package:flutter/material.dart';
import 'package:nirbhaya_service/color_constant.dart';
import 'package:otp_timer_button/otp_timer_button.dart';

class OTPTimer extends StatelessWidget {
  final OtpTimerButtonController otpTimer;
  final VoidCallback pressOtp;
  const OTPTimer({Key? key, required this.otpTimer, required this.pressOtp}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    requestOtp() {
      otpTimer.loading();
      Future.delayed(const Duration(seconds: 2), () {
        otpTimer.startTimer();
      }
      );
    }
    return OtpTimerButton(
      controller: otpTimer,
      height: 60,
      text: const Text(
        'Resend OTP:',
        style: TextStyle(fontFamily: 'Gilroy'),
      ),
      duration: 30,
      radius: 30,
      backgroundColor: appWhiteColor,
      textColor: appWhiteColor,
      buttonType: ButtonType.text_button, // or ButtonType.outlined_button
      loadingIndicator: const CircularProgressIndicator(
        strokeWidth: 2,
        color: appBlue,
      ),
      loadingIndicatorColor: appBlue,
      onPressed: () {
        requestOtp();
      },
    );
  }
}
