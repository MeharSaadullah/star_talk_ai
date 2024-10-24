part of 'chat_bloc.dart';

@immutable
class ChatEvent {}

class ChatGenerate extends ChatEvent {
  final String userMessage;

  ChatGenerate(this.userMessage);
}
