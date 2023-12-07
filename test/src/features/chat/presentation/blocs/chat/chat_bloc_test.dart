import 'package:bloc_test/bloc_test.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/use_cases/send_message_use_case.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/use_cases/stream_chat_use_case.dart';
import 'package:clean_bloc_firebase/src/features/chat/presentation/blocs/chat/chat_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_bloc_test.mocks.dart';

@GenerateMocks([StreamChatUseCase, SendMessageUseCase])
void main() {
  late MockStreamChatUseCase mockStreamChatUseCase;
  late MockSendMessageUseCase mockSendMessageUseCase;

  final tChat = Chat(
    id: '2',
    lastMessage: null,
    messages: const [],
    createdAt: DateTime.now().subtract(const Duration(days: 1)),
    userIds: const [],
  );

  setUp(() {
    mockStreamChatUseCase = MockStreamChatUseCase();
    mockSendMessageUseCase = MockSendMessageUseCase();
  });

  ChatBloc buildBloc() {
    return ChatBloc(
      streamChatUseCase: mockStreamChatUseCase,
      sendMessageUseCase: mockSendMessageUseCase,
    );
  }

  // Test for _onGetChat
  blocTest<ChatBloc, ChatState>(
    'emits [loaded] when chat is successfully fetched',
    setUp: () {
      when(mockStreamChatUseCase.call(any)).thenAnswer(
        (_) => Stream.value(tChat),
      );
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const ChatGetChat(chatId: 'someChatId')),
    expect: () => [
      ChatState(
        status: ChatStatus.loaded,
        chat: tChat,
      ),
    ],
  );

  // Test for _onWriteMessage
  blocTest<ChatBloc, ChatState>(
    'emits [loaded] with updated text when writing a message',
    build: buildBloc,
    act: (bloc) => bloc.add(const ChatWriteMessage(text: 'hello')),
    expect: () => [
      const ChatState(status: ChatStatus.loaded, text: 'hello'),
    ],
  );

  // Test for _onSendMessage
  blocTest<ChatBloc, ChatState>(
    'emits state with empty text and calls SendMessageUseCase when sending a message',
    setUp: () {
      // Mock the sendMessageUseCase to successfully complete
      when(mockSendMessageUseCase.call(any)).thenAnswer((_) async {});
    },
    seed: () => ChatState(
      chat: Chat(
        id: 'chatId',
        lastMessage: null,
        messages: const [],
        createdAt: DateTime
            .now(), // If we compare two chats state, they will be different because of this
        userIds: const ['user1', 'user2'],
      ),
      text: 'Hello',
      status: ChatStatus.loaded,
    ),
    build: () => buildBloc(),
    act: (bloc) => bloc.add(const ChatSendMessage(senderId: 'user1')),
    expect: () => [
      isA<ChatState>().having((state) => state.text, 'text', ''),
    ],
    verify: (_) {
      verify(mockSendMessageUseCase.call(any)).called(1);
    },
  );

  // Additional test for error cases
  blocTest<ChatBloc, ChatState>(
    'emits [error] when fetching chat throws an exception',
    setUp: () {
      when(mockStreamChatUseCase.call(any)).thenThrow(Exception());
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const ChatGetChat(chatId: 'someChatId')),
    expect: () => [
      const ChatState(status: ChatStatus.error),
    ],
  );
}
