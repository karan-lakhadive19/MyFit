import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:myfit/models/chat_message_models.dart';
// import 'package:space_pod/models/chat_message_model.dart';
// import 'package:space_pod/utils/constants.dart';

class ChatRepo {
  static Future<String> chatTextGenerationRepo(
      List<ChatMessageModel> previousMessages) async {
    try {
      Dio dio = Dio();

      final response = await dio.post(
          "https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=AIzaSyCqTKYLAt6qvt1ZTzYT17ySqX2Ei-jNbrk",
          data: {
            "contents": previousMessages.map((e) => e.toMap()).toList(),
            "generationConfig": {
              "temperature": 0.9,
              "topK": 1,
              "topP": 1,
              "maxOutputTokens": 2048,
              "stopSequences": []
            },
            "safetySettings": [
              {
                "category": "HARM_CATEGORY_HARASSMENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_HATE_SPEECH",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              },
              {
                "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
                "threshold": "BLOCK_MEDIUM_AND_ABOVE"
              }
            ]
          });

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response
            .data['candidates'].first['content']['parts'].first['text'];
      }

      return '';
    } catch (e) {
      log(e.toString());
      return '';
    }
  }
}