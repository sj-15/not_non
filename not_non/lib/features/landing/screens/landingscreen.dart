import 'package:flutter/material.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:country_picker/country_picker.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final phonecontroller = TextEditingController();
  Country? country;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phonecontroller.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 120, 221, 255),
          elevation: 10,
          title: Image.asset('assets/logowithouticon.png',
              color: Colors.black, height: 100, width: 100),
        ),
        body: Container(
          width: double.infinity,
          color: const Color.fromARGB(255, 180, 236, 255),
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              const Text(
                '!non will need to verfiy your phone number.',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              const Text(
                'Enter your mobile number',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: size.height * 0.2,
              ),
              Container(
                alignment: Alignment.topRight,
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
                      delay: Duration(seconds: 1),
                      child: Text(
                        'Unknown',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 60,
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
                      delay: Duration(seconds: 2),
                      child: Text(
                        'Interest',
                        style: TextStyle(
                          color: Colors.black,
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
}
