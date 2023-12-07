part of 'chat_bloc.dart';

enum ChatStatus { initial, loading, loaded, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final Chat chat;
  final String? text;

  const ChatState({
    this.status = ChatStatus.initial,
    this.chat = Chat.empty,
    this.text,
  });

  ChatState copyWith({
    ChatStatus? status,
    Chat? chat,
    String? text,
  }) {
    return ChatState(
      status: status ?? this.status,
      chat: chat ?? this.chat,
      text: text ?? this.text,
    );
  }

  @override
  List<Object?> get props => [chat, status, text];
}
