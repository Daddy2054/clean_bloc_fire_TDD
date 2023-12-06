import 'package:equatable/equatable.dart';

import '../../domain/entities/chat.dart';
import 'message_model.dart';

class ChatModel extends Equatable {
  final String id;
  final List<String> userIds;
  final List<MessageModel> messages;
  final MessageModel? lastMessage;
  final DateTime createdAt;

  const ChatModel({
    required this.id,
    required this.userIds,
    required this.messages,
    this.lastMessage,
    required this.createdAt,
  });

  factory ChatModel.fromCloudFirestore(
    Map<String, dynamic>? data, {
    String? id,
  }) {
    final messages = (data?['messages'] as List? ?? []).map((message) {
      return MessageModel.fromCloudFirestore(message);
    }).toList();

    return ChatModel(
      id: data?['id'] ?? id ?? '',
      userIds: data?['userIds'].cast<String>(),
      messages: messages,
      lastMessage: messages.isNotEmpty ? messages.last : null,
      createdAt: data?['createdAt'].toDate() ?? DateTime.now(),
    );
  }

  Chat toEntity() {
    return Chat(
      id: id,
      userIds: userIds,
      messages: messages.map((message) => message.toEntity()).toList(),
      lastMessage: lastMessage?.toEntity(),
      createdAt: createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userIds,
        messages,
        lastMessage,
        createdAt,
      ];
}
