import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/common/utils/utils.dart';

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
  @override
  void dispose() {
    super.dispose();
    phonecontroller.dispose();
  }

  void sendPhoneNumber() {
    String phoneNumber = phonecontroller.text.trim();
    if (country.isNotEmpty && phoneNumber.isNotEmpty) {
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
          width: double.infinity,
          color: const Color.fromARGB(255, 180, 236, 255),
          padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Image.asset(
                  'assets/logo.png',
                  height: size.height * 0.2,
                  color: const Color.fromARGB(255, 0, 191, 255),
                ),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Text(
                '!non will need to verfiy your phone number.',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Text(
                'Enter your mobile number ',
                style: TextStyle(
                  color: Colors.black,
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
                      // shape: RoundedRectangleBorder(
                      //   borderRadius: BorderRadius.circular(15),
                      // ),
                      elevation: 10,
                      color: const Color.fromARGB(255, 120, 221, 255),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: size.height * 0.08,
                          width: size.width * 0.8,
                          child: IntlPhoneField(
                            keyboardType: TextInputType.number,
                            onChanged: (value) => country = value.countryCode,
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
                      color: const Color.fromARGB(255, 120, 221, 255),
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
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                alignment: Alignment.topRight,
                height: size.height * 0.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Text(
                      'Know the',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    DelayedDisplay(
                      delay: Duration(seconds: 2),
                      child: Text(
                        'Unknown',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      'with same',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 42,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    DelayedDisplay(
                      delay: Duration(seconds: 3),
                      child: Text(
                        'Interest',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 50,
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
}
