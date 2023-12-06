part of 'chat_list_bloc.dart';

enum ChatListStatus { initial, loading, loaded, error }

class ChatListState extends Equatable {
  final List<Chat> chats;
  final ChatListStatus status;

  const ChatListState({
    this.chats = const <Chat>[],
    this.status = ChatListStatus.initial,
  });

  ChatListState copyWith({
    List<Chat>? chats,
    ChatListStatus? status,
  }) {
    return ChatListState(
      chats: chats ?? this.chats,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [chats, status];
}
