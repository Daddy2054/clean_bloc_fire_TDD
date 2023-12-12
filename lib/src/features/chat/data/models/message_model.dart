import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import '../../domain/entities/message.dart';

part 'message_model.g.dart';

@HiveType(typeId: 1)
class MessageModel extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String senderId;
  @HiveField(2)
  final String receiverId;
  @HiveField(3)
  final String text;
  @HiveField(4)
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
