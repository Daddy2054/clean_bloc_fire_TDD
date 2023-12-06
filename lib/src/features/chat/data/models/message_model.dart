import 'package:equatable/equatable.dart';

import '../../domain/entities/message.dart';

class MessageModel extends Equatable {
  final String id;
  final String senderId;
  final String receiverId;
  final String text;
  final DateTime? createdAt;

  const MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
    this.createdAt,
  });

  factory MessageModel.fromCloudFirestore(
    Map<String, dynamic>? data, {
    String? id,
  }) {
    return MessageModel(
      id: data?['id'] ?? id ?? '',
      senderId: data?['senderId'] ?? '',
      receiverId: data?['receiverId'] ?? '',
      text: data?['text'] ?? '',
      createdAt: data?['createdAt'].toDate(),
    );
  }

  factory MessageModel.fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      senderId: message.senderId,
      receiverId: message.receiverId,
      text: message.text,
      createdAt: message.createdAt,
    );
  }

  Message toEntity() {
    return Message(
      id: id,
      senderId: senderId,
      receiverId: receiverId,
      text: text,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
      'createdAt': createdAt,
    };
  }

  @override
  List<Object?> get props => [
        id,
        senderId,
        receiverId,
        text,
        createdAt,
      ];
}
