import 'package:flutter/material.dart';

class UserInformation extends StatefulWidget {
  static const routeName = '/userinformation-screen';
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        ),
      ),
    );
  }
}
