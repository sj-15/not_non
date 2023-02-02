import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:not_non/common/utils/notid.dart';
import 'package:not_non/common/widgets/error.dart';

import '../../../common/utils/colors.dart';
import '../../../common/widgets/loader.dart';
import '../controller/auth_controller.dart';

class UserInformation extends ConsumerStatefulWidget {
  static const routeName = '/user_information';
  const UserInformation({super.key});

  @override
  ConsumerState<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends ConsumerState<UserInformation> {
  final TextEditingController aboutsController = TextEditingController();

  String notid = '';
  File? image;

  void storeUserData() async {
    String about = aboutsController.text.trim();
    ref
        .read(authControllerProvider)
        .saveUserDatatoFirebase(context, notid, image, about, 0, 0);
  }

  @override
  void dispose() {
    super.dispose();
    aboutsController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(userDataAuthProvider).when(
          data: (user) {
            if (user == null) {
              notid = notnonid();
            } else {
              notid = user.notid;
            }
          },
          error: (err, trace) {
            return ErrorScreen(
              error: err.toString(),
            );
          },
          loading: () => const Loader(),
        );
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: const Color(0xff000000),
          elevation: 0,
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: storeUserData,
                  icon: const Icon(
                    Icons.done,
                    size: 30,
                  ),
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.only(left: 30, right: 30, top: 15),
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.bottomCenter,
              stops: [0.2, 1],
              colors: <Color>[
                Color(0xff9575CD),
                Color(0xff000000),
              ],
              focal: Alignment.bottomCenter,
              radius: 1,
              tileMode: TileMode.clamp,
            ),
          ),
          child: Column(
            children: [
              image == null
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
                        'assets/avatars/avatar6.jpg',
                      ),
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
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Card(
                color: Colors.white,
                elevation: 15,
                shadowColor: Colors.white60,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: SizedBox(
                  width: size.width * 0.85,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: TextField(
                      controller: aboutsController,
                      decoration: const InputDecoration(
                        hintText: ('Set your Bio'),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
