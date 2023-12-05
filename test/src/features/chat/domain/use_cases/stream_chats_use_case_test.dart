import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/use_cases/stream_chats_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stream_chats_use_case_test.mocks.dart';

@GenerateMocks([ChatRepository])
void main() {
  late MockChatRepository mockChatRepository;
  late StreamChatsUseCase streamChatsUseCase;

  setUp(() {
    mockChatRepository = MockChatRepository();
    streamChatsUseCase = StreamChatsUseCase(chatRepository: mockChatRepository);
  });

  final createdAt = DateTime.now();
  final tChats = [
    Chat(
      id: '1',
      userIds: const ['1', '2'],
      messages: const [Message.empty],
      lastMessage: Message.empty,
      createdAt: createdAt,
    )
  ];

  final tStreamChatsParams = StreamChatsParams(userId: '1');

  test(
      'should call streamChats method on the ChatRepository with correct parameters'
      'and return the correct list of Chats', () async {
    when(mockChatRepository.streamChats(userId: anyNamed('userId')))
        .thenAnswer((_) => Stream.value(tChats));

    final chatStream = streamChatsUseCase.call(tStreamChatsParams);
    final chat = await chatStream.first;
    expect(chat, equals(tChats));
    verify(mockChatRepository.streamChats(userId: tStreamChatsParams.userId));
  });

  test(
      'should throw an exception when the streamChats method on the ChatRepository'
      'throws an exception', () async {
    when(mockChatRepository.streamChats(userId: anyNamed('userId')))
        .thenThrow(Exception());

    expect(() async => streamChatsUseCase.call(tStreamChatsParams),
        throwsA(isA<Exception>()));
  });
}
