part of 'chat_bloc.dart';

@immutable
class ChatState {}

final class ChatInitial extends ChatState {}

class ChatSuccess extends ChatState {
  final List<ChatModels> messages;

  ChatSuccess({required this.messages});
}
