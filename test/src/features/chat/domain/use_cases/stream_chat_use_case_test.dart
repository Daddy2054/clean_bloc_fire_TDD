import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/use_cases/stream_chat_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stream_chat_use_case_test.mocks.dart';

@GenerateMocks([ChatRepository])
void main() {
  late MockChatRepository mockChatRepository;
  late StreamChatUseCase streamChatUseCase;

  setUp(() {
    mockChatRepository = MockChatRepository();
    streamChatUseCase = StreamChatUseCase(chatRepository: mockChatRepository);
  });

  final createdAt = DateTime.now();
  final tChat = Chat(
    id: '1',
    userIds: const ['1', '2'],
    messages: const [Message.empty],
    lastMessage: Message.empty,
    createdAt: createdAt,
  );

  final tStreamChatParams = StreamChatParams(chatId: '1');

  test(
      'should call streamChat method on the ChatRepository with correct parameters'
      'and return the correct Chat', () async {
    when(mockChatRepository.streamChat(chatId: anyNamed('chatId')))
        .thenAnswer((_) => Stream.value(tChat));

    final chatStream = streamChatUseCase.call(tStreamChatParams);
    final chat = await chatStream.first;
    expect(chat, equals(tChat));
    verify(mockChatRepository.streamChat(chatId: tStreamChatParams.chatId));
  });

  test(
      'should throw an exception when the streamChat method on the ChatRepository throws an exception',
      () async {
    when(mockChatRepository.streamChat(chatId: anyNamed('chatId')))
        .thenThrow(Exception());

    expect(() async => streamChatUseCase.call(tStreamChatParams),
        throwsA(isA<Exception>()));
  });
}
