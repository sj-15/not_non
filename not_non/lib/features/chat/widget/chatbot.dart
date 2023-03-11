import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:not_non/common/utils/utils.dart';
import 'package:not_non/features/chat/services/api_service.dart';
import 'package:not_non/model/chatmodel.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../common/utils/chatmessage.dart';
import '../../../common/utils/url_check.dart';

class ChatBotScreen extends StatefulWidget {
  const ChatBotScreen({super.key});

  @override
  State<ChatBotScreen> createState() => _ChatBotScreenState();
}

class _ChatBotScreenState extends State<ChatBotScreen> {
  late TextEditingController _controller;
  final List<ChatMessage> _messages = [];

  bool _isTyping = false;
  @override
  void initState() {
    _controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    if (_isTyping) {
      showSnackBar(
        context: context,
        content: "You cant send multiple messages at a time",
      );
      return;
    }
    if (_controller.text.isEmpty) {
      showSnackBar(context: context, content: 'Please type a message');
      return;
    }
    try {
      ChatMessage message = ChatMessage(text: _controller.text, sender: "user");
      if (isUrlPresent(message.text)) {
        return showSnackBar(
            context: context, content: 'Sending url prohivited');
      }
      setState(() {
        _messages.insert(0, message);
        _isTyping = true;
      });
      _controller.clear();
      List<ChatModel> chatList = [];
      chatList.addAll(await ApiService.sendMessage(
          context: context, message: message.text));
      for (var chat in chatList) {
        insertNewData(chat.msg);
      }
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
    }
  }

  void insertNewData(String response) {
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
        IconButton(
          onPressed: () {
            setState(() {
              _messages.clear();
            });
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
        Expanded(
          child: TextField(
            controller: _controller,
            onSubmitted: (value) => _sendMessage(),
            decoration: const InputDecoration.collapsed(
              hintText: 'Ask me anything..',
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
    ).px4();
  }
}
