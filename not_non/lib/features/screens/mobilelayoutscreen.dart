import 'package:flutter/material.dart';
import 'package:not_non/features/chat/widget/chatbot.dart';
import 'package:not_non/features/screens/editprofile.dart';
import 'package:not_non/features/screens/favorite.dart';
import 'package:not_non/features/screens/search.dart';
import 'package:not_non/features/screens/setting.dart';
import 'package:rive/rive.dart';

import '../../common/components/rive_asset.dart';
import '../../common/utils/colors.dart';
import '../../common/utils/rive_utils.dart';
import '../../common/widgets/animatedbar.dart';
import '../chat/widget/clubwidget.dart';
import '../chat/widget/knwonwidget.dart';

class MobileLayoutScreen extends StatefulWidget {
  static const routeName = 'mobile-layout';
  final String notid;
  const MobileLayoutScreen({
    Key? key,
    required this.notid,
  }) : super(key: key);

  @override
  State<MobileLayoutScreen> createState() => _MobileLayoutScreenState();
}

class _MobileLayoutScreenState extends State<MobileLayoutScreen>
    with SingleTickerProviderStateMixin {
  RiveAsset selectedBottonNav = bottomNavs[0];
  late TabController _tabController;
  bool showBottomNavigation = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    _tabController.addListener(() {
      if (_tabController.index < 2) {
        setState(() {
          showBottomNavigation = true;
        });
      } else {
        setState(() {
          showBottomNavigation = false;
        });
      }
    });
  }

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
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
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
      body: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: Column(
          children: [
            Container(
              color: Colors.black,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: TabBar(
                isScrollable: true,
                indicatorColor: logocolor,
                indicatorWeight: 4,
                controller: _tabController,
                labelStyle:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                unselectedLabelStyle: const TextStyle(color: Colors.white38),
                tabs: const [
                  Tab(
                    text: 'Known',
                  ),
                  Tab(
                    text: 'Club',
                  ),
                  Tab(
                    text: ('ChatBot'),
                  ),
                ],
              ),
            ),
            Flexible(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  //tab1 individual chat
                  KnwonsWidget(),
                  //tab2 Club
                  ClubsWidget(),
                  //tab3 chatbot
                  ChatBotScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: showBottomNavigation == false
          ? null
          : BottomAppBar(
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
