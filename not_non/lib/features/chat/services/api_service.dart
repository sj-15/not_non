import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:not_non/common/components/api_constant.dart';
import 'package:not_non/model/apimodel.dart';
import '../../../common/utils/utils.dart';
import '../../../model/chatmodel.dart';

class ApiService {
  static Future<List<ApiModel>> getModels(BuildContext context) async {
    try {
      var response = await http.get(
        Uri.parse('$Base_Url/models'),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }
      // print('jsonResponse $jsonResponse');
      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        // print("temp[$value]");
      }
      return ApiModel.modelsFromSnapshot(temp);
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      rethrow;
    }
  }

  // send message
  static Future<List<ChatModel>> sendMessage(
      {required BuildContext context, required String message}) async {
    try {
      var response = await http.post(
        Uri.parse('$Base_Url/chat/completions'),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          'Content-Type': 'application/json'
        },
        body: jsonEncode(
          {
            "model": "gpt-3.5-turbo",
            "messages": [
              {"role": "user", "content": message}
            ]
          },
        ),
      );
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse['error']['message']);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        // log("jsonResponse[choices]text ${jsonResponse["choices"][0]["text"]}");
        chatList = List.generate(
          jsonResponse["choices"].length,
          (index) => ChatModel(
            msg: jsonResponse["choices"][index]["message"]["content"],
            chatIndex: 1,
          ),
        );
      }
      // print(chatList);
      return chatList;
    } catch (e) {
      showSnackBar(context: context, content: e.toString());
      rethrow;
    }
  }
}
