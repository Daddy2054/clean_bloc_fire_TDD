import 'package:bloc_test/bloc_test.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/use_cases/stream_chats_use_case.dart';
import 'package:clean_bloc_firebase/src/features/chat/presentation/blocs/chat_list/chat_list_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'chat_list_bloc_test.mocks.dart';

@GenerateMocks([StreamChatsUseCase])
void main() {
  const userId = '1';
  final tChats = [
    Chat(
      id: '2',
      lastMessage: null,
      messages: const [],
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      userIds: const [],
    ),
    Chat(
      id: '1',
      lastMessage: null,
      messages: const [],
      createdAt: DateTime.now(),
      userIds: const [],
    ),
  ];

  late MockStreamChatsUseCase mockStreamChatsUseCase;

  setUp(() {
    mockStreamChatsUseCase = MockStreamChatsUseCase();
  });

  ChatListBloc buildBloc() {
    return ChatListBloc(streamChatsUseCase: mockStreamChatsUseCase);
  }

  test('Initial state is ChatListState with initial values', () {
    expect(buildBloc().state, const ChatListState());
  });

  blocTest<ChatListBloc, ChatListState>(
    'emits [loaded] when chats are successfully fetched and the chat'
    'list contains at least one chat object',
    setUp: () {
      when(mockStreamChatsUseCase.call(any)).thenAnswer(
        (_) => Stream.value(Right(tChats)),
      );
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const ChatListGetChats(userId: 'someUserId')),
    expect: () => [
      ChatListState(
        chats: tChats,
        status: ChatListStatus.loaded,
      ),
    ],
    verify: (_) {
      return (ChatListState state) {
        if (state.status == ChatListStatus.loaded) {
          // Ensure the chats are sorted in the correct order.
          for (var i = 0; i < state.chats.length - 1; i++) {
            final date1 = state.chats[i].lastMessage?.createdAt ??
                state.chats[i].createdAt;
            final date2 = state.chats[i + 1].lastMessage?.createdAt ??
                state.chats[i + 1].createdAt;
            expect(date1!.isAfter(date2!), isTrue);
          }
        }
      };
    },
  );

  blocTest<ChatListBloc, ChatListState>(
    'emits [error] when fetching posts throws an exception',
    setUp: () {
      when(mockStreamChatsUseCase.call(any))
          .thenAnswer((_) => Stream.value(Left(Exception())));
    },
    build: buildBloc,
    act: (bloc) => bloc.add(const ChatListGetChats(userId: userId)),
    expect: () => [
      const ChatListState(status: ChatListStatus.error),
    ],
  );
}
