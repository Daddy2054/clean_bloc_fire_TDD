part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class ChatGetChat extends ChatEvent {
  final String chatId;

  const ChatGetChat({required this.chatId});

  @override
  List<Object> get props => [chatId];
}

class ChatWriteMessage extends ChatEvent {
  final String text;

  const ChatWriteMessage({required this.text});

  @override
  List<Object> get props => [text];
}

class ChatSendMessage extends ChatEvent {
  final String senderId;

  const ChatSendMessage({required this.senderId});

  @override
  List<Object> get props => [senderId];
}
