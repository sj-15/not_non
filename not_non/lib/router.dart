import 'package:flutter/material.dart';
import 'package:not_non/common/utils/notid.dart';
import 'package:not_non/features/screens/editprofile.dart';
import 'package:not_non/features/screens/mobilelayoutscreen.dart';
import 'package:not_non/features/screens/search.dart';
import 'common/widgets/error.dart';
import 'features/auth/screens/otpscreen.dart';
import 'features/auth/screens/userinformation.dart';
import 'features/landing/screens/landingscreen.dart';
import 'features/screens/favorite.dart';
import 'features/screens/setting.dart';

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
      final notid = notnonid();
      return MaterialPageRoute(
        builder: (context) => UserInformation(
          notid: notid,
        ),
      );
    case MobileLayoutScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const MobileLayoutScreen(),
      );
    case SearchScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SearchScreen(),
      );
    case NotificationScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      );
    case EditProfile.routeName:
      return MaterialPageRoute(
        builder: (context) => const EditProfile(),
      );
    case SettingScreen.routeName:
      return MaterialPageRoute(
        builder: (context) => const SettingScreen(),
      );

    default:
      return MaterialPageRoute(
        builder: (contex) => const Scaffold(
          body: ErrorScreen(error: 'This doesn\'t exist'),
        ),
      );
  }
}
