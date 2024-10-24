import 'dart:convert';
import 'dart:developer';

import 'package:star_talk_ai/Data/network_api_services.dart';
import 'package:star_talk_ai/Models/chat_models.dart';
import 'package:star_talk_ai/Utiles/constaints.dart'; // for log function

// class ChatHttpRepo implements ChatRepo {
//   final _apiServices = NetworkApiServices();

//   @override
//   Future<ChatModal> fetchChat(String message) async {
//     final response = await _apiServices.postApi(
//         "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-002:generateContent?key=AIzaSyBrF2HtBC5jm4D8ax8WLOOGzXsF1B3eT2g",
//         jsonEncode({"message": message}));
//     return ChatModal.fromJson(response);
//   }
// }

class ChatHttpRepo {
  static Future<String> ChatGenerationRepo(
      List<ChatModels> previousMessages) async {
    final _apiServices = NetworkApiServices();

    try {
      final response = await _apiServices.postApi(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-pro-002:generateContent?key=$apiKey",
        {
          "contents": previousMessages.map((e) => e.toMap()).toList(),
          "generationConfig": {
            "temperature": 1,
            "topK": 40,
            "topP": 0.95,
            "maxOutputTokens": 8192,
            "responseMimeType": "text/plain"
          }
        },
      );
      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        final data = jsonDecode(response.body);

        return data['candidates'].first['content']['parts'].first['text'];
      }
      return '';
    } catch (e) {
      log('Error: $e');
      return '';
    }
  }
}
