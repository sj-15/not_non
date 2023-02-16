import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/features/screens/editprofile.dart';
import 'package:not_non/features/screens/favorite.dart';
import 'package:not_non/features/screens/mobilelayoutscreen.dart';
import 'package:not_non/features/screens/setting.dart';
import 'package:not_non/features/search/widget/searchpage.dart';
import 'package:rive/rive.dart';

import '../../common/components/rive_asset.dart';
import '../../common/utils/colors.dart';
import '../../common/utils/rive_utils.dart';
import '../../common/widgets/animatedbar.dart';

class SearchScreen extends ConsumerStatefulWidget {
  static const routeName = '/search-screen';
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  RiveAsset selectedBottonNav = bottomNavs[1];
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Find unknown',
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
      body: const SearchPage(),
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
                switch (bottomNavs[index].title) {
                  case 'Chat':
                    Navigator.pushNamed(context, MobileLayoutScreen.routeName);
                    break;
                  case 'Search':
                    Navigator.pushNamed(context, SearchScreen.routeName);
                    break;
                  case 'Bell':
                    Navigator.pushNamed(context, NotificationScreen.routeName);
                    break;
                  case 'User':
                    Navigator.pushNamed(context, EditProfile.routeName);
                    break;
                  case 'Settings':
                    Navigator.pushNamed(context, SettingScreen.routeName);
                    break;
                  default:
                    break;
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedBar(isActive: bottomNavs[index] == selectedBottonNav),
                  SizedBox(
                    height: 36,
                    width: 36,
                    child: Opacity(
                      opacity: bottomNavs[index] == selectedBottonNav ? 1 : 0.5,
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
        ],
      ),
    );
  }
}
