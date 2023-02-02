import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/common/utils/colors.dart';
import 'package:not_non/features/auth/controller/auth_controller.dart';
import 'package:rive/rive.dart';

import '../../../common/components/rive_asset.dart';
import '../../../common/utils/notid.dart';
import '../../../common/utils/rive_utils.dart';
import '../../../common/widgets/animatedbar.dart';
import '../../../common/widgets/buttons.dart';
import '../../../common/widgets/options.dart';

class EditProfile extends ConsumerStatefulWidget {
  static const routeName = '/EditProfile-screen';
  const EditProfile({super.key});

  @override
  ConsumerState<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends ConsumerState<EditProfile> {
  RiveAsset selectedBottonNav = bottomNavs.first;
  File? image;
  String notid = notnonid();

  void storeUserData() async {
    ref
        .read(authControllerProvider)
        .saveUserDatatoFirebase(context, notid, image, 'About me', 0, 0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Profile',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Image.asset(
                'assets/logowithouticon.png',
                color: logocolor,
                height: 30,
                width: size.width * 0.3,
              ),
            ],
          ),
        ),
        body: Container(
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
                      text: notid,
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
                child: image == null
                    ? const CircleAvatar(
                        radius: 50,
                        backgroundColor: cardcolor,
                        backgroundImage: AssetImage(
                          'assets/avatars/avatar1.jpg',
                        ),
                      )
                    : const CircleAvatar(
                        radius: 50,
                        backgroundColor: cardcolor,
                        backgroundImage: AssetImage(
                          'assets/avatars/avatar1.jpg',
                        ),
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
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Status',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        const Text(
                          'Call me Engineer and lets build life with you..',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            elvbuttons(0, 'Known'),
                            elvbuttons(0, 'Unknown'),
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
        color: Colors.blueGrey,
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
