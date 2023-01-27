import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  static const routeName = '/otp-screen';
  final String verificationId;

  const OtpScreen({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'OtpScreen',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
