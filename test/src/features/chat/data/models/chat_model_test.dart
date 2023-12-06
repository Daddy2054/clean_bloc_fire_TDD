import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:clean_bloc_firebase/src/features/chat/data/models/chat_model.dart';
import 'package:clean_bloc_firebase/src/features/chat/data/models/message_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const id = 'chat_id_1';
  final userIds = ['user_1', 'user_2'];

  final createdAtTimestamp = Timestamp(1684329114, 0);
  final createdAt = createdAtTimestamp.toDate();

  final messages = [
    MessageModel(
      id: 'message_id_1',
      senderId: 'user_1',
      receiverId: 'user_2',
      text: 'Hello',
      createdAt: createdAt,
    )
  ];

  final chatModel = ChatModel(
    id: id,
    userIds: userIds,
    messages: messages,
    lastMessage: messages.last,
    createdAt: createdAt,
  );

  group('ChatModel', () {
    test('properties are correctly assigned on creation', () {
      expect(chatModel.id, equals(id));
      expect(chatModel.userIds, equals(userIds));
      expect(chatModel.messages, equals(messages));
      expect(chatModel.lastMessage, equals(messages.last));
      expect(chatModel.createdAt, equals(createdAt));
    });

    test('creates ChatModel from Firebase data', () {
      final mockData = {
        'userIds': userIds,
        'messages': [
          {
            'id': 'message_id_1',
            'senderId': 'user_1',
            'receiverId': 'user_2',
            'text': 'Hello',
            'createdAt': createdAtTimestamp
          }
        ],
        'createdAt': createdAtTimestamp,
      };

      final chatModel = ChatModel.fromCloudFirestore(mockData, id: id);

      expect(chatModel.id, equals(id));
      expect(chatModel.userIds, equals(userIds));
      expect(chatModel.messages.length, equals(1));
      expect(chatModel.lastMessage, isNotNull);
      expect(chatModel.createdAt, equals(createdAt));
    });

    test('converts to entity correctly', () {
      final chat = chatModel.toEntity();

      expect(chat.id, equals(id));
      expect(chat.userIds, equals(userIds));
      expect(chat.messages.length, equals(1));
      expect(chat.lastMessage, isNotNull);
      expect(chat.createdAt, equals(createdAt));
    });

    test('get props returns a list with all properties', () {
      final props = chatModel.props;
      expect(props,
          containsAll([id, userIds, messages, messages.last, createdAt]));
    });
  });
}
