import 'package:clean_bloc_firebase/src/features/chat/domain/entities/chat.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/use_cases/stream_chat_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
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

  // test(
  //     'should call streamChat method on the ChatRepository with correct parameters'
  //     'and return the correct Chat', () async {
  //   when(mockChatRepository.streamChat(chatId: anyNamed('chatId')))
  //       .thenAnswer((_) => Stream.value(tChat));

  //   final chatStream = streamChatUseCase.call(tStreamChatParams);
  //   final chat = await chatStream.first;
  //   expect(chat, equals(tChat));
  //   verify(mockChatRepository.streamChat(chatId: tStreamChatParams.chatId));
  // });

  test(
      'should call streamChat method on the ChatRepository with correct parameters'
      'and return the correct Chat', () async {
    when(mockChatRepository.streamChat(chatId: anyNamed('chatId')))
        .thenAnswer((_) => Stream.value(Right(tChat)));

    // Call the use case
    final chatStream = streamChatUseCase.call(tStreamChatParams);

    // Listen to the first event from the stream
    final eitherChat = await chatStream.first;

    // Assert that the first event is an instance of Right
    expect(eitherChat, isA<Right>());

    // If it is Right, assert that the value inside it is equal to tChat
    eitherChat.fold(
      (l) => null,
      (r) => expect(r, equals(tChat)),
    );

    // Verify that the repository's streamChat method was called with the correct parameters
    verify(mockChatRepository.streamChat(chatId: tStreamChatParams.chatId));
  });

  // test(
  //     'should throw an exception when the streamChat method on the ChatRepository throws an exception',
  //     () async {
  //   when(mockChatRepository.streamChat(chatId: anyNamed('chatId')))
  //       .thenThrow(Exception());

  //   expect(() async => streamChatUseCase.call(tStreamChatParams),
  //       throwsA(isA<Exception>()));
  // });

  test(
    'should emit Left with an exception when the streamChat method on the ChatRepository throws an exception',
    () async {
      // Arrange
      when(mockChatRepository.streamChat(chatId: anyNamed('chatId')))
          .thenAnswer((_) => Stream.value(Left(Exception())));

      // Act
      final chatStream = streamChatUseCase.call(tStreamChatParams);

      // Assert
      await expectLater(
        chatStream,
        emits(isA<Left>()),
      );

      // Verify
      verify(mockChatRepository.streamChat(chatId: tStreamChatParams.chatId));
    },
  );
}
