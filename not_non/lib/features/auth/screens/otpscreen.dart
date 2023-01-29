import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/common/utils/utils.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';

import '../../../common/utils/colors.dart';
import '../controller/auth_controller.dart';

class OtpScreen extends ConsumerWidget {
  static const routeName = '/otp-screen';
  final String verificationId;
  OtpScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);
  void verifyOTP(WidgetRef ref, BuildContext context, String userOTP) {
    ref
        .read(authControllerProvider)
        .verifyOTP(context, verificationId, userOTP);
  }

  String otp = '';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.bottomCenter,
              stops: [0.2, 1],
              colors: <Color>[
                Color(0xff9575CD),
                Color(0xff000000),
              ],
              focal: Alignment.bottomCenter,
              radius: 1,
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset(
                'assets/logowithouticon.png',
                color: cardcolor,
                height: size.height * 0.05,
                width: size.width * 0.3,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Text(
                'OTP Verification',
                style: TextStyle(
                  fontSize: 40,
                  color: textcolor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Text(
                'We are sending you an OTP to verify your phone number',
                style: TextStyle(
                  color: textcolor,
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Center(
                child: Text(
                  'Please enter your code here',
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              OTPTextField(
                length: 6,
                width: double.infinity,
                fieldWidth: 40,
                outlineBorderRadius: 15,
                otpFieldStyle: OtpFieldStyle(
                  backgroundColor: const Color.fromARGB(255, 132, 255, 255),
                ),
                style: const TextStyle(fontSize: 17, color: Colors.black),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  otp = pin;
                },
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Card(
                color: cardcolor,
                elevation: 10,
                child: SizedBox(
                  height: 45,
                  width: 160,
                  child: TextButton(
                    onPressed: () {
                      showSnackBar(context: context, content: otp);
                      verifyOTP(ref, context, otp);
                    },
                    child: Row(
                      children: const [
                        Text(
                          'Show your interest',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_alt_rounded,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
