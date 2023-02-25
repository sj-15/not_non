import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';

import '../../../common/utils/chatmessage.dart';
import '../../../common/widgets/threedots.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  late TextEditingController _controller;
  final List<ChatMessage> _messages = [];

  late OpenAI? openAI;
  late StreamSubscription _subscription;
  bool _isTyping = false;
  @override
  void initState() {
    _controller = TextEditingController();
    openAI = OpenAI.instance.build(
        token: "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",
        baseOption: HttpSetup(receiveTimeout: 150000));
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    openAI?.close();
    super.dispose();
  }

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;
    ChatMessage message = ChatMessage(text: _controller.text, sender: "user");
    setState(() {
      _messages.insert(0, message);
      _isTyping = true;
    });
    _controller.clear();
    final request =
        CompleteText(prompt: message.text, model: kTranslateModelV3);
    await Future.delayed(
      const Duration(
        seconds: 1,
      ),
    );

    final response = await openAI!.onCompleteText(request: request);
    Vx.log(response!.choices[0].text);
    insertNewData(response.choices[0].text);
  }

  void insertNewData(String response) {
    print(response);
    ChatMessage botMessage = ChatMessage(
      text: response,
      sender: "bot",
    );

    setState(() {
      _isTyping = false;
      _messages.insert(0, botMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: ListView.builder(
            itemCount: _messages.length,
            reverse: true,
            padding: Vx.m8,
            itemBuilder: (context, index) {
              return _messages[index];
            },
          ),
        ),
        if (_isTyping)
          const SpinKitThreeBounce(
            color: Colors.black,
            size: 18,
          ),
        const Divider(
          height: 1.0,
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.8),
            borderRadius: BorderRadius.circular(100),
          ),
          child: buildTextComposer(),
        ),
      ],
    );
  }

  Widget buildTextComposer() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration: const InputDecoration.collapsed(
              hintText: 'Gain some knowledge',
              hintStyle: TextStyle(color: Colors.white70),
            ),
            cursorColor: Colors.white,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: () => _sendMessage(),
          icon: const Icon(
            Icons.send,
            color: Colors.white,
          ),
        ),
      ],
    ).px16();
  }
}
