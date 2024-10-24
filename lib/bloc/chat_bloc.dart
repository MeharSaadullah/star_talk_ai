import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/gestures.dart';
import 'package:meta/meta.dart';
import 'package:star_talk_ai/Data/Response/api_response.dart';
import 'package:star_talk_ai/Models/chat_models.dart';
import 'package:star_talk_ai/Repository/chat_http_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  //final ChatRepo chatRepo;

  ChatBloc() 
      : super(ChatSuccess(
                messages: []) //ChatState(chatList: ApiResponse.loading(),)
            ) {
    on<ChatGenerate>(chatgenerate);
  }
  List<ChatModels> messages =
      []; // this is list is to aadd user messages in this list

  Future<void> chatgenerate(ChatGenerate event, Emitter<ChatState> emit) async {
    messages.add(ChatModels(
        role: "user", parts: [ChatParModel(text: event.userMessage)]));

    emit(ChatSuccess(messages: messages));

    String generatedTest =
        await ChatHttpRepo.ChatGenerationRepo(messages); // here we cll that api
    if (generatedTest.length > 0) {
      messages.add(ChatModels(
          role: 'model', parts: [ChatParModel(text: generatedTest)]));
      emit(ChatSuccess(messages: messages));
      log('Messages updated: ${messages.length}');
    }

    
  }
}
