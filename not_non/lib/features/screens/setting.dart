import 'package:flutter/material.dart';
import 'package:not_non/features/screens/editprofile.dart';
import 'package:not_non/features/screens/favorite.dart';
import 'package:not_non/features/screens/mobilelayoutscreen.dart';
import 'package:not_non/features/screens/search.dart';
import 'package:rive/rive.dart';

import '../../common/components/rive_asset.dart';
import '../../common/utils/colors.dart';
import '../../common/utils/rive_utils.dart';
import '../../common/widgets/animatedbar.dart';

class SettingScreen extends StatefulWidget {
  static const routeName = '/setting-screen';

  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  RiveAsset selectedBottonNav = bottomNavs[4];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Settings',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Image.asset(
              'assets/logowithouticon.png',
              color: logocolor,
              height: size.height * 0.05,
              width: size.width * 0.2,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.transparent,
        padding: const EdgeInsets.all(12),
        child: menubar(context),
      ),
    );
  }

  Widget menubar(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      // duration: const Duration(milliseconds: 200),
      height: size.height * 0.07,
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...List.generate(
            bottomNavs.length,
            (index) => GestureDetector(
              onTap: () {
                bottomNavs[index].input!.change(true);
                if (bottomNavs[index] != selectedBottonNav) {
                  setState(() {
                    selectedBottonNav = bottomNavs[index];
                  });
                }
                Future.delayed(const Duration(seconds: 1), () {
                  bottomNavs[index].input!.change(false);
                });
              },
              child: InkWell(
                // onTap: () {
                //   if (index == 0) {
                //     Navigator.pushNamed(context, MobileLayoutScreen.routeName);
                //   } else if (index == 1) {
                //     Navigator.pushNamed(context, SearchScreen.routeName);
                //   } else if (index == 2) {
                //     Navigator.pushNamed(context, FavoriteScreen.routeName);
                //   } else if (index == 3) {
                //     Navigator.pushNamed(context, EditProfile.routeName);
                //   } else if (index == 4) {
                //     Navigator.pushNamed(context, SettingScreen.routeName);
                //   }
                // },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedBar(
                        isActive: bottomNavs[index] == selectedBottonNav),
                    SizedBox(
                      height: 36,
                      width: 36,
                      child: Opacity(
                        opacity:
                            bottomNavs[index] == selectedBottonNav ? 1 : 0.5,
                        child: RiveAnimation.asset(
                          bottomNavs.first.src,
                          artboard: bottomNavs[index].atboard,
                          onInit: (artboard) {
                            StateMachineController controller =
                                RiveUtils.getRiveController(artboard,
                                    stateMachineName:
                                        bottomNavs[index].stateMachineName);
                            bottomNavs[index].input =
                                controller.findSMI('active') as SMIBool;
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
