import 'package:flutter/material.dart';

Widget options(BuildContext context, text, link) {
  final size = MediaQuery.of(context).size;
  return Card(
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: SizedBox(
      height: size.height * 0.08,
      width: size.width * 0.8,
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
