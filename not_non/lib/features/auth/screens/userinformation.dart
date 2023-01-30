import 'package:flutter/material.dart';
import 'package:not_non/common/utils/colors.dart';

class UserInformation extends StatefulWidget {
  static const routeName = '/userinformation-screen';
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              stops: [0.6, 0.6],
              colors: <Color>[
                Color(0xFFBC92FF),
                Color(0xFFFFFFFF),
              ],
              focal: Alignment.topCenter,
              radius: 1,
            ),
          ),
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
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
                    color: cardcolor,
                    height: 30,
                    width: size.width * 0.3,
                  ),
                ],
              ),
              const SizedBox(
                height: 90,
              ),
              const Text(
                '!NON_id',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
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
                  backgroundImage: const AssetImage('assets/avatar1.jpg'),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Card(
                elevation: 10,
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
                          'About me',
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
      ),
    );
  }

  Widget elvbuttons(cnt, text) {
    final ButtonStyle style = ElevatedButton.styleFrom(
      alignment: Alignment.center,
      backgroundColor: cardcolor,
      elevation: 5,
      minimumSize: const Size(120, 40),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
    );
    return ElevatedButton(
      onPressed: () {},
      style: style,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            '$cnt',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.black45,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget options(BuildContext context, text, link) {
    return Card(
      elevation: 5,
      child: SizedBox(
        height: 60,
        width: 320,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  size: 26,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
