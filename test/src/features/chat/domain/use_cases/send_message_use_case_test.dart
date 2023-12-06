import 'package:clean_bloc_firebase/src/features/chat/domain/entities/message.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/repositories/chat_repository.dart';
import 'package:clean_bloc_firebase/src/features/chat/domain/use_cases/send_message_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'stream_chat_use_case_test.mocks.dart';

@GenerateMocks([ChatRepository])
void main() {
  late MockChatRepository mockChatRepository;
  late SendMessageUseCase sendMessageUseCase;

  setUp(() {
    mockChatRepository = MockChatRepository();
    sendMessageUseCase = SendMessageUseCase(chatRepository: mockChatRepository);
  });

  final tSendMessageParams = SendMessageParams(
    chatId: '1',
    senderId: '1',
    receiverId: '2',
    text: 'Hello',
  );

  test('should add a new message to the ChatRepository', () async {
    // Arrange
    when(mockChatRepository.addMessageToChat(
            chatId: anyNamed('chatId'), message: anyNamed('message')))
        .thenAnswer((_) async {});

    // Act
    await sendMessageUseCase.call(tSendMessageParams);

    // Assert
    verify(mockChatRepository.addMessageToChat(
      chatId: argThat(equals(tSendMessageParams.chatId), named: 'chatId'),
      message: argThat(
        isA<Message>()
            .having(
              (m) => m.senderId,
              'senderId',
              tSendMessageParams.senderId,
            )
            .having(
              (m) => m.receiverId,
              'receiverId',
              tSendMessageParams.receiverId,
            )
            .having(
              (m) => m.text,
              'text',
              tSendMessageParams.text,
            ),
        named: 'message',
      ),
    )).called(1);
  });
}
