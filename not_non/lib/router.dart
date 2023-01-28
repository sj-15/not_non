import 'package:flutter/material.dart';
import 'common/widgets/error.dart';
import 'features/auth/screens/otpscreen.dart';
import 'features/auth/screens/userinformation.dart';
import 'features/landing/screens/landingscreen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case LandingScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const LandingScreen(),
      );
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OtpScreen(
          verificationId: verificationId,
        ),
      );
    case UserInformation.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => OtpScreen(
          verificationId: verificationId,
        ),
      );

    default:
      return MaterialPageRoute(
        builder: (contex) => const Scaffold(
          body: ErrorScreen(error: 'This doesn\'t exist'),
        ),
      );
  }
}
