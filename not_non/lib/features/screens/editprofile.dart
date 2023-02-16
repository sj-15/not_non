import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/common/utils/colors.dart';
import 'package:not_non/common/widgets/error.dart';
import 'package:not_non/common/widgets/loader.dart';
import 'package:not_non/features/auth/controller/auth_controller.dart';
import 'package:not_non/features/screens/favorite.dart';
import 'package:not_non/features/screens/mobilelayoutscreen.dart';
import 'package:not_non/features/screens/search.dart';
import 'package:not_non/features/screens/setting.dart';

import 'package:rive/rive.dart';

import '../../../common/components/rive_asset.dart';
import '../../../common/utils/rive_utils.dart';
import '../../../common/widgets/animatedbar.dart';
import '../../../common/widgets/buttons.dart';
import '../../../common/widgets/options.dart';

class EditProfile extends ConsumerStatefulWidget {
  static const routeName = '/EditProfile-screen';

  const EditProfile({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  RiveAsset selectedBottonNav = bottomNavs[3];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profile',
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
        body: riverpod.Consumer(
          builder: (context, ref, child) {
            final asyncValue = ref.watch(userDataAuthProvider);
            return asyncValue.when(
              data: (user) {
                return Container(
                  height: size.height * 0.8,
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '!',
                              style: TextStyle(
                                color: logocolor,
                                fontWeight: FontWeight.w900,
                                fontSize: 36,
                              ),
                            ),
                            TextSpan(
                              text: user!.notid,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        ),
                        shadowColor: Colors.black87,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: cardcolor,
                          backgroundImage: AssetImage(user.profilePic),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Card(
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: SizedBox(
                          width: size.width * 0.8,
                          height: size.height * 0.3,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18.0, vertical: 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Online',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  user.abouts,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    elvbuttons(user.known, 'Known'),
                                    elvbuttons(user.unknown, 'Unknown'),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.02,
                      ),
                      options(context, 'Your interest', ''),
                      options(context, 'Settings', ''),
                    ],
                  ),
                );
              },
              error: (Object error, StackTrace stackTrace) {
                return ErrorScreen(error: error.toString());
              },
              loading: () {
                return const Loader();
              },
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          padding: const EdgeInsets.all(12),
          child: menubar(context),
        ),
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
