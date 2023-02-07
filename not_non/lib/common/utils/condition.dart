import 'package:flutter/material.dart';

import '../../features/screens/editprofile.dart';
import '../../features/screens/mobilelayoutscreen.dart';

void condition(BuildContext context, int index) {
  if (index == 0) {
    Navigator.pushNamed(
      context,
      MobileLayoutScreen.routeName,
    );
  } else {
    Navigator.pushNamed(
      context,
      EditProfile.routeName,
    );
  }
}
