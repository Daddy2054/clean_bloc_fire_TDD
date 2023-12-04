import 'package:equatable/equatable.dart';

import 'message.dart';

class Chat extends Equatable {
  final String id;
  final List<String> userIds;
  final List<Message> messages;
  final Message? lastMessage;
  final DateTime? createdAt;

  const Chat({
    required this.id,
    required this.userIds,
    required this.messages,
    required this.lastMessage,
    this.createdAt,
  });

  static const empty = Chat(
    id: '',
    userIds: [],
    messages: [],
    lastMessage: null,
    createdAt: null,
  );

  @override
  List<Object?> get props => [
        id,
        userIds,
        messages,
        lastMessage,
        createdAt,
      ];
}
