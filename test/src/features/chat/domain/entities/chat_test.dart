import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Chat entity', () {
    test('empty Chat has correct default values', () {
      expect(Chat.empty.id, equals(''));
      expect(Chat.empty.userIds, equals([]));
      expect(Chat.empty.messages, equals([]));
      expect(Chat.empty.lastMessage, equals(null));
      expect(Chat.empty.createdAt, equals(null));
    });

    test('two Chat instances with different values are not equal', () {
      final createdAt = DateTime.now();
      final chat = Chat(
        id: 'id',
        userIds: const ['userId_0', 'userId_1'],
        messages: const [Message.empty, Message.empty],
        lastMessage: Message.empty,
        createdAt: createdAt,
      );
      final chat2 = Chat(
        id: 'id',
        userIds: const ['userId_0', 'userId_1'],
        messages: const [Message.empty],
        lastMessage: Message.empty,
        createdAt: createdAt,
      );
      expect(chat, isNot(equals(chat2)));
    });

    test('props returns correct properties', () {
      final createdAt = DateTime.now();
      final chat = Chat(
        id: 'id',
        userIds: const ['userId_0', 'userId_1'],
        messages: const [Message.empty, Message.empty],
        lastMessage: Message.empty,
        createdAt: createdAt,
      );

      expect(
        chat.props,
        equals(
          [
            'id',
            ['userId_0', 'userId_1'],
            [Message.empty, Message.empty],
            Message.empty,
            createdAt
          ],
        ),
      );
    });
  });
}
