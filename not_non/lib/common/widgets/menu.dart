import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../utils/colors.dart';
import '../utils/rive_utils.dart';

class MenuBar extends StatefulWidget {
  const MenuBar({super.key});

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  RiveAsset selectedBottonNav = bottomNavs.first;
  @override
  Widget build(BuildContext context) {
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

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    Key? key,
    required this.isActive,
  }) : super(key: key);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(microseconds: 200),
      margin: const EdgeInsets.only(bottom: 2),
      height: 4,
      width: isActive ? 20 : 0,
      decoration: BoxDecoration(
        color: logocolor,
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
    );
  }
}

class RiveAsset {
  final String atboard, stateMachineName, title, src;
  late SMIBool? input;

  RiveAsset(this.src,
      {required this.atboard,
      required this.stateMachineName,
      required this.title,
      this.input});
  set setInput(SMIBool status) {
    input = status;
  }
}

List<RiveAsset> bottomNavs = [
  RiveAsset('assets/rive_assets/buttons.riv',
      atboard: 'CHAT', stateMachineName: "CHAT_Interactivity", title: 'Chat'),
  RiveAsset('assets/rive_assets/buttons.riv',
      atboard: 'SEARCH',
      stateMachineName: "SEARCH_Interactivity",
      title: 'Search'),
  RiveAsset('assets/rive_assets/buttons.riv',
      atboard: 'USER', stateMachineName: "USER_Interactivity", title: 'User'),
  RiveAsset('assets/rive_assets/buttons.riv',
      atboard: 'SETTINGS',
      stateMachineName: "SETTINGS_Interactivity",
      title: 'Settings'),
];
