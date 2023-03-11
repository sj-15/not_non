import 'package:flutter/material.dart';
import 'package:not_non/common/utils/colors.dart';
import 'package:intl/intl.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage({
    Key? key, // add key property
    required this.text,
    required this.sender,
  }) : super(key: key); // pass key to super constructor

  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: sender == "bot" ? logocolor! : cardcolor,
            width: 5.0,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: sender == "bot" ? logocolor! : cardcolor,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            text.trim(),
            textAlign: TextAlign.right,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15.0,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            DateFormat('HH:mm')
                .format(DateTime.now()), // format the current time
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
