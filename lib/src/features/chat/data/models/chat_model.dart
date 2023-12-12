import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/chat.dart';
import 'message_model.dart';

part 'chat_model.g.dart';

@HiveType(typeId: 2)
class ChatModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final List<String> userIds;
  @HiveField(2)
  final List<MessageModel> messages;
  @HiveField(3)
  final MessageModel? lastMessage;
  @HiveField(4)
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
