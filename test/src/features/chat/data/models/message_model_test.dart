import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clean_bloc_firebase/src/features/chat/data/models/message_model.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const id = 'id_1';
  const senderId = 'sender_1';
  const receiverId = 'receiver_1';
  const text = 'text_1';

  final createdAtTimestamp = Timestamp(1684329114, 0);
  final createdAt = createdAtTimestamp.toDate();

  final messageModel = MessageModel(
    id: id,
    senderId: senderId,
    receiverId: receiverId,
    text: text,
    createdAt: createdAt,
  );

  group('MessageModel', () {
    test('properties are correctly assigned on creation', () {
      expect(messageModel.id, equals(id));
      expect(messageModel.senderId, equals(senderId));
      expect(messageModel.receiverId, equals(receiverId));
      expect(messageModel.text, equals(text));
      expect(messageModel.createdAt, equals(createdAt));
    });

    test('creates MessageModel from Firebase data', () {
      final mockMap = {
        'id': id,
        'senderId': senderId,
        'receiverId': receiverId,
        'text': text,
        'createdAt': createdAtTimestamp,
      };

      final messageModel = MessageModel.fromCloudFirestore(mockMap);

      expect(messageModel.id, equals(id));
      expect(messageModel.senderId, equals(senderId));
      expect(messageModel.receiverId, equals(receiverId));
      expect(messageModel.text, equals(text));
      expect(messageModel.createdAt, equals(createdAt));
    });

    test('creates MessageModel from entity', () {
      final message = Message(
        id: id,
        senderId: senderId,
        receiverId: receiverId,
        text: text,
        createdAt: createdAt,
      );

      final messageModel = MessageModel.fromEntity(message);

      expect(messageModel.id, equals(id));
      expect(messageModel.senderId, equals(senderId));
      expect(messageModel.receiverId, equals(receiverId));
      expect(messageModel.text, equals(text));
      expect(messageModel.createdAt, equals(createdAt));
    });

    test('converts to entity correctly', () {
      final message = messageModel.toEntity();

      expect(message.id, equals(id));
      expect(message.senderId, equals(senderId));
      expect(message.receiverId, equals(receiverId));
      expect(message.text, equals(text));
      expect(message.createdAt, equals(createdAt));
    });

    test('get props returns a list with all properties', () {
      final props = messageModel.props;
      expect(props, containsAll([id, senderId, receiverId, text, createdAt]));
    });
  });
}
