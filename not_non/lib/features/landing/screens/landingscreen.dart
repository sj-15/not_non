import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/common/utils/utils.dart';

import '../../../common/utils/colors.dart';
import '../../auth/controller/auth_controller.dart';

class LandingScreen extends ConsumerStatefulWidget {
  static const routeName = '/landing-screen';
  const LandingScreen({super.key});

  @override
  ConsumerState<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends ConsumerState<LandingScreen> {
  final phonecontroller = TextEditingController();
  late String country;
  int maxlen = 0, minlen = 0;

  @override
  void dispose() {
    super.dispose();
    phonecontroller.dispose();
  }

  void sendPhoneNumber() {
    String phoneNumber = phonecontroller.text.trim();
    if (country.isNotEmpty &&
        phoneNumber.isNotEmpty &&
        minlen <= phoneNumber.length &&
        phoneNumber.length <= maxlen) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '$country$phoneNumber');
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'notNON',
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.asset(
                    'assets/logowithouticon.png',
                    color: cardcolor,
                    height: size.height * 0.05,
                    width: size.width * 0.3,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Hello!',
                    style: TextStyle(
                      fontSize: 40,
                      color: textcolor,
                    ),
                  ),
                  const Text(
                    'We are notNON.',
                    style: TextStyle(
                      fontSize: 40,
                      color: textcolor,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  const Text(
                    '!non will need to verfiy your phone number.',
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Enter your phone number ',
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  DelayedDisplay(
                    delay: const Duration(seconds: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Card(
                          elevation: 10,
                          color: cardcolor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              height: size.height * 0.08,
                              width: size.width * 0.8,
                              child: IntlPhoneField(
                                keyboardType: TextInputType.number,
                                onChanged: ((value) {
                                  country = value.countryCode;
                                }),
                                onSubmitted: ((p0) => validation()),
                                decoration: const InputDecoration(
                                  hintText: 'phone number',
                                ),
                                cursorColor: Colors.black,
                                initialCountryCode: 'IN',
                                controller: phonecontroller,
                              ),
                            ),
                          ),
                        ),
                        Card(
                          color: cardcolor,
                          elevation: 10,
                          child: SizedBox(
                            height: size.height * 0.05,
                            width: size.width * 0.2,
                            child: TextButton(
                              onPressed: sendPhoneNumber,
                              child: const Text(
                                'GET OTP',
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
                ],
              ),
              Container(
                alignment: Alignment.topRight,
                // color: const Color.fromARGB(255, 180, 236, 255),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'Know the',
                      style: TextStyle(
                        color: textcolor,
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    DelayedDisplay(
                      delay: Duration(seconds: 2),
                      child: Text(
                        'Unknown',
                        style: TextStyle(
                          color: textcolor,
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'with same',
                      style: TextStyle(
                        color: textcolor,
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    DelayedDisplay(
                      delay: Duration(seconds: 3),
                      child: Text(
                        'Interest',
                        style: TextStyle(
                          color: textcolor,
                          fontSize: 60,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void validation() {
    for (int i = 0; i < countries.length; i++) {
      String plus = '+';
      if (plus + countries[i].dialCode == country) {
        maxlen = countries[i].maxLength;
        minlen = countries[i].minLength;
      }
    }
  }
}
