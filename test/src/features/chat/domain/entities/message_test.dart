import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Message entity', () {
    test(
        'should create a Message object with given id, senderId, receiverId, etc.',
        () {
      // Sample data to create the Message object
      const id = '1';
      const senderId = 'senderId';
      const receiverId = 'receiverId';
      const text = 'text';
      final createdAt = DateTime.now();

      // Create a message object
      final message = Message(
        id: id,
        senderId: senderId,
        receiverId: receiverId,
        text: text,
        createdAt: createdAt,
      );

      // Validate if the object is created with the expected values
      expect(message.id, id);
      expect(message.senderId, senderId);
      expect(message.receiverId, receiverId);
      expect(message.text, text);
      expect(message.createdAt, createdAt);
    });

    test('empty Message has correct default values', () {
      expect(Message.empty.id, equals(''));
      expect(Message.empty.senderId, equals(''));
      expect(Message.empty.receiverId, equals(''));
      expect(Message.empty.text, equals(''));
      expect(Message.empty.createdAt, equals(null));
    });

    test('two Message instances with different values are not equal', () {
      final createdAt = DateTime.now();
      final message = Message(
        id: 'id',
        senderId: 'senderId',
        receiverId: 'receiverId',
        text: 'text',
        createdAt: createdAt,
      );
      final message2 = Message(
        id: 'id',
        senderId: 'senderId',
        receiverId: 'receiverId',
        text: 'differentText',
        createdAt: createdAt,
      );
      expect(message, isNot(equals(message2)));
    });

    test('props returns correct properties', () {
      final createdAt = DateTime.now();
      final message = Message(
        id: 'id',
        senderId: 'senderId',
        receiverId: 'receiverId',
        text: 'text',
        createdAt: createdAt,
      );

      expect(
        message.props,
        equals(
          ['id', 'senderId', 'receiverId', 'text', createdAt],
        ),
      );
    });

    test('createdAt can be null', () {
      const message = Message(
        id: 'id',
        senderId: 'senderId',
        receiverId: 'receiverId',
        text: 'text',
      );
      expect(message.createdAt, isNull);
    });
  });
}
