import 'package:flutter/material.dart';

import '../utils/colors.dart';

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
            color: Colors.white60,
            fontSize: 15,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
