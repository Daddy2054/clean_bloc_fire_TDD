import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:clean_bloc_firebase/src/features/chat/presentation/blocs/chat_list/chat_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tChats = [
    Chat(
      id: 'id',
      userIds: const ['user_1', 'user_2'],
      messages: const [Message.empty],
      lastMessage: null,
      createdAt: DateTime.now(),
    ),
  ];

  group('ChatListState', () {
    test('has a default status of initial and an empty list of chats', () {
      // Act
      const state = ChatListState();

      // Assert
      expect(state.status, ChatListStatus.initial);
      expect(state.chats, isEmpty);
    });

    test('copyWith method should update the status and chats', () {
      // Arrange
      const state = ChatListState();
      const updatedStatus = ChatListStatus.loaded;
      final updatedChats = tChats;

      // Act
      final updatedState = state.copyWith(
        chats: updatedChats,
        status: updatedStatus,
      );

      // Assert
      expect(updatedState.status, updatedStatus);
      expect(updatedState.chats, updatedChats);
    });

    test('props should contain the chats and status', () {
      // Arrange
      const state = ChatListState();
      const updatedStatus = ChatListStatus.loaded;
      final updatedChats = tChats;

      // Act
      final updatedState = state.copyWith(
        chats: updatedChats,
        status: updatedStatus,
      );

      // Assert
      expect(updatedState.props, [updatedChats, updatedStatus]);
    });
  });
}
