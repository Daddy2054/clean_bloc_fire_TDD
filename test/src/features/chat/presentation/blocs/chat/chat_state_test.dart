import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:clean_bloc_firebase/src/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tText = 'New message text';
  final tChat = Chat(
    id: 'id',
    userIds: const ['user_1', 'user_2'],
    messages: const [Message.empty],
    lastMessage: null,
    createdAt: DateTime.now(),
  );

  group('ChatState', () {
    test('has a default status of initial, an empty chat, and null text', () {
      // Act
      const state = ChatState();
      // Assert
      expect(state.status, ChatStatus.initial);
      expect(state.chat, Chat.empty);
      expect(state.text, null);
    });

    test('copyWith method should update the status, chat, and text', () {
      // Arrange
      const state = ChatState(status: ChatStatus.loaded);

      // Act
      final updatedState = state.copyWith(
        chat: tChat,
        text: tText,
      );

      // Assert
      expect(updatedState.chat, tChat);
      expect(updatedState.text, tText);
    });

    test('props should contain the chat, status, and text', () {
      final state = ChatState(
        status: ChatStatus.loaded,
        chat: tChat,
        text: tText,
      );

      expect(state.props, [tChat, ChatStatus.loaded, tText]);
    });
  });
}
