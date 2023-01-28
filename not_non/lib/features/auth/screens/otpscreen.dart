import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/common/utils/utils.dart';
import 'package:not_non/features/auth/screens/userinformation.dart';

import '../../../common/utils/colors.dart';

class OtpScreen extends ConsumerWidget {
  static const routeName = '/otp-screen';
  final String verificationId;

  const OtpScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int cnt = 0;
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
              Form(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: Card(
                        elevation: 15,
                        color: cardcolor,
                        shadowColor: Colors.cyan[100],
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              cnt++;
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          showCursor: false,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: Card(
                        elevation: 15,
                        color: cardcolor,
                        shadowColor: Colors.cyan[100],
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              cnt++;
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          showCursor: false,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: Card(
                        color: cardcolor,
                        elevation: 15,
                        shadowColor: Colors.cyan[100],
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              cnt++;
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          showCursor: false,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: Card(
                        elevation: 15,
                        color: cardcolor,
                        shadowColor: Colors.cyan[100],
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              cnt++;
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          decoration: const InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          showCursor: false,
                          style: Theme.of(context).textTheme.headline6,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: Card(
                        elevation: 15,
                        shadowColor: Colors.cyan[100],
                        color: cardcolor,
                        child: TextFormField(
                          onChanged: (value) {
                            if (value.length == 1) {
                              cnt++;
                              FocusScope.of(context).nextFocus();
                            }
                          },
                          cursorColor: Colors.black,
                          decoration: const InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          showCursor: false,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 48,
                      width: 44,
                      child: Card(
                        elevation: 15,
                        shadowColor: Colors.cyan[100],
                        color: cardcolor,
                        child: TextFormField(
                          onChanged: (value) => cnt++,
                          decoration: const InputDecoration(
                            hintText: '0',
                            hintStyle: TextStyle(
                              color: Colors.black54,
                            ),
                          ),
                          style: Theme.of(context).textTheme.headline6,
                          showCursor: false,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(1),
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              Card(
                color: cardcolor,
                elevation: 10,
                child: SizedBox(
                  height: size.height * 0.05,
                  width: size.width * 0.4,
                  child: TextButton(
                    onPressed: () {
                      if (cnt == 6) {
                        Navigator.pushNamed(context, UserInformation.routeName);
                      } else {
                        showSnackBar(
                            context: context, content: 'Timed out, $cnt');
                      }
                    },
                    child: const Text(
                      'Show your interest',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
